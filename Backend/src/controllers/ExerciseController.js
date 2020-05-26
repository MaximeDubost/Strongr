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
    let rows = await ExerciseRepository.createExercise(req)
    //console.log(rows)
    res.status(200).json(rows)
}

/**
 * read all exercises
 */
controller.readExercises = async (req, res) => {
    let rows = await ExerciseRepository.readExercises(req)
    res.status(200).json(rows)
}

/**
 * update user exercise
 */
controller.updateExercise = async (req, res) => {
    let rows = await ExerciseRepository.updateExercise(req)
    res.status(200).json(rows)
}

/**
 * delete user exercise
 */
controller.deleteExercise = async (req, res) => {
    let rows = await ExerciseRepository.deleteExercise(req)
    res.status(200).json(rows)
}

controller.detailExercise = async (req, res) => {
    let rows = await ExerciseRepository.detailExercise(req)
    res.status(200).json(rows)
}

export default controller;