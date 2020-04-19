import Muscle from "../Models/Muscle"
import AppExercise from "../Models/AppExercise"

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

repository.getAllAppExercises = async () => {
    var appExList = []
    let sqlGetAllAppExercises = "SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name FROM _app_exercise ae JOIN _targets ta ON ae.id_app_exercise = ta.id_app_exercise JOIN _muscle mu ON ta.id_muscle = mu.id_muscle"
    try {
        var result = await clt.query(sqlGetAllAppExercises);
        console.log(result.rows)
        var exists = false
        var j = 0
        var k = -1
        for (var i = 1; i <= result.rows[result.rows.length - 1].id_app_exercise; i++) {
            result.rows.map((row) => {
                if (i === row.id_app_exercise) {
                    if (!exists) {
                        appExList.push(new AppExercise(row.id_app_exercise, row.exercise_name, []))
                        exists = true
                        k++
                    }
                    //console.log("Avant push muscle ", appExList[j])
                    AppExercise.class(appExList[k]).muscleList.push(new Muscle(row.id_muscle, row.muscle_name))
                    //console.log("Après push muscle ", appExList[j])
                    j++
                }
            })
            exists = false
            j = 0
        }
        return appExList;
    }
    catch (error) {
        console.error(error)
    }
}

repository.searchAppExercise = async (body) => {
    let sqlSearchAppExercise = "SELECT ae.id_app_exercise, ae.name FROM _app_exercise ae WHERE ae.name LIKE $1"
    try {
        var result = await clt.query(sqlSearchAppExercise, ["%" + body.exercise_name + "%"]);
        console.log(result.rows)
        return result.rows
    } catch (error) {
        console.error(error)
    }
}




export default repository;