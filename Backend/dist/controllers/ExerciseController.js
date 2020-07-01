"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _ExerciseRepository = require("../repository/ExerciseRepository");

var _ExerciseRepository2 = _interopRequireDefault(_ExerciseRepository);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var controller = {};

/**
 * create exercise
 *
 * @param id_app_exercise
 * @param id_user
 * @param name
 * @param id_equipment
 */
controller.createExercise = function () {
  var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req, res) {
    var status;
    return regeneratorRuntime.wrap(function _callee$(_context) {
      while (1) {
        switch (_context.prev = _context.next) {
          case 0:
            _context.next = 2;
            return _ExerciseRepository2.default.createExercise(req);

          case 2:
            status = _context.sent;

            res.sendStatus(status);

          case 4:
          case "end":
            return _context.stop();
        }
      }
    }, _callee, undefined);
  }));

  return function (_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * read all exercises
 */
controller.readExercises = function () {
  var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee2$(_context2) {
      while (1) {
        switch (_context2.prev = _context2.next) {
          case 0:
            _context2.next = 2;
            return _ExerciseRepository2.default.readExercises(req);

          case 2:
            rows = _context2.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context2.stop();
        }
      }
    }, _callee2, undefined);
  }));

  return function (_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();

controller.detailExercise = function () {
  var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee3$(_context3) {
      while (1) {
        switch (_context3.prev = _context3.next) {
          case 0:
            _context3.next = 2;
            return _ExerciseRepository2.default.detailExercise(req);

          case 2:
            rows = _context3.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context3.stop();
        }
      }
    }, _callee3, undefined);
  }));

  return function (_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();

/**
 * update user exercise
 */
controller.updateExercise = function () {
  var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee4$(_context4) {
      while (1) {
        switch (_context4.prev = _context4.next) {
          case 0:
            _context4.next = 2;
            return _ExerciseRepository2.default.updateExercise(req);

          case 2:
            rows = _context4.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context4.stop();
        }
      }
    }, _callee4, undefined);
  }));

  return function (_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}();

/**
 * delete user exercise
 */
controller.deleteExercise = function () {
  var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee5$(_context5) {
      while (1) {
        switch (_context5.prev = _context5.next) {
          case 0:
            _context5.next = 2;
            return _ExerciseRepository2.default.deleteExercise(req);

          case 2:
            rows = _context5.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context5.stop();
        }
      }
    }, _callee5, undefined);
  }));

  return function (_x9, _x10) {
    return _ref5.apply(this, arguments);
  };
}();

controller.testInsertForDeleteExercise = function () {
  var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee6$(_context6) {
      while (1) {
        switch (_context6.prev = _context6.next) {
          case 0:
            _context6.next = 2;
            return _ExerciseRepository2.default.testInsertForDeleteExercise(req);

          case 2:
            rows = _context6.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context6.stop();
        }
      }
    }, _callee6, undefined);
  }));

  return function (_x11, _x12) {
    return _ref6.apply(this, arguments);
  };
}();

controller.deleteForTest = function () {
  var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee7$(_context7) {
      while (1) {
        switch (_context7.prev = _context7.next) {
          case 0:
            _context7.next = 2;
            return _ExerciseRepository2.default.deleteForTest(req);

          case 2:
            rows = _context7.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context7.stop();
        }
      }
    }, _callee7, undefined);
  }));

  return function (_x13, _x14) {
    return _ref7.apply(this, arguments);
  };
}();

controller.deleteExerciseAll = function () {
  var _ref8 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8(req, res) {
    var rows;
    return regeneratorRuntime.wrap(function _callee8$(_context8) {
      while (1) {
        switch (_context8.prev = _context8.next) {
          case 0:
            _context8.next = 2;
            return _ExerciseRepository2.default.deleteExerciseAll(req);

          case 2:
            rows = _context8.sent;

            res.status(200).json(rows);

          case 4:
          case "end":
            return _context8.stop();
        }
      }
    }, _callee8, undefined);
  }));

  return function (_x15, _x16) {
    return _ref8.apply(this, arguments);
  };
}();

exports.default = controller;
//# sourceMappingURL=ExerciseController.js.map