import express from "express";

import middleware from "../middleware/middlewares";
import UserController from "../controllers/UserController";
import AppExerciseController from "../controllers/AppExerciseController";
import SessionController from "../controllers/SessionController";
import ExerciseController from "../controllers/ExerciseController";
import ProgramController from "../controllers/ProgramController";
import ProgramGoalController from "../controllers/ProgramGoalController";
import SessionTypeController from "../controllers/SessionTypeController";
import UserProgramPreviewController from "../controllers/UserProgramController";
import AppExerciseEquipementController from "../controllers/AppExerciseEquipementController";
import EquipmentController from "../controllers/EquipmentController";

let router = express.Router();

/**
 * User (Login/Logout)
 */
router.post("/login", UserController.login);
router.post("/logout", middleware.checkAuth, UserController.logout);

/**
 * User (Reset password)
 */
router.post("/sendCode", UserController.sendCode);
router.post("/checkCode", UserController.checkCode);
router.put("/resetPassword", UserController.resetPassword);
router.post("/checkEmail", UserController.checkEmail);

/**
 * User
 */
router.post("/user/add", UserController.register);
router.get("/user/:id_user", UserController.getUser);
router.put("/user/update/:id_user", UserController.updateUser);
router.delete("/user/delete/:id_user", UserController.deleteUser);

/**
 * AppExercise
 */
router.get("/appexercises", AppExerciseController.getAllAppExercises);
router.get(
  "/appexercise/:id_app_exercise",
  AppExerciseController.getDetailAppExercise
);
router.get(
  "/appexercises/muscle/:id_muscle",
  AppExerciseController.getAppExercisesByIdMuscle
);
router.get(
  "/appexercises/equipment/:id_equipment",
  AppExerciseController.getAppExercisesByIdEquipment
);

/**
 * Exercise
 */
router.post(
  "/exercise",
  middleware.checkAuth,
  ExerciseController.createExercise
);
router.get(
  "/exercises",
  middleware.checkAuth,
  ExerciseController.readExercises
);
router.get(
  "/exercise/:id_exercise",
  middleware.checkAuth,
  ExerciseController.detailExercise
);
router.all(
  "/exercise/:id_exercise",
  middleware.checkAuth,
  ExerciseController.updateExercise
);
router.delete(
  "/exercise/:id_exercise",
  middleware.checkAuth,
  ExerciseController.deleteExercise
);

router.post(
  "/exercises/targetmuscles",
  middleware.checkAuth,
  ExerciseController.getExerciseMusclesTarget
);

/**
 * Session
 */
router.post("/session", middleware.checkAuth, SessionController.addSession);
router.get("/sessions", middleware.checkAuth, SessionController.getSessions);
router.get(
  "/session/:id_session",
  middleware.checkAuth,
  SessionController.getSessionDetail
);
router.all(
  "/session/:id_session",
  middleware.checkAuth,
  SessionController.updateSession
);
router.delete(
  "/session/:id_session",
  middleware.checkAuth,
  SessionController.deleteSession
);

/**
 * Session Type
 */
router.get(
  "/sessiontype/:id_session_type",
  SessionTypeController.readSessionTypeById
);

/**
 * Program
 */
router.post("/program", middleware.checkAuth, ProgramController.addProgram);
router.get("/programs", middleware.checkAuth, ProgramController.readProgram);
router.get(
  "/program/:id_program",
  middleware.checkAuth,
  ProgramController.readDetailProgram
);
router.delete(
  "/program/:id_program",
  middleware.checkAuth,
  ProgramController.deleteProgram
);
router.all(
  "/program/:id_program",
  middleware.checkAuth,
  ProgramController.updateProgram
);

/**
 * Program Goal
 */
router.get("/programgoals", ProgramGoalController.readProgramGoal);
router.get(
  "/programgoal/:id_program_goal",
  ProgramGoalController.readProgramGoalById
);

/**
 * Equipement
 */
router.get(
  "/equipments/appexercise/:id_app_exercise",
  AppExerciseEquipementController.getEquipementByIDAppExercice
);
router.get("/equipment/:id_equipment", EquipmentController.getEquipmentByID);

export default router;
