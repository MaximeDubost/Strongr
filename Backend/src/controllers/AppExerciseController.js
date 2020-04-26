import AppExerciseRepository from "../repository/AppExerciseRepository"
const controller = {};


controller.getAllAppExercises = async (req, res) => {
    try {
        var rows = await AppExerciseRepository.getAllAppExercises()
        res.status(200).json(rows)
    } catch (error) {
        console.error(error)
    }
}

controller.getDetailAppExercise = async (req, res) => {
    try {
        var rows = await AppExerciseRepository.getDetailAppExercise(req.params)
        res.status(200).json(rows)
    } catch (error) {
        console.error(error)
    }
}

export default controller;