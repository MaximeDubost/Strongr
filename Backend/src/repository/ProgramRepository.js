import Program from "../Models/Program"
import DetailProgram from "../Models/DetailProgram"
import SessionForProgram from "../Models/SessionForProgram"
import clt from "../core/config/database";
import SessionsForProgram from "../Models/SessionForProgram";

const repository = {};

repository.readProgram = async (req) => {
    let program_list = []
    let sql = `
        SELECT p.id_program, p.name, pg.name as program_goal_name, COUNT(ps.id_program) as session_count, null as tonnage
        FROM _program p
        JOIN _program_goal pg ON pg.id_program_goal = p.id_program_goal
        JOIN _program_session ps ON ps.id_program = p.id_program
        WHERE p.id_user = $1 
        GROUP BY p.id_program, p.name, pg.name
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
    SELECT s.id_session, s.place, st.name as session_type_name,  
    (
        SELECT COUNT(se.id_session) as exercise_count  
        FROM _session s
        JOIN _session_exercise se ON se.id_session = s.id_session
        WHERE s.id_user = $1
    ),  null as tonnage
    FROM _session s
    JOIN _session_type st ON st.id_session_type = s.id_session_type
    WHERE s.id_user = $1
    `
    try {
        var result = await clt.query(sql, [req.user.id])
        return result.rows
    } catch (error) {
        console.log(error)
    }
}


export default repository;