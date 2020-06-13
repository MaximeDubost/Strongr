import EquipmentRepository from "../repository/EquipmentRepository"

const controller = {};

controller.getEquipmentByID = async (req, res) => {
    let result = await EquipmentRepository.getEquipmentByID(req);
    if (result != 500) {
        res.status(200).json(result);
    } else {
        res.sendStatus(result);
    }
}
export default controller;