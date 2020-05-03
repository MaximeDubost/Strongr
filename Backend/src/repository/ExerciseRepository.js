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

/**
 * create exercises 
 */
repository.createExercise = async (body) => {
    let sqlCreateExercise = "INSERT INTO _exercise (id_app_exercise, id_user, name, id_equipment, creation_date, last_update) VALUES ($1, $2, $3, $4, $5, $6)"   
    try {       
        await clt.query(sqlCreateExercise, [body.id_app_exercise, body.id_user, body.name, body.id_equipment, body.now, body.now])
    return res = 201;
    }
    catch (error) {
        console.error(error)
    }
}

repository.readExercises = async (req) => {
    console.log('user id = '+req.user.id);
    let sqlReadAllExercices = "SELECT * FROM _exercise WHERE id_user = $1"
    try {
        var result = await clt.query(sqlReadAllExercices,[req.user.id])
        return result;
    } catch(error)
    {
        console.log(error)
    }

}

repository.updateExercise = async (req) => {
    let date = new Date();
    let sqlUpdateExercise = "UPDATE _exercise SET "+ req.body.modify +" = $1, last_update = $2 WHERE id_exercise=$3"
    try {
        await clt.query(sqlUpdateExercise, [req.body.value, date, req.params.id_exercise])
        return res = 201
    } catch(error)
    {
        console.log(error)
    }
}

repository.deleteExercise = async (req) => {
    let sqlDeleteExercise = "DELETE FROM _exercise WHERE id_exercise = $1"
    try {
        await clt.query(sqlDeleteExercise, [req.params.id_exercise])    
        return res = 201
    }catch(error){
        console.log(error)
    }
}




export default repository;