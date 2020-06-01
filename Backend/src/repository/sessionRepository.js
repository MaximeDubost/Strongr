import Session from '../models/Session';
import SessionDetail from '../models/SessionDetail';
import SessionType from '../models/SessionType';
import ExerciseSession from '../models/ExerciseSession';

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

repository.getSessions = async (req) => {
    let sessionList = []
    var sql = `
    SELECT s.id_session, s.name as name_session, st.name as session_type_name, COUNT(se.id_exercise) as exercise_count, null as tonnage
    FROM _session s
    JOIN _session_type st ON s.id_session_type = st.id_session_type
    JOIN _session_exercise se ON s.id_session = se.id_session
    WHERE s.id_user = $1
    GROUP BY s.id_session, s.name, st.name
    `
    try {
        var result = await clt.query(sql, [req.user.id])
        console.log(result)
        if (result.rowCount != 0) {
            result.rows.map(row => {
                sessionList.push(new Session(row.id_session, row.name_session, row.session_type_name, row.exercise_count, row.tonnage))
            })
        }
        return sessionList
    } catch (error) {
        console.log(error)
    }
}

repository.getSessionDetail = async (req) => {
    let exercises_list = []
    let sql = `
    SELECT s.id_session, st.id_session_type, s.name as session_name, st.name as session_type_name, s.creation_date, s.last_update
    FROM _session s
    JOIN _session_type st ON s.id_session_type = st.id_session_type
    WHERE s.id_user = $1 AND s.id_session = $2
    `
    try {
        let resultSessionType = await clt.query(sql, [req.user.id, req.params.id_session])

        let sessionType = new SessionType(resultSessionType.rows[0].id_session_type, resultSessionType.rows[0].session_type_name)

        sql = `
        SELECT e.id_exercise, e.place, ae.name as app_exercise_name, COUNT(sett.id_set) as set_count, null as tonnage 
        FROM _session s
        JOIN _session_exercise se on s.id_session = se.id_session 
        JOIN _exercise e on se.id_exercise = e.id_exercise 
        JOIN _app_exercise ae on e.id_app_exercise = ae.id_app_exercise
        JOIN _set sett ON e.id_exercise = sett.id_exercise
        WHERE s.id_user = $1 and s.id_session = $2
        GROUP BY e.id_exercise, ae.name, e.place;
        `
        let resultExercises = await clt.query(sql, [req.user.id, req.params.id_session])
        if (resultExercises.rowCount > 0) {
            resultExercises.rows.map(row => {
                let exercise = new ExerciseSession(row.id_exercise, row.place, row.app_exercise_name, row.set_count, row.tonnage)
                exercises_list.push(exercise)
            })
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
    var sqlAddSession = "INSERT INTO _session (id_user, name, creation_date, last_update) VALUES ($1, $2, $3, $4)"
    try {
        await clt.query(sqlAddSession, [req.user.id, req.body.session_name, new Date(), new Date()])
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
    var sqlUpdateSession = "UPDATE _session SET name_session = $1, last_update = $2 WHERE id_user = $3 AND id_session = $4"
    try {
        await clt.query(sqlUpdateSession, [req.body.session_name, new Date(), req.user.id, req.params.id_session])
        return 200
    } catch (error) {
        console.log(error)
        return 501
    }
}


export default repository