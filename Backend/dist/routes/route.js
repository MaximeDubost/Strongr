"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _express = require("express");

var _express2 = _interopRequireDefault(_express);

var _middlewares = require("../middleware/middlewares");

var _middlewares2 = _interopRequireDefault(_middlewares);

var _UserController = require("../controllers/UserController");

var _UserController2 = _interopRequireDefault(_UserController);

var _AppExerciseController = require("../controllers/AppExerciseController");

var _AppExerciseController2 = _interopRequireDefault(_AppExerciseController);

var _SessionController = require("../controllers/SessionController");

var _SessionController2 = _interopRequireDefault(_SessionController);

var _ExerciseController = require("../controllers/ExerciseController");

var _ExerciseController2 = _interopRequireDefault(_ExerciseController);

var _ProgramController = require("../controllers/ProgramController");

var _ProgramController2 = _interopRequireDefault(_ProgramController);

var _ProgramGoalController = require("../controllers/ProgramGoalController");

var _ProgramGoalController2 = _interopRequireDefault(_ProgramGoalController);

var _SessionTypeController = require("../controllers/SessionTypeController");

var _SessionTypeController2 = _interopRequireDefault(_SessionTypeController);

var _UserProgramController = require("../controllers/UserProgramController");

var _UserProgramController2 = _interopRequireDefault(_UserProgramController);

var _AppExerciseEquipementController = require("../controllers/AppExerciseEquipementController");

var _AppExerciseEquipementController2 = _interopRequireDefault(_AppExerciseEquipementController);

var _EquipmentController = require("../controllers/EquipmentController");

var _EquipmentController2 = _interopRequireDefault(_EquipmentController);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var router = _express2.default.Router();

/**
 * User (Login/Logout)
 */
router.post("/login", _UserController2.default.login);
router.post("/logout", _middlewares2.default.checkAuth, _UserController2.default.logout);

/**
 * User (Reset password)
 */
router.post("/sendCode", _UserController2.default.sendCode);
router.post("/checkCode", _UserController2.default.checkCode);
router.put("/resetPassword", _UserController2.default.resetPassword);
router.post("/checkEmail", _UserController2.default.checkEmail);

/**
 * User
 */
router.post("/user/add", _UserController2.default.register);
router.get("/user/:id_user", _UserController2.default.getUser);
router.put("/user/update/:id_user", _UserController2.default.updateUser);
router.delete("/user/delete/:id_user", _UserController2.default.deleteUser);

/**
 * AppExercise
 */
router.get("/appexercises", _AppExerciseController2.default.getAllAppExercises);
router.get("/appexercise/:id_app_exercise", _AppExerciseController2.default.getDetailAppExercise);
router.get("/appexercises/muscle/:id_muscle", _AppExerciseController2.default.getAppExercisesByIdMuscle);
router.get("/appexercises/equipment/:id_equipment", _AppExerciseController2.default.getAppExercisesByIdEquipment);

/**
 * Exercise
 */
router.post("/exercise", _middlewares2.default.checkAuth, _ExerciseController2.default.createExercise);
router.get("/exercises", _middlewares2.default.checkAuth, _ExerciseController2.default.readExercises);
router.get("/exercise/:id_exercise", _middlewares2.default.checkAuth, _ExerciseController2.default.detailExercise);
router.all("/exercise/:id_exercise", _middlewares2.default.checkAuth, _ExerciseController2.default.updateExercise);
router.delete("/exercise/:id_exercise", _middlewares2.default.checkAuth, _ExerciseController2.default.deleteExercise);

/**
 * Session
 */
router.post("/session", _middlewares2.default.checkAuth, _SessionController2.default.addSession);
router.get("/sessions", _middlewares2.default.checkAuth, _SessionController2.default.getSessions);
router.get("/session/:id_session", _middlewares2.default.checkAuth, _SessionController2.default.getSessionDetail);
router.all("/session/:id_session", _middlewares2.default.checkAuth, _SessionController2.default.updateSession);
router.delete("/session/:id_session", _middlewares2.default.checkAuth, _SessionController2.default.deleteSession);

/**
 * Program
 */
router.post("/program", _middlewares2.default.checkAuth, _ProgramController2.default.addProgram);
router.get("/programs", _middlewares2.default.checkAuth, _ProgramController2.default.readProgram);
router.get("/program/:id_program", _middlewares2.default.checkAuth, _ProgramController2.default.readDetailProgram);
router.delete("/program/:id_program", _middlewares2.default.checkAuth, _ProgramController2.default.deleteProgram);
router.all("/program/:id_program", _middlewares2.default.checkAuth, _ProgramController2.default.updateProgram);

/**
 * Program Goal
 */
router.get("/programgoals", _ProgramGoalController2.default.readProgramGoal);
router.get("/programgoal/:id_program_goal", _ProgramGoalController2.default.readProgramGoalById);

/**
 * Equipement
 */
router.get("/equipments/appexercise/:id_app_exercise", _AppExerciseEquipementController2.default.getEquipementByIDAppExercice);
router.get("/equipment/:id_equipment", _EquipmentController2.default.getEquipmentByID);

exports.default = router;
//# sourceMappingURL=route.js.map