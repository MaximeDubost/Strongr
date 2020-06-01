import express from "express";

import middleware from "../middleware/middlewares";
import UserController from "../controllers/UserController";
import AppExerciseController from "../controllers/AppExerciseController";
import SessionController from "../controllers/SessionController";
import ExerciseController from "../controllers/ExerciseController";
import ProgramController from "../controllers/ProgramController";
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
router.get("/session/:id_session", middleware.checkAuth, sessionController.getSessionDetail)
router.get("/sessions", middleware.checkAuth, sessionController.getSessions)
router.post("/session", middleware.checkAuth, sessionController.addSession)
router.delete("/session/:id_session", middleware.checkAuth, sessionController.deleteSession)
router.put("/session/:id_session", middleware.checkAuth, sessionController.updateSession)

/**  CRUD Exercise */
router.post("/exercise", middleware.checkAuth, ExerciseController.createExercise);
router.get("/exercises", middleware.checkAuth, ExerciseController.readExercises);
router.get("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.detailExercise);
router.put("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.updateExercise);
router.delete("/exercise/:id_exercise", middleware.checkAuth, ExerciseController.deleteExercise);

/** CRUD Program */
router.get("/program", middleware.checkAuth, ProgramController.readProgram);

export default router;