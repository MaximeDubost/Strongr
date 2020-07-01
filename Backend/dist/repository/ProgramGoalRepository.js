"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _ProgramGoal = require("../Models/ProgramGoal");

var _ProgramGoal2 = _interopRequireDefault(_ProgramGoal);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.readProgramGoal = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var program_goal_list, sql, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        program_goal_list = [];
                        sql = "\n        SELECT id_program_goal, name, description\n        FROM _program_goal\n    ";
                        _context.prev = 2;
                        _context.next = 5;
                        return _database2.default.query(sql);

                    case 5:
                        result = _context.sent;

                        if (result.rowCount > 0) {
                            result.rows.forEach(function (row) {
                                program_goal_list.push(new _ProgramGoal2.default(row.id_program_goal, row.name, row.description));
                            });
                        }
                        console.log(program_goal_list);
                        return _context.abrupt("return", program_goal_list);

                    case 11:
                        _context.prev = 11;
                        _context.t0 = _context["catch"](2);

                        console.log(_context.t0);

                    case 14:
                    case "end":
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[2, 11]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();

repository.readProgramGoalById = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        sql = "\n        SELECT id_program_goal, name, description\n        FROM _program_goal\n        WHERE id_program_goal = $1\n    ";
                        _context2.prev = 1;
                        _context2.next = 4;
                        return _database2.default.query(sql, [req.params.id_program_goal]);

                    case 4:
                        result = _context2.sent;
                        return _context2.abrupt("return", result.rows[0]);

                    case 8:
                        _context2.prev = 8;
                        _context2.t0 = _context2["catch"](1);

                        console.log(_context2.t0);

                    case 11:
                    case "end":
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[1, 8]]);
    }));

    return function (_x2) {
        return _ref2.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=ProgramGoalRepository.js.map