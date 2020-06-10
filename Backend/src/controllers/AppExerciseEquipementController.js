import AppExerciseEquipementRepository from "../repository/AppExerciseEquipementRepository"

const controller = {};

controller.getEquipementByIDAppExercice = async (req, res) => {
    let result = await AppExerciseEquipementRepository.getEquipementByIDAppExercice(req);
    if (result != 500) {
        res.status(200).json(result)
    } else {
        res.sendStatus(result)
    }
}
export default controller;