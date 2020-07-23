import Session from '../models/Session';
import SessionDetail from '../models/SessionDetail';
import SessionType from '../models/SessionType';
import ExerciseSession from '../models/ExerciseSession';

import ExerciseRepository from './ExerciseRepository'
import clt from '../core/config/database';

const repository = {};

repository.getSessions = async (req) => {
    let volume = 0
    var sqlgetSession = `
    SELECT s.id_session, s.name as name_session, st.name as session_type_name, COUNT(se.id_exercise) as exercise_count
    FROM _session s
    JOIN _session_type st ON s.id_session_type = st.id_session_type
    JOIN _session_exercise se ON s.id_session = se.id_session
    WHERE s.id_user = $1
    GROUP BY s.id_session, s.name, st.name, s.last_update
    `
    try {

        let sessionId = (await clt.query(`SELECT id_session FROM _session s WHERE id_user = $1::int ORDER BY s.last_update DESC`, [req.user.id])).rows

        let sessionList = []
        for (let index = 0; index < sessionId.length; index++) {
            volume = await repository.getVolume(sessionId[index].id_session, req.user.id)
            var result = await clt.query(sqlgetSession, [req.user.id])
            if (result.rowCount != 0) {
                sessionList.push(new Session(result.rows[index].id_session, result.rows[index].name_session, result.rows[index].session_type_name, result.rows[index].exercise_count, volume))
            }
        }
        return sessionList
    } catch (error) {
        console.log(error)
    }
}

repository.getSessionDetail = async (req) => {
    let exercises_list = []
    let sql = `
    SELECT s.id_session, st.id_session_type, se.place as place, s.name as session_name, st.name as session_type_name, s.creation_date, s.last_update
    FROM _session s
    JOIN _session_type st ON s.id_session_type = st.id_session_type
    JOIN _session_exercise se ON s.id_session = se.id_session
    WHERE s.id_user = $1 AND s.id_session = $2
    `
    try {
        let resultSessionType = await clt.query(sql, [req.user.id, req.params.id_session])

        let sessionType = new SessionType(resultSessionType.rows[0].id_session_type, resultSessionType.rows[0].session_type_name)
        sql = `
        SELECT e.id_exercise, se.place, e.name as name_exercise, ae.name as app_exercise_name, COUNT(sett.id_set) as set_count 
        FROM _session s
        JOIN _session_exercise se on s.id_session = se.id_session 
        JOIN _exercise e on se.id_exercise = e.id_exercise 
        JOIN _app_exercise ae on e.id_app_exercise = ae.id_app_exercise
        JOIN _set sett ON e.id_exercise = sett.id_exercise
        WHERE s.id_user = $1 and s.id_session = $2
        GROUP BY e.id_exercise, se.place, ae.name, e.name
        ORDER BY se.place;
        `
        let resultExercises = await clt.query(sql, [req.user.id, req.params.id_session])
        if (resultExercises.rowCount > 0) {
            for (let index = 0; index < resultExercises.rowCount; index++) {
                const element = resultExercises.rows[index];
                let volume = (await ExerciseRepository.getVolume(element.id_exercise, req.user.id)).volume;
                let exercise = new ExerciseSession(element.id_exercise, element.place, element.name_exercise, element.app_exercise_name, element.set_count, volume)
                exercises_list.push(exercise)
            }
        }
        let data = new SessionDetail(resultSessionType.rows[0].id_session, resultSessionType.rows[0].session_name, sessionType, exercises_list, resultSessionType.rows[0].creation_date, resultSessionType.rows[0].last_update)
        console.log(data)
        return data
    } catch (error) {
        console.log(error)
        return 501
    }
}

repository.addSession = async (req) => {
    // console.log(req.body)
    let sqlAddSession = "INSERT INTO _session (id_user, id_session_type, name, creation_date, last_update) VALUES ($1, $2, $3, $4, $5)"
    try {
        await clt.query(sqlAddSession, [req.user.id, req.body.id_session_type, req.body.name, new Date(), new Date()])
        let sqlGetLastSessionCreated = "SELECT id_session FROM _session WHERE id_user = $1 ORDER BY creation_date DESC"
        let getIdSession = await clt.query(sqlGetLastSessionCreated, [req.user.id])
        req.body.exercises.forEach(async exercise => {
            let parsed_exercise = JSON.parse(exercise)
            let sqlGetIdAppExercise = "SELECT id_app_exercise FROM _exercise WHERE id_exercise = $1"
            let getIdAppExercise = await clt.query(sqlGetIdAppExercise, [parsed_exercise.id])
            let insertInSessionExercise = "INSERT INTO _session_exercise (id_user, id_user_1, id_session, id_exercise, id_app_exercise, place) VALUES ($1, $2, $3, $4, $5, $6)"
            await clt.query(insertInSessionExercise, [req.user.id, req.user.id, getIdSession.rows[0].id_session, parsed_exercise.id, getIdAppExercise.rows[0].id_app_exercise, parsed_exercise.place])
        })
        return 201
    } catch (error) {
        console.log(error)
        return 501
    }
}

repository.deleteSession = async (req) => {
    console.log("BODY : ", req.body)
    var sqlDeleteSession = "DELETE FROM _session WHERE id_user = $1 AND id_session = $2"
    try {
        await clt.query(sqlDeleteSession, [req.user.id, req.params.id_session])
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}

repository.updateSession = async (req) => {
    let session_type_parsed = JSON.parse(req.body.session_type)
    let sql = "UPDATE _session SET name = $1, id_session_type = $2, last_update = $3 WHERE id_user = $4 AND id_session = $5"
    try {
        await clt.query(sql, [req.body.name, session_type_parsed.id, new Date(), req.user.id, req.params.id_session])
        sql = "DELETE FROM _session_exercise WHERE id_user = $1 AND id_user_1 = $2 AND id_session = $3"
        await clt.query(sql, [req.user.id, req.user.id, req.params.id_session])
        sql = "INSERT INTO _session_exercise (id_user, id_user_1, id_session, id_exercise, id_app_exercise, place) VALUES ($1,$2,$3,$4,$5,$6)"
        req.body.exercises.forEach(async exercise => {
            let exercises_parsed = JSON.parse(exercise)
            let result = await clt.query("SELECT id_app_exercise FROM _app_exercise WHERE name = $1", [exercises_parsed.appExerciseName])
            console.log(result);
            await clt.query(sql, [req.user.id, req.user.id, req.params.id_session, exercises_parsed.id, result.rows[0].id_app_exercise, exercises_parsed.place])
        })
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}

repository.getVolume = async (id_session, id_user) => {

    try {
        let res = 0
        let id_exercise_list = await clt.query(
            `
        SELECT se.id_exercise
        FROM _session s
        JOIN _session_exercise se ON s.id_session = se.id_session
        WHERE se.id_session = $1::int AND s.id_user = $2::int
        `,
            [id_session, id_user])
        for (let idx = 0; idx < id_exercise_list.rows.length; idx++) {
            const elemt = id_exercise_list.rows[idx]["id_exercise"];
            //let volume = (await ExerciseRepository.getVolume(elemt, id_user)).volume;
            //let exercisesVolumes = await ExerciseRepository.getVolume(elemt, id_user)
            res += (await ExerciseRepository.getVolume(elemt, id_user)).volume
        }
        return res
    } catch (error) { }

}


export default repository