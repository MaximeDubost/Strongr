"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _Program = require("../Models/Program");

var _Program2 = _interopRequireDefault(_Program);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.readProgram = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var program_list, sql, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        program_list = [];
                        sql = "\n        SELECT p.id_program, p.name, pg.name as program_goal_name, COUNT(ps.id_program) as session_count, null as tonnage\n        FROM _program p\n        JOIN _program_goal pg ON pg.id_program_goal = p.id_program_goal\n        JOIN _program_session ps ON ps.id_program = p.id_program\n        WHERE p.id_user = $1 \n        GROUP BY p.id_program, p.name, pg.name, p.last_update\n        ORDER BY p.last_update DESC\n    ";
                        _context.prev = 2;
                        _context.next = 5;
                        return _database2.default.query(sql, [req.user.id]);

                    case 5:
                        result = _context.sent;

                        if (result.rowCount > 0) {
                            result.rows.forEach(function (row) {
                                program_list.push(new _Program2.default(row.id_program, row.name, row.program_goal_name, row.session_count, row.tonnage));
                            });
                        }
                        console.log(program_list);
                        return _context.abrupt("return", program_list);

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

repository.readDetailProgram = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req) {
        var sql, program_sql, result, program_goal_result;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:

                        //console.log('req user id = '+req.user.id)
                        //console.log('id_program = '+req.params.id_program)

                        sql = "\n    SELECT p.id_program as id, p.name, p.creation_date, p.last_update\n    FROM _program p\n    JOIN _program_session ps ON ps.id_program = p.id_program\n    WHERE p.id_user = $1 AND p.id_program = $2\n    GROUP BY p.id_program, p.name, p.creation_date, p.last_update\n    ";
                        program_sql = "\n    SELECT pg.id_program_goal as id, pg.name as name\n    FROM _program p\n    JOIN _program_goal pg ON pg.id_program_goal = p.id_program_goal\n    JOIN _program_session ps ON ps.id_program = p.id_program\n    WHERE p.id_user = $1 AND p.id_program = $2\n    GROUP BY pg.name, pg.id_program_goal\n    ";
                        _context2.prev = 2;
                        _context2.next = 5;
                        return _database2.default.query(sql, [req.user.id, req.params.id_program]);

                    case 5:
                        result = _context2.sent;
                        _context2.next = 8;
                        return _database2.default.query(program_sql, [req.user.id, req.params.id_program]);

                    case 8:
                        program_goal_result = _context2.sent;

                        result.rows[0].program_goal = program_goal_result.rows[0];
                        return _context2.abrupt("return", result.rows[0]);

                    case 13:
                        _context2.prev = 13;
                        _context2.t0 = _context2["catch"](2);

                        console.log(_context2.t0);

                    case 16:
                    case "end":
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[2, 13]]);
    }));

    return function (_x2) {
        return _ref2.apply(this, arguments);
    };
}();

repository.readSessionDetailProgram = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        sql = "\n    SELECT s.id_session as id, ps.place, s.name, st.name as session_type_name,  \n    (\n        SELECT COUNT(se.id_session) as exercise_count  \n        FROM _session s\n        JOIN _session_exercise se ON se.id_session = s.id_session\n\t\tJOIN _program_session ps ON ps.id_session = s.id_session\n        WHERE s.id_user = $1 AND ps.id_program = $2\n    ),  null as tonnage\n    FROM _session s\n    JOIN _session_type st ON st.id_session_type = s.id_session_type\n\tJOIN _program_session ps ON ps.id_session = s.id_session\n    WHERE s.id_user = $1 AND ps.id_program = $2\n    ORDER BY place\n    ";
                        _context3.prev = 1;
                        _context3.next = 4;
                        return _database2.default.query(sql, [req.user.id, req.params.id_program]);

                    case 4:
                        result = _context3.sent;
                        return _context3.abrupt("return", result.rows);

                    case 8:
                        _context3.prev = 8;
                        _context3.t0 = _context3["catch"](1);

                        console.log(_context3.t0);

                    case 11:
                    case "end":
                        return _context3.stop();
                }
            }
        }, _callee3, undefined, [[1, 8]]);
    }));

    return function (_x3) {
        return _ref3.apply(this, arguments);
    };
}();

repository.addProgram = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req) {
        var sqlAddProgram, sqlLastProgramCreated, getIdProgram;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        sqlAddProgram = "INSERT INTO _program (id_user, id_program_goal, name, creation_date, last_update) VALUES ($1, $2, $3, $4, $5)";
                        _context5.prev = 1;
                        _context5.next = 4;
                        return _database2.default.query(sqlAddProgram, [req.user.id, req.body.id_program_goal, req.body.name, new Date(), new Date()]);

                    case 4:
                        sqlLastProgramCreated = "SELECT id_program FROM _program WHERE id_user = $1 ORDER BY creation_date DESC";
                        _context5.next = 7;
                        return _database2.default.query(sqlLastProgramCreated, [req.user.id]);

                    case 7:
                        getIdProgram = _context5.sent;

                        req.body.sessions.forEach(function () {
                            var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(session) {
                                var parsed_session, insertInProgramSession;
                                return regeneratorRuntime.wrap(function _callee4$(_context4) {
                                    while (1) {
                                        switch (_context4.prev = _context4.next) {
                                            case 0:
                                                parsed_session = JSON.parse(session);
                                                insertInProgramSession = "INSERT INTO _program_session (id_user, id_user_1, id_program, id_session, place) VALUES ($1, $2, $3, $4, $5)";
                                                _context4.next = 4;
                                                return _database2.default.query(insertInProgramSession, [req.user.id, req.user.id, getIdProgram.rows[0].id_program, parsed_session.id, parsed_session.place]);

                                            case 4:
                                            case "end":
                                                return _context4.stop();
                                        }
                                    }
                                }, _callee4, undefined);
                            }));

                            return function (_x5) {
                                return _ref5.apply(this, arguments);
                            };
                        }());
                        return _context5.abrupt("return", 201);

                    case 12:
                        _context5.prev = 12;
                        _context5.t0 = _context5["catch"](1);

                        console.log(_context5.t0);

                    case 15:
                    case "end":
                        return _context5.stop();
                }
            }
        }, _callee5, undefined, [[1, 12]]);
    }));

    return function (_x4) {
        return _ref4.apply(this, arguments);
    };
}();

repository.deleteProgram = function () {
    var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(req) {
        var sqlAddProgram;
        return regeneratorRuntime.wrap(function _callee6$(_context6) {
            while (1) {
                switch (_context6.prev = _context6.next) {
                    case 0:
                        sqlAddProgram = "DELETE FROM _program WHERE id_program = $1 AND id_user = $2";
                        _context6.prev = 1;
                        _context6.next = 4;
                        return _database2.default.query(sqlAddProgram, [req.params.id_program, req.user.id]);

                    case 4:
                        return _context6.abrupt("return", 200);

                    case 7:
                        _context6.prev = 7;
                        _context6.t0 = _context6["catch"](1);

                        console.log(_context6.t0);

                    case 10:
                    case "end":
                        return _context6.stop();
                }
            }
        }, _callee6, undefined, [[1, 7]]);
    }));

    return function (_x6) {
        return _ref6.apply(this, arguments);
    };
}();

repository.updateProgram = function () {
    var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee8$(_context8) {
            while (1) {
                switch (_context8.prev = _context8.next) {
                    case 0:
                        console.log(req.body);
                        sql = "SELECT id_program_goal FROM _program_goal WHERE name = $1";
                        _context8.prev = 2;
                        _context8.next = 5;
                        return _database2.default.query(sql, [req.body.program_goal_name]);

                    case 5:
                        result = _context8.sent;

                        sql = "UPDATE _program SET name = $1, last_update = $2, id_program_goal = $3 WHERE id_program = $4 AND id_user = $5";
                        _context8.next = 9;
                        return _database2.default.query(sql, [req.body.name, new Date(), result.rows[0].id_program_goal, req.params.id_program, req.user.id]);

                    case 9:
                        sql = "DELETE FROM _program_session WHERE id_user = $1 AND id_user_1 = $2 AND id_program = $3";
                        _context8.next = 12;
                        return _database2.default.query(sql, [req.user.id, req.user.id, req.params.id_program]);

                    case 12:
                        req.body.sessions.forEach(function () {
                            var _ref8 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(session) {
                                var session_parsed;
                                return regeneratorRuntime.wrap(function _callee7$(_context7) {
                                    while (1) {
                                        switch (_context7.prev = _context7.next) {
                                            case 0:
                                                session_parsed = JSON.parse(session);

                                                sql = "INSERT INTO _program_session (id_user, id_user_1, id_program, id_session, place) VALUES ($1,$2,$3,$4,$5)";
                                                _context7.next = 4;
                                                return _database2.default.query(sql, [req.user.id, req.user.id, req.params.id_program, session_parsed.id, session_parsed.place]);

                                            case 4:
                                            case "end":
                                                return _context7.stop();
                                        }
                                    }
                                }, _callee7, undefined);
                            }));

                            return function (_x8) {
                                return _ref8.apply(this, arguments);
                            };
                        }());
                        return _context8.abrupt("return", 200);

                    case 16:
                        _context8.prev = 16;
                        _context8.t0 = _context8["catch"](2);

                        console.log(_context8.t0);
                        return _context8.abrupt("return", 501);

                    case 20:
                    case "end":
                        return _context8.stop();
                }
            }
        }, _callee8, undefined, [[2, 16]]);
    }));

    return function (_x7) {
        return _ref7.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=ProgramRepository.js.map