import ProgramRepository from "../repository/ProgramRepository";

const controller = {};

controller.readProgram = async (req, res) => {
  let rows = await ProgramRepository.readProgram(req);
  res.status(200).json(rows);
};

controller.readDetailProgram = async (req, res) => {
  let rows = await ProgramRepository.readDetailProgram(req);
  rows.sessions = await ProgramRepository.readSessionDetailProgram(req);
  res.status(200).json(rows);
};

controller.addProgram = async (req, res) => {
  let status = await ProgramRepository.addProgram(req);
  res.sendStatus(status);
};

controller.updateProgram = async (req, res) => {
  let status = await ProgramRepository.updateProgram(req);
  res.sendStatus(status);
};

controller.deleteProgram = async (req, res) => {
  let status = await ProgramRepository.deleteProgram(req);
  res.sendStatus(status);
};

export default controller;
