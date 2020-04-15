const { Pool } = require('pg')
var clt = null;
const repository = {};

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'root',
    database: 'StrongrDB'
});

pool.connect((err, client, release) => {
    console.log("In pool connect");
    if (err) {
        return console.error("Error acquiring client", err.stack);
    } else {
        clt = client;
    }
});

repository.getSessionByUserAndSession = async (req) => {
    let res;
    var sqlGetSession = "SELECT * FROM _session WHERE id_user = $1 AND id_session = $2"
    try {
        var result = await clt.query(sqlGetSession, [req.user.id, req.params.id_session])
        console.log(result)
        if (result.rows.length == 0) {
            res = 404
        } else {
            res = result.rows[0]
        }
        return res
    } catch (error) {
        console.log(error)
    }
}

repository.getSessionsByUser = async (req) => {
    let res;
    var sqlGetSessionsByUser = "SELECT * FROM _session WHERE id_user = $1"
    try {
        var result = await clt.query(sqlGetSessionsByUser, [req.user.id])
        console.log(result)
        if (result.rows.length == 0) {
            res = 404
        } else {
            res = result.rows
        }
        return res
    } catch (error) {
        console.log(error)
    }
}

repository.addSession = async (req) => {
    var sqlAddSession = "INSERT INTO _session (id_user, name) VALUES ($1,$2)"
    try {
        await clt.query(sqlAddSession, [req.user.id, req.body.sessionName])
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}

repository.deleteSession = async (req) => {
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
    var sqlUpdateSession = "UPDATE _session SET name_session = $1 WHERE id_user = $2 AND id_session = $3"
    try {
        await clt.query(sqlUpdateSession, [req.body.sessionName, req.user.id, req.params.id_session])
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}


export default repository