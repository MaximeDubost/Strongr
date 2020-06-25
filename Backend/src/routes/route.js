import express from "express";

import middleware from "../middleware/middlewares";
import UserController from "../controllers/UserController";
import AppExerciseController from "../controllers/AppExerciseController";
import SessionController from "../controllers/SessionController";
import ExerciseController from "../controllers/ExerciseController";
import ProgramController from "../controllers/ProgramController";
import ProgramGoalController from "../controllers/ProgramGoalController";
import SessionTypeController from "../controllers/SessionTypeController"
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
router.get("/user/:id_user", UserController.getUser)
router.put("/user/update/:id_user", UserController.updateUser);
router.delete("/user/delete/:id_user", UserController.deleteUser);

/**
 * AppExercise
 */
router.get("/appexercises", AppExerciseController.getAllAppExercises);
router.get("/appexercise/:id_app_exercise", AppExerciseController.getDetailAppExercise);

/**
 * Exercise
 */
router.post("/exercise", middleware.checkAuth, ExerciseController.createExercise);
router.get("/exercises", middleware.checkAuth, ExerciseController.readExercises);
router.get("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.detailExercise);
router.put("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.updateExercise);
router.delete("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.deleteExercise);
router.all("/exercise/insertForTestDelete", middleware.checkAuth, ExerciseController.testInsertForDeleteExercise);
router.all("/exercise/deleteForTest", middleware.checkAuth, ExerciseController.deleteForTest);
router.all("/exercise/deleteAll/:id_exercise", middleware.checkAuth, ExerciseController.deleteExerciseAll);

/**
 * Session
 */
router.post("/session", middleware.checkAuth, SessionController.addSession);
router.get("/sessions", middleware.checkAuth, SessionController.getSessions);
router.get("/session/:id_session", middleware.checkAuth, SessionController.getSessionDetail);
router.put("/session/:id_session", middleware.checkAuth, SessionController.updateSession);
router.delete("/session/:id_session", middleware.checkAuth, SessionController.deleteSession);

/**
 * Program
 */
router.post("/program", middleware.checkAuth, ProgramController.addProgram);
router.get("/programs", middleware.checkAuth, ProgramController.readProgram);
router.get("/program/:id_program", middleware.checkAuth, ProgramController.readDetailProgram);
router.delete("/program/:id_program", middleware.checkAuth, ProgramController.deleteProgram);

/**
 * Program Goal
 */
router.get("/programgoals", ProgramGoalController.readProgramGoal);

/**
 * Equipement
 */
router.get("/equipments/appexercise/:id_app_exercise", AppExerciseEquipementController.getEquipementByIDAppExercice);
router.get("/equipment/:id_equipment", EquipmentController.getEquipmentByID);

export default router;