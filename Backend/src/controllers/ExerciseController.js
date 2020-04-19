import ExerciseRepository from "../repository/ExerciseRepository"
const { Pool } = require('pg')
var clt = null;
const controller = {};


/**
 * @param id_app_exercise
 * @param id_user
 * @param name
 * @param id_equipment
 */
controller.createExercise = async (req, res) => {
    var rows = await ExerciseRepository.createExercise(req.body)
    //console.log(rows)
    res.status(200).json({ data: rows })
}

/**
 * read all exercises
 */
controller.readExercises = async (req, res) => {
    var rows = await ExerciseRepository.readExercises()
    res.status(200).json({ data: rows.rows })
}

export default controller;