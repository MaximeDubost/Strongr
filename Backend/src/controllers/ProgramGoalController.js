import ProgramGoalRepository from "../repository/ProgramGoalRepository";

const controller = {};

controller.readProgramGoal = async (req, res) => {
  let rows = await ProgramGoalRepository.readProgramGoal(req);
  res.status(200).json(rows);
};

controller.readProgramGoalById = async (req, res) => {
  let rows = await ProgramGoalRepository.readProgramGoalById(req);
  res.status(200).json(rows);
};

export default controller;
