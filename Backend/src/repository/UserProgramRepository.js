import clt from "../core/config/database";
const repository = {};


repository.createUserProgram = async (req) => {
    let res;
    let sql = "INSERT INTO _program (name, creation_date, last_update, id_program_goal, id_user) VALUES ($1, $2, $3, $4, $5)"
    try {
        let result = await clt.query(sql, [req.body.name_program, new Date(), new Date(), req.body.id_program_goal, req.user.id])
        console.log(result)
        sql = "SELECT * FROM _program ORDER BY creation_date DESC"
        result = await clt.query(sql)
        let id_lastprogram = result.rows[0].id_program
        sql = "INSERT INTO _program_session (id_user, id_program, id_user_1, id_session) VALUES ($1, $2, $3, $4)"
        await clt.query(sql, [req.user.id, id_lastprogram, req.user.id, req.body.id_session])
        res = 201
        return res
    } catch (error) {
        console.log(error)
        return 500
    }
}

repository.getUserProgram = async (req) => {
    let sql = "SELECT * FROM _program WHERE id_user = $1"
    try {
        let result = await clt.query(sql, [req.user.id])
        return result.rows
    } catch (error) {
        console.log(error)
        return 500
    }
}

repository.updateUserProgram = async (req) => {
    let sql = "UPDATE _program SET id_program_goal = $1, name = $2, last_update = $3 WHERE id_program = $4"
    try {
        await clt.query(sql, [req.body.id_program_goal, req.body.name_program, new Date(), req.params.id_program])
        return 200
    } catch (error) {
        console.log(error)
        return 500
    }
}

/**
 * Trigger donc temporaire
 */
repository.deleteUserProgram = async (req) => {
    let sql = "DELETE FROM _program WHERE id_program = $1"
    try {
        await clt.query(sql, [req.params.id_program])
        return 200
    } catch (error) {
        console.log(error)
        return 500
    }
}

export default repository