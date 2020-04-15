import AppExerciseRepository from "../repository/AppExerciseRepository"
const { Pool } = require('pg')
var clt = null;
const controller = {};

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
 * 
 */
controller.getAllAppExercises = async (req, res, next) => {
    var rows = await AppExerciseRepository.getAllAppExercises()
    res.status(200).json({ data: rows })
}

export default controller;