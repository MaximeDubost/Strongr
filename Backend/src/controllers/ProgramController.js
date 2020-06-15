import ProgramRepository from "../repository/ProgramRepository"
const { Pool } = require('pg')
var clt = null;
const controller = {};

controller.readProgram = async (req, res) => {
    let rows = await ProgramRepository.readProgram(req)
    res.status(200).json(rows)
}

controller.readDetailProgram = async (req, res) => {
    let rows = await ProgramRepository.readDetailProgram(req)
    rows.sessions = await ProgramRepository.readSessionDetailProgram(req)
    res.status(200).json(rows)
}

controller.addProgram = async (req, res) => {
    let status = await ProgramRepository.addProgram(req)
    res.sendStatus(status)
}

export default controller;