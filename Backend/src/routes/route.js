import express from "express";

import middleware from "../middleware/middlewares";
import userController from "../controllers/userController";
import exerciseController from "../controllers/exerciseController";
import sessionController from "../controllers/sessionController";
let router = express.Router();

/** CRUD + LOGIN user */
router.post("/user/add", userController.register);
router.get("/user/:id_user", userController.getUser)
router.put("/user/update/:id_user", userController.updateUser);
router.delete("/user/delete/:id_user", userController.deleteUser);
router.post("/login", userController.login);
router.post("/logout", middleware.checkAuth, userController.logout);
router.post("/sendCode", userController.sendCode);
router.post("/checkCode", userController.checkCode);
router.put("/resetPassword", userController.resetPassword);
router.post("/checkEmail", userController.checkEmail);

router.get("/exercises", exerciseController.getAllExercises);

/**  CRUD Session */
router.get("/session/:id_session", middleware.checkAuth, sessionController.getSessionByUserAndSession)
router.get("/sessions", middleware.checkAuth, sessionController.getSessionsByUser)
router.post("/session", middleware.checkAuth, sessionController.addSession)
router.delete("/session/:id_session", middleware.checkAuth, sessionController.deleteSession)
router.put("/session/:id_session", middleware.checkAuth, sessionController.updateSession)

export default router;

