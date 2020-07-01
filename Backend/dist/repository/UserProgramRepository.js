"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.createUserProgram = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var res, sql, result, id_lastprogram;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        res = void 0;
                        sql = "INSERT INTO _program (name, creation_date, last_update, id_program_goal, id_user) VALUES ($1, $2, $3, $4, $5)";
                        _context.prev = 2;
                        _context.next = 5;
                        return _database2.default.query(sql, [req.body.name_program, new Date(), new Date(), req.body.id_program_goal, req.user.id]);

                    case 5:
                        result = _context.sent;

                        console.log(result);
                        sql = "SELECT * FROM _program ORDER BY creation_date DESC";
                        _context.next = 10;
                        return _database2.default.query(sql);

                    case 10:
                        result = _context.sent;
                        id_lastprogram = result.rows[0].id_program;

                        sql = "INSERT INTO _program_session (id_user, id_program, id_user_1, id_session) VALUES ($1, $2, $3, $4)";
                        _context.next = 15;
                        return _database2.default.query(sql, [req.user.id, id_lastprogram, req.user.id, req.body.id_session]);

                    case 15:
                        res = 201;
                        return _context.abrupt("return", res);

                    case 19:
                        _context.prev = 19;
                        _context.t0 = _context["catch"](2);

                        console.log(_context.t0);
                        return _context.abrupt("return", 500);

                    case 23:
                    case "end":
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[2, 19]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();

repository.getProgramsPreview = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        sql = "\n    SELECT p.id_program as id, p.name as name ,pg.name as program_goal,\n    COUNT(DISTINCT ps.id_session) as session_count, null as Tonnage\n    FROM _program p \n    JOIN _program_goal pg ON p.id_program_goal = pg.id_program_goal\n    JOIN _program_session ps ON p.id_program = ps.id_program\n    WHERE p.id_user = $1\n    GROUP BY p.id_program, p.name, pg.name, p.last_update\n    ORDER BY p.last_update DESC\n    ";
                        _context2.prev = 1;
                        _context2.next = 4;
                        return _database2.default.query(sql, [req.user.id]);

                    case 4:
                        result = _context2.sent;
                        return _context2.abrupt("return", result.rows);

                    case 8:
                        _context2.prev = 8;
                        _context2.t0 = _context2["catch"](1);

                        console.log(_context2.t0);
                        return _context2.abrupt("return", 500);

                    case 12:
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

repository.updateUserProgram = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req) {
        var sql;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        sql = "UPDATE _program SET id_program_goal = $1, name = $2, last_update = $3 WHERE id_program = $4";
                        _context3.prev = 1;
                        _context3.next = 4;
                        return _database2.default.query(sql, [req.body.id_program_goal, req.body.name_program, new Date(), req.params.id_program]);

                    case 4:
                        return _context3.abrupt("return", 200);

                    case 7:
                        _context3.prev = 7;
                        _context3.t0 = _context3["catch"](1);

                        console.log(_context3.t0);
                        return _context3.abrupt("return", 500);

                    case 11:
                    case "end":
                        return _context3.stop();
                }
            }
        }, _callee3, undefined, [[1, 7]]);
    }));

    return function (_x3) {
        return _ref3.apply(this, arguments);
    };
}();

/**
 * Trigger donc temporaire
 */
repository.deleteUserProgram = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req) {
        var sql;
        return regeneratorRuntime.wrap(function _callee4$(_context4) {
            while (1) {
                switch (_context4.prev = _context4.next) {
                    case 0:
                        sql = "DELETE FROM _program WHERE id_program = $1";
                        _context4.prev = 1;
                        _context4.next = 4;
                        return _database2.default.query(sql, [req.params.id_program]);

                    case 4:
                        return _context4.abrupt("return", 200);

                    case 7:
                        _context4.prev = 7;
                        _context4.t0 = _context4["catch"](1);

                        console.log(_context4.t0);
                        return _context4.abrupt("return", 500);

                    case 11:
                    case "end":
                        return _context4.stop();
                }
            }
        }, _callee4, undefined, [[1, 7]]);
    }));

    return function (_x4) {
        return _ref4.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=UserProgramRepository.js.map