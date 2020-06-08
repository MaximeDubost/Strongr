import SessionTypeRepository from "../repository/SessionTypeRepository"
const controller = {};

controller.readSessionType = async (req, res) => {
    let rows = await SessionTypeRepository.readSessionType(req)
    res.status(200).json(rows)
}

export default controller;