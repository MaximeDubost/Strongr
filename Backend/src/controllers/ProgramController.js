import ProgramRepository from "../repository/ProgramRepository"
const { Pool } = require('pg')
var clt = null;
const controller = {};

controller.readProgram = async (req, res) => {
    let rows = await ProgramRepository.readProgram(req)
    res.status(200).json(rows)
}

export default controller;