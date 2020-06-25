import AppExercise from "../Models/AppExercise"
import Exercise from "../Models/Exercise"
import Set from "../Models/Set"
import DetailExercise from "../Models/DetailExercise"
import clt from "../core/config/database";
import { json } from "express";

const repository = {};

/**
 * create exercises 
 */
repository.createExercise = async (req) => {
    console.log(req.body)
    let date = new Date();
    let sqlCreateExercise = "INSERT INTO _exercise (id_app_exercise, id_user, name, id_equipment, creation_date, last_update) VALUES ($1, $2, $3, $4, $5, $6)"
    let sqlGetIdExercise = "SELECT id_exercise FROM _exercise WHERE id_user = $1 ORDER BY creation_date DESC LIMIT 1"
    try {
        await clt.query(sqlCreateExercise, [req.body.id_app_exercise, req.user.id, req.body.name, req.body.id_equipment, date, date])
        let result = await clt.query(sqlGetIdExercise, [req.user.id])

        req.body.sets.forEach(async set => {
            let parsed_set = JSON.parse(set)
            let sqlAddSet = `INSERT INTO _set (id_app_exercise, id_user, id_exercise, repetitions_count, rest_time, place) VALUES ($1, $2, $3, $4, $5, $6)`
            await clt.query(sqlAddSet, [req.body.id_app_exercise, req.user.id, result.rows[0].id_exercise, parsed_set.repetitions_count, parsed_set.rest_time, parsed_set.place])
        })
        return 201;
    }
    catch (error) {
        console.error(error)
    }
}
/// READ
repository.readExercises = async (req) => {
    let exercise_list = []
    let sqlReadAllExercices = `
    SELECT e.id_exercise, e.name as name_exercise, ae.name as name_app_exercise, COUNT(s.id_set) as set_count, null as tonnage
    FROM _exercise e
    JOIN _app_exercise ae ON ae.id_app_exercise = e.id_app_exercise
    JOIN _set s ON s.id_exercise = e.id_exercise
    WHERE e.id_user = $1
    GROUP BY e.id_exercise, e.name, ae.name, e.last_update
    ORDER BY e.last_update DESC
    `
    try {
        var result = await clt.query(sqlReadAllExercices, [req.user.id])
        if (result.rowCount > 0) {
            result.rows.forEach((row) => {
                exercise_list.push(new Exercise(row.id_exercise, row.name_exercise, row.name_app_exercise, row.set_count, row.tonnage))
            })
        }

        return exercise_list
    } catch (error) {
        console.log(error)
    }

}

/// UPDATE
repository.updateExercise = async (req) => {
    let date = new Date();
    let sqlUpdateExercise = "UPDATE _exercise SET id_app_exercise=$1, name=$2, id_equipment=$3, last_update=$4 WHERE id_exercise=$5 AND id_user=$6"
    try {
        await clt.query(sqlUpdateExercise, [req.body.id_app_exercise, req.body.name, req.body.id_equipment, date, req.params.id_exercise, req.user.id])
        return 200
    } catch (error) {
        console.log(error)
    }
}

/// DELETE
repository.deleteExercise = async (req) => {
    let sqlDeleteExercise = "DELETE FROM _exercise WHERE id_exercise = $1 AND id_user = $2"
    try {
        await clt.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id])
        return 200
    } catch (error) {
        console.log(error)
    }
}

repository.detailExercise = async (req) => {
    let set_list = []
    let sql = `
    SELECT id_set, place, repetitions_count, rest_time, null as tonnage
    FROM _set s 
    WHERE s.id_exercise = $1;
    `
    try {

        let result = await clt.query(sql, [req.params.id_exercise])
        if (result.rowCount > 0) {
            result.rows.forEach(row => {
                set_list.push(new Set(row.id_set, row.place, row.repetitions_count, row.rest_time, row.tonnage))
            })
        }
        sql = `
        SELECT e.id_exercise, e.name as name_exercise, ae.id_app_exercise, ae.name as name_app_exercise, e.creation_date, e.last_update
        FROM _exercise e
        JOIN _app_exercise ae ON ae.id_app_exercise = e.id_app_exercise
        WHERE e.id_exercise = $1;
        `
        result = await clt.query(sql, [req.params.id_exercise])
        // console.log("result.rows: ", result.rows)
        let app_exercise = new AppExercise(result.rows[0].id_app_exercise, result.rows[0].name_app_exercise)
        // console.log("app_exercise: ", app_exercise)
        return new DetailExercise(result.rows[0].id_exercise, result.rows[0].name_exercise, app_exercise, set_list, result.rows[0].creation_date, result.rows[0].last_update)

    } catch (error) {
        console.log(error)
    }
}

repository.testInsertForDeleteExercise = async (req) => {
    let sqlInsert1 = `
    INSERT INTO _exercise (id_app_exercise, id_user, id_equipment, name, creation_date, last_update)
    VALUES (8, 1, 3, 'deleteExercise', '2020-06-14 22:50:36.342', '2020-06-14 22:50:36.342');
    
    INSERT INTO _session (id_user, id_session_type, name, creation_date, last_update)
    VALUES (1, 3, 'deleteSession', '2020-06-14 22:50:36.342', '2020-06-14 22:50:36.342');
    
    INSERT INTO _program (id_user, id_program_goal, name, creation_date, last_update)
    VALUES (1, 3, 'deleteProgram','2020-06-14 22:50:36.342', '2020-06-14 22:50:36.342');
    `

    let sqlGetFromExercise = `
    SELECT id_exercise, id_app_exercise FROM _exercise WHERE name = 'deleteExercise'
    `

    let sqlGetFromSession = `
    SELECT id_session FROM _session WHERE name = 'deleteSession'
    `

    let sqlGetFromProgram = `
    SELECT id_program FROM _program WHERE name = 'deleteProgram'
    `

    let sqlInsert2 = `
    INSERT INTO _session_exercise (id_user, id_user_1, id_session, id_exercise, id_app_exercise, place)
    VALUES (1, 1, $1, $2, $3, 1);

    `
    let sqlInsert3 = `
    INSERT INTO _program_session (id_user, id_user_1, id_program, id_session, place)
    VALUES (1, 1, $1, $2, 1);
    `
    try {
        // requête
        await clt.query(sqlInsert1, [])
        let resultExercise = await clt.query(sqlGetFromExercise, [])
        let resultSession = await clt.query(sqlGetFromSession, [])
        let resultProgram = await clt.query(sqlGetFromProgram, [])

        // variable 
        let id_exercise = resultExercise.rows[0].id_exercise
        let id_app_exercise = resultExercise.rows[0].id_app_exercise
        let id_session = resultSession.rows[0].id_session
        let id_program = resultProgram.rows[0].id_program

        // requête part 2 
        await clt.query(sqlInsert2, [id_session, id_exercise, id_app_exercise])
        await clt.query(sqlInsert3, [id_program, id_session])

        // console.log 
        console.log("id_exercise = "+id_exercise)
        console.log("id_app_exercise = "+id_app_exercise)
        console.log("id_session = "+id_session)
        console.log("id_program = "+id_program)
        return 201;
    }
    catch (error) {
        console.error(error)
    }
}

repository.deleteForTest = async (req) => {
    let sqlGetFromExercise = `
    SELECT id_exercise FROM _exercise WHERE name = 'deleteExercise'
    `

    let sqlGetFromSession = `
    SELECT id_session FROM _session WHERE name = 'deleteSession'
    `

    let sqlFirst = `
    DELETE FROM _session_exercise WHERE id_exercise = $1
    `
    let sqlSecond = `
    DELETE FROM _program_session WHERE id_session = $1
    `
    
    let sql = `
    DELETE FROM _exercise WHERE name = 'deleteExercise';
    DELETE FROM _session  WHERE name = 'deleteSession';
    DELETE FROM _program WHERE name = 'deleteProgram';    
    `
    try {
        let resultExercise = await clt.query(sqlGetFromExercise, [])
        let resultSession = await clt.query(sqlGetFromSession, [])
        let id_exercise = resultExercise.rows[0].id_exercise
        let id_session = resultSession.rows[0].id_session
        await clt.query(sqlFirst, [id_exercise])
        await clt.query(sqlSecond, [id_session])
        await clt.query(sql, [])
        return 201;
    }
    catch (error) {
        console.error(error)
    }
}

repository.deleteExerciseAll = async (req) => {
    let sqlGetSession = `
    SELECT id_session FROM _session_exercise WHERE id_exercise = $1 AND id_user = $2
    `

    let sqlGetAllExerciseFromSession = `
    SELECT id_exercise FROM _session_exercise WHERE id_session = $1 AND id_user = $2
    `

    let sqlGetProgram = `
    SELECT id_program FROM _program_session WHERE id_session = $1 and id_user = $2
    `

    let sqlGetAllSessionFromProgram = `
    SELECT id_session FROM _program_session WHERE id_program = $1 AND id_user = $2
    `

    let sqlDeleteSessionExercise = `
    DELETE FROM _session_exercise WHERE id_exercise = $1 AND id_user = $2
    `

    let sqlDeleteProgramSession = `
    DELETE FROM _program_session WHERE id_session = $1 AND id_user = $2
    `

    let sqlDeleteExercise = `
    DELETE FROM _exercise WHERE id_exercise = $1 AND id_user = $2
    `

    let sqlDeleteSession = `
    DELETE FROM _session WHERE id_session = $1 AND id_user = $2
    `

    let sqlDeleteProgram = `
    DELETE FROM _program WHERE id_program = $1 AND id_user = $2
    `

    try {
        let resultForIdSession = await clt.query(sqlGetSession, [req.params.id_exercise, req.user.id])
        let allSession = resultForIdSession.rows[0].id_session
        resultForIdSession.rows.forEach(async row => {
            let resultAnyExercise = await clt.query(sqlGetAllExerciseFromSession, [row.id_session, req.user.id])
            let allExercise = resultAnyExercise.rows
            if (allExercise.length !== 1)
            {
                allExercise.forEach(async exercise => { // NON TESTE POUR L'INSTANT
                            await clt.query(sqlDeleteSessionExercise, [exercise.id_exercise, req.user.id])
                            await clt.query(sqlDeleteExercise, [exercise.id_exercise, req.user.id])
                        })
            } else 
            {
                let resultForIdProgram = await clt.query(sqlGetProgram, [row.id_session, req.user.id])
                resultForIdProgram.rows.forEach(async r => {
                    let resultAnySession = await clt.query(sqlGetAllSessionFromProgram, [r.id_program, req.user.id])
                    let allSession = resultAnySession.rows
                    if (allSession.length !== 1)
                    {
                        allSession.forEach(async session => { // NON TESTE POUR L'INSTANT
                            await clt.query(sqlDeleteSessionExercise, [allExercise[0].id_exercise, req.user.id])
                            await clt.query(sqlDeleteProgramSession, [session.id_session, req.user.id])
                            await clt.query(sqlDeleteExercise, [allExercise[0].id_exercise, req.user.id])
                            await clt.query(sqlDeleteSession, [session.id_session, req.user.id])
                        })
                    }else
                    {
                        await clt.query(sqlDeleteSessionExercise, [allExercise[0].id_exercise, req.user.id])
                        await clt.query(sqlDeleteProgramSession, [allSession[0].id_session, req.user.id])
                        await clt.query(sqlDeleteExercise, [allExercise[0].id_exercise, req.user.id])
                        await clt.query(sqlDeleteSession, [allSession[0].id_session, req.user.id])
                        await clt.query(sqlDeleteProgram, [r.id_program, req.user.id])
                    }
                })
            }
        })
        return 201;
    }
    catch (error) {
        console.error(error)
    }


}

export default repository;