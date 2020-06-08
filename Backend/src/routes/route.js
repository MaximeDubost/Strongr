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
let router = express.Router();

/** CRUD + LOGIN user */
router.post("/user/add", UserController.register);
router.get("/user/:id_user", UserController.getUser)
router.put("/user/update/:id_user", UserController.updateUser);
router.delete("/user/delete/:id_user", UserController.deleteUser);
router.post("/login", UserController.login);
router.post("/logout", middleware.checkAuth, UserController.logout);
router.post("/sendCode", UserController.sendCode);
router.post("/checkCode", UserController.checkCode);
router.put("/resetPassword", UserController.resetPassword);
router.post("/checkEmail", UserController.checkEmail);

/** Read only AppExercise */
router.get("/appexercises", AppExerciseController.getAllAppExercises);
router.get("/appexercise/:id_app_exercise", AppExerciseController.getDetailAppExercise);

/**  CRUD Session */
router.get("/session/:id_session", middleware.checkAuth, SessionController.getSessionDetail);
router.get("/sessions", middleware.checkAuth, SessionController.getSessions);
router.post("/session", middleware.checkAuth, SessionController.addSession);
router.delete("/session/:id_session", middleware.checkAuth, SessionController.deleteSession);
router.put("/session/:id_session", middleware.checkAuth, SessionController.updateSession);

/**  CRUD Exercise */
router.post("/exercise", middleware.checkAuth, ExerciseController.createExercise);
router.get("/exercises", middleware.checkAuth, ExerciseController.readExercises);
router.get("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.detailExercise);
router.put("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.updateExercise);
router.delete("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.deleteExercise);

/** CRUD Program */
router.get("/programs", middleware.checkAuth, ProgramController.readProgram);
router.get("/program_goal", middleware.checkAuth, ProgramGoalController.readProgramGoal);

/** CRUD ProgramsPreview */
router.get("/programspreview", middleware.checkAuth, UserProgramPreviewController.getProgramsPreview);

/** Read-only Session Type */
router.get("/session_type", middleware.checkAuth, SessionTypeController.readSessionType);

export default router;