import Program from "../Models/Program"
import clt from "../core/config/database";

const repository = {};

repository.readProgram = async (req) => {
    let program_list = []
    let sql = `
        SELECT p.id_program, p.name, pg.name as program_goal_name, COUNT(ps.id_program) as session_count, null as tonnage
        FROM _program p
        JOIN _program_goal pg ON pg.id_program_goal = p.id_program_goal
        JOIN _program_session ps ON ps.id_program = p.id_program
        WHERE p.id_user = $1 
        GROUP BY p.id_program, p.name, pg.name, p.last_update
        ORDER BY p.last_update DESC
    `
    try {
        var result = await clt.query(sql, [req.user.id])
        if (result.rowCount > 0) {
            result.rows.forEach((row) => {
                program_list.push(new Program(row.id_program, row.name, row.program_goal_name, row.session_count, row.tonnage))
            })
        }
        console.log(program_list)
        return program_list
    } catch (error) {
        console.log(error)
    }

}

repository.readDetailProgram = async (req) => {

    //console.log('req user id = '+req.user.id)
    //console.log('id_program = '+req.params.id_program)

    let sql = `
    SELECT p.id_program as id, p.name, p.creation_date, p.last_update
    FROM _program p
    JOIN _program_session ps ON ps.id_program = p.id_program
    WHERE p.id_user = $1 AND p.id_program = $2
    GROUP BY p.id_program, p.name, p.creation_date, p.last_update
    `

    let program_sql = `
    SELECT pg.id_program_goal as id, pg.name as name
    FROM _program p
    JOIN _program_goal pg ON pg.id_program_goal = p.id_program_goal
    JOIN _program_session ps ON ps.id_program = p.id_program
    WHERE p.id_user = $1 AND p.id_program = $2
    GROUP BY pg.name, pg.id_program_goal
    `
    try {
        var result = await clt.query(sql, [req.user.id, req.params.id_program])
        var program_goal_result = await clt.query(program_sql, [req.user.id, req.params.id_program])
        result.rows[0].program_goal = program_goal_result.rows[0]
        return result.rows[0]
    } catch (error) {
        console.log(error)
    }


}

repository.readSessionDetailProgram = async (req) => {

    let sql = `
    SELECT s.id_session as id, ps.place, s.name, st.name as session_type_name,  
    (
        SELECT COUNT(se.id_session) as exercise_count  
        FROM _session s
        JOIN _session_exercise se ON se.id_session = s.id_session
		JOIN _program_session ps ON ps.id_session = s.id_session
        WHERE s.id_user = $1 AND ps.id_program = $2
    ),  null as tonnage
    FROM _session s
    JOIN _session_type st ON st.id_session_type = s.id_session_type
	JOIN _program_session ps ON ps.id_session = s.id_session
    WHERE s.id_user = $1 AND ps.id_program = $2
    ORDER BY place
    `
    try {
        var result = await clt.query(sql, [req.user.id, req.params.id_program])
        return result.rows
    } catch (error) {
        console.log(error)
    }
}

repository.addProgram = async (req) => {
    let sqlAddProgram = "INSERT INTO _program (id_user, id_program_goal, name, creation_date, last_update) VALUES ($1, $2, $3, $4, $5)"
    try {
        await clt.query(sqlAddProgram, [req.user.id, req.body.id_program_goal, req.body.name, new Date(), new Date()])
        let sqlLastProgramCreated = "SELECT id_program FROM _program WHERE id_user = $1 ORDER BY creation_date DESC"
        let getIdProgram = await clt.query(sqlLastProgramCreated, [req.user.id])
        req.body.sessions.forEach(async session => {
            let parsed_session = JSON.parse(session)
            let insertInProgramSession = "INSERT INTO _program_session (id_user, id_user_1, id_program, id_session, place) VALUES ($1, $2, $3, $4, $5)"
            await clt.query(insertInProgramSession, [req.user.id, req.user.id, getIdProgram.rows[0].id_program, parsed_session.id, parsed_session.place])
        })
        return 201
    } catch (error) {
        console.log(error)
    }
}

repository.deleteProgram = async (req) => {
    let sqlAddProgram = "DELETE FROM _program WHERE id_program = $1 AND id_user = $2"
    try {
        await clt.query(sqlAddProgram, [req.params.id_program, req.user.id])
        return 200
    } catch (error) {
        console.log(error)
    }
}

repository.updateProgram = async (req) => {
    console.log(req.body)
    let sql = "SELECT id_program_goal FROM _program_goal WHERE name = $1";
    try {
        let result = await clt.query(sql, [req.body.program_goal_name])
        sql = "UPDATE _program SET name = $1, last_update = $2, id_program_goal = $3 WHERE id_program = $4 AND id_user = $5"
        await clt.query(sql, [req.body.name, new Date(), result.rows[0].id_program_goal, req.params.id_program, req.user.id])
        sql = "DELETE FROM _program_session WHERE id_user = $1 AND id_user_1 = $2 AND id_program = $3"
        await clt.query(sql, [req.user.id, req.user.id, req.params.id_program])
        req.body.sessions.forEach(async session => {
            let session_parsed = JSON.parse(session)
            sql = "INSERT INTO _program_session (id_user, id_user_1, id_program, id_session, place) VALUES ($1,$2,$3,$4,$5)"
            await clt.query(sql, [req.user.id, req.user.id, req.params.id_program, session_parsed.id, session_parsed.place])
        })
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}


export default repository;