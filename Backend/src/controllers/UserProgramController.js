import UserProgramRepository from "../repository/UserProgramRepository"

const controller = {};

controller.createUserProgram = async (req, res) => {
    let status = await UserProgramRepository.createUserProgram(req);
    res.sendStatus(status)
}

controller.getUserProgram = async (req, res) => {
    let result = await UserProgramRepository.getUserProgram(req);
    if (result != 500) {
        res.status(200).json(result)
    } else {
        res.sendStatus(result)
    }
}

controller.updateUserProgram = async (req, res) => {
    let status = await UserProgramRepository.updateUserProgram(req);
    res.sendStatus(status)
}

controller.deleteUserProgram = async (req, res) => {
    let status = await UserProgramRepository.deleteUserProgram(req);
    res.sendStatus(status)
}

export default controller;