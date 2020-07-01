"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _AppExercise = require("../Models/AppExercise");

var _AppExercise2 = _interopRequireDefault(_AppExercise);

var _Exercise = require("../Models/Exercise");

var _Exercise2 = _interopRequireDefault(_Exercise);

var _Set = require("../Models/Set");

var _Set2 = _interopRequireDefault(_Set);

var _DetailExercise = require("../Models/DetailExercise");

var _DetailExercise2 = _interopRequireDefault(_DetailExercise);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

var _express = require("express");

var _Equipment = require("../Models/Equipment");

var _Equipment2 = _interopRequireDefault(_Equipment);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

/**
 * create exercises 
 */
repository.createExercise = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req) {
        var date, sqlCreateExercise, sqlGetIdExercise, result;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        console.log(req.body);
                        date = new Date();
                        sqlCreateExercise = "INSERT INTO _exercise (id_app_exercise, id_user, name, id_equipment, creation_date, last_update) VALUES ($1, $2, $3, $4, $5, $6)";
                        sqlGetIdExercise = "SELECT id_exercise FROM _exercise WHERE id_user = $1 ORDER BY creation_date DESC LIMIT 1";
                        _context2.prev = 4;
                        _context2.next = 7;
                        return _database2.default.query(sqlCreateExercise, [req.body.id_app_exercise, req.user.id, req.body.name, req.body.id_equipment, date, date]);

                    case 7:
                        _context2.next = 9;
                        return _database2.default.query(sqlGetIdExercise, [req.user.id]);

                    case 9:
                        result = _context2.sent;


                        req.body.sets.forEach(function () {
                            var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(set) {
                                var parsed_set, sqlAddSet;
                                return regeneratorRuntime.wrap(function _callee$(_context) {
                                    while (1) {
                                        switch (_context.prev = _context.next) {
                                            case 0:
                                                parsed_set = JSON.parse(set);
                                                sqlAddSet = "INSERT INTO _set (id_app_exercise, id_user, id_exercise, repetitions_count, rest_time, place) VALUES ($1, $2, $3, $4, $5, $6)";
                                                _context.next = 4;
                                                return _database2.default.query(sqlAddSet, [req.body.id_app_exercise, req.user.id, result.rows[0].id_exercise, parsed_set.repetitions_count, parsed_set.rest_time, parsed_set.place]);

                                            case 4:
                                            case "end":
                                                return _context.stop();
                                        }
                                    }
                                }, _callee, undefined);
                            }));

                            return function (_x2) {
                                return _ref2.apply(this, arguments);
                            };
                        }());
                        return _context2.abrupt("return", 201);

                    case 14:
                        _context2.prev = 14;
                        _context2.t0 = _context2["catch"](4);

                        console.error(_context2.t0);

                    case 17:
                    case "end":
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[4, 14]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();
/// READ
repository.readExercises = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req) {
        var exercise_list, sqlReadAllExercices, result;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        exercise_list = [];
                        sqlReadAllExercices = "\n    SELECT e.id_exercise, e.name as name_exercise, ae.name as name_app_exercise, COUNT(s.id_set) as set_count, null as tonnage\n    FROM _exercise e\n    JOIN _app_exercise ae ON ae.id_app_exercise = e.id_app_exercise\n    JOIN _set s ON s.id_exercise = e.id_exercise\n    WHERE e.id_user = $1\n    GROUP BY e.id_exercise, e.name, ae.name, e.last_update\n    ORDER BY e.last_update DESC\n    ";
                        _context3.prev = 2;
                        _context3.next = 5;
                        return _database2.default.query(sqlReadAllExercices, [req.user.id]);

                    case 5:
                        result = _context3.sent;

                        if (result.rowCount > 0) {
                            result.rows.forEach(function (row) {
                                exercise_list.push(new _Exercise2.default(row.id_exercise, row.name_exercise, row.name_app_exercise, row.set_count, row.tonnage));
                            });
                        }

                        return _context3.abrupt("return", exercise_list);

                    case 10:
                        _context3.prev = 10;
                        _context3.t0 = _context3["catch"](2);

                        console.log(_context3.t0);

                    case 13:
                    case "end":
                        return _context3.stop();
                }
            }
        }, _callee3, undefined, [[2, 10]]);
    }));

    return function (_x3) {
        return _ref3.apply(this, arguments);
    };
}();

/// UPDATE
repository.updateExercise = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        sql = "UPDATE _exercise SET name = $1, last_update = $2, id_equipment = $3 WHERE id_exercise = $4 AND id_user = $5";
                        _context5.prev = 1;
                        _context5.next = 4;
                        return _database2.default.query(sql, [req.body.name, new Date(), req.body.id_equipment, req.params.id_exercise, req.user.id]);

                    case 4:
                        sql = "DELETE FROM _set WHERE id_user = $1 AND id_exercise = $2";
                        _context5.next = 7;
                        return _database2.default.query(sql, [req.user.id, req.params.id_exercise]);

                    case 7:
                        sql = "SELECT id_app_exercise FROM _exercise WHERE id_exercise = $1";
                        _context5.next = 10;
                        return _database2.default.query(sql, [req.params.id_exercise]);

                    case 10:
                        result = _context5.sent;

                        req.body.sets.forEach(function () {
                            var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(set) {
                                var parsed_set;
                                return regeneratorRuntime.wrap(function _callee4$(_context4) {
                                    while (1) {
                                        switch (_context4.prev = _context4.next) {
                                            case 0:
                                                parsed_set = JSON.parse(set);

                                                sql = "INSERT INTO _set (id_user, id_exercise, id_app_exercise, place, repetitions_count, rest_time) VALUES ($1,$2,$3,$4,$5,$6)";
                                                _context4.next = 4;
                                                return _database2.default.query(sql, [req.user.id, req.params.id_exercise, result.rows[0].id_app_exercise, parsed_set.place, parsed_set.repetitions_count, parsed_set.rest_time]);

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
                        return _context5.abrupt("return", 200);

                    case 15:
                        _context5.prev = 15;
                        _context5.t0 = _context5["catch"](1);

                        console.log(_context5.t0);

                    case 18:
                    case "end":
                        return _context5.stop();
                }
            }
        }, _callee5, undefined, [[1, 15]]);
    }));

    return function (_x4) {
        return _ref4.apply(this, arguments);
    };
}();

/// DELETE
repository.deleteExercise = function () {
    var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(req) {
        var sqlDeleteExercise;
        return regeneratorRuntime.wrap(function _callee6$(_context6) {
            while (1) {
                switch (_context6.prev = _context6.next) {
                    case 0:
                        sqlDeleteExercise = "DELETE FROM _exercise WHERE id_exercise = $1 AND id_user = $2";
                        _context6.prev = 1;
                        _context6.next = 4;
                        return _database2.default.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id]);

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

repository.detailExercise = function () {
    var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(req) {
        var equipment, set_list, sql, result, app_exercise, result_equipment;
        return regeneratorRuntime.wrap(function _callee7$(_context7) {
            while (1) {
                switch (_context7.prev = _context7.next) {
                    case 0:
                        equipment = [];
                        set_list = [];
                        sql = "\n    SELECT id_set, place, repetitions_count, rest_time, null as tonnage\n    FROM _set s \n    WHERE s.id_exercise = $1\n    ORDER BY s.place;\n    ";
                        _context7.prev = 3;
                        _context7.next = 6;
                        return _database2.default.query(sql, [req.params.id_exercise]);

                    case 6:
                        result = _context7.sent;

                        if (result.rowCount > 0) {
                            result.rows.forEach(function (row) {
                                set_list.push(new _Set2.default(row.id_set, row.place, row.repetitions_count, row.rest_time, row.tonnage));
                            });
                        }
                        sql = "\n        SELECT e.id_exercise, e.name as name_exercise, ae.id_app_exercise, ae.name as name_app_exercise, e.creation_date, e.last_update\n        FROM _exercise e\n        JOIN _app_exercise ae ON ae.id_app_exercise = e.id_app_exercise\n        WHERE e.id_exercise = $1;\n        ";
                        _context7.next = 11;
                        return _database2.default.query(sql, [req.params.id_exercise]);

                    case 11:
                        result = _context7.sent;

                        // console.log("result.rows: ", result.rows)
                        app_exercise = new _AppExercise2.default(result.rows[0].id_app_exercise, result.rows[0].name_app_exercise);
                        // console.log("app_exercise: ", app_exercise)

                        sql = "\n        SELECT eq.id_equipment, eq.name \n        FROM _exercise e JOIN _equipment eq ON eq.id_equipment = e.id_equipment\n        WHERE e.id_exercise = $1 AND e.id_user = $2 AND e.id_app_exercise = $3\n        ";
                        _context7.next = 16;
                        return _database2.default.query(sql, [req.params.id_exercise, req.user.id, result.rows[0].id_app_exercise]);

                    case 16:
                        result_equipment = _context7.sent;

                        console.log(result_equipment);

                        if (result_equipment.rowCount > 0) {
                            equipment = new _Equipment2.default(result_equipment.rows[0].id_equipment, result_equipment.rows[0].name);
                        }

                        return _context7.abrupt("return", new _DetailExercise2.default(result.rows[0].id_exercise, result.rows[0].name_exercise, app_exercise, equipment, set_list, result.rows[0].creation_date, result.rows[0].last_update));

                    case 22:
                        _context7.prev = 22;
                        _context7.t0 = _context7["catch"](3);

                        console.log(_context7.t0);

                    case 25:
                    case "end":
                        return _context7.stop();
                }
            }
        }, _callee7, undefined, [[3, 22]]);
    }));

    return function (_x7) {
        return _ref7.apply(this, arguments);
    };
}();

repository.deleteExerciseAll = function () {
    var _ref8 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee11(req) {
        var sqlGetSession, sqlGetAllExerciseFromSession, sqlGetProgram, sqlGetAllSessionFromProgram, sqlDeleteSessionExercise, sqlDeleteProgramSession, sqlDeleteExercise, sqlDeleteSession, sqlDeleteProgram, resultForIdSession, allSession;
        return regeneratorRuntime.wrap(function _callee11$(_context11) {
            while (1) {
                switch (_context11.prev = _context11.next) {
                    case 0:
                        sqlGetSession = "\n    SELECT id_session FROM _session_exercise WHERE id_exercise = $1 AND id_user = $2\n    ";
                        sqlGetAllExerciseFromSession = "\n    SELECT id_exercise FROM _session_exercise WHERE id_session = $1 AND id_user = $2\n    ";
                        sqlGetProgram = "\n    SELECT id_program FROM _program_session WHERE id_session = $1 and id_user = $2\n    ";
                        sqlGetAllSessionFromProgram = "\n    SELECT id_session FROM _program_session WHERE id_program = $1 AND id_user = $2\n    ";
                        sqlDeleteSessionExercise = "\n    DELETE FROM _session_exercise WHERE id_exercise = $1 AND id_user = $2\n    ";
                        sqlDeleteProgramSession = "\n    DELETE FROM _program_session WHERE id_session = $1 AND id_user = $2\n    ";
                        sqlDeleteExercise = "\n    DELETE FROM _exercise WHERE id_exercise = $1 AND id_user = $2\n    ";
                        sqlDeleteSession = "\n    DELETE FROM _session WHERE id_session = $1 AND id_user = $2\n    ";
                        sqlDeleteProgram = "\n    DELETE FROM _program WHERE id_program = $1 AND id_user = $2\n    ";
                        _context11.prev = 9;
                        _context11.next = 12;
                        return _database2.default.query(sqlGetSession, [req.params.id_exercise, req.user.id]);

                    case 12:
                        resultForIdSession = _context11.sent;
                        allSession = void 0;

                        console.log("resultForIdSession : " + resultForIdSession);

                        if (!(resultForIdSession.rowCount == 0)) {
                            _context11.next = 20;
                            break;
                        }

                        _context11.next = 18;
                        return _database2.default.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id]);

                    case 18:
                        _context11.next = 21;
                        break;

                    case 20:
                        allSession = resultForIdSession.rows[0].id_session;

                    case 21:
                        // Pour chaque session 
                        resultForIdSession.rows.forEach(function () {
                            var _ref9 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee10(row) {
                                var resultAnyExercise, allExercise, resultForIdProgram, selectIdSession;
                                return regeneratorRuntime.wrap(function _callee10$(_context10) {
                                    while (1) {
                                        switch (_context10.prev = _context10.next) {
                                            case 0:
                                                _context10.next = 2;
                                                return _database2.default.query(sqlGetAllExerciseFromSession, [row.id_session, req.user.id]);

                                            case 2:
                                                resultAnyExercise = _context10.sent;
                                                allExercise = resultAnyExercise.rows;
                                                // si session a plus d'un exercice

                                                if (!(allExercise.length > 1)) {
                                                    _context10.next = 11;
                                                    break;
                                                }

                                                _context10.next = 7;
                                                return _database2.default.query(sqlDeleteSessionExercise, [req.params.id_exercise, req.user.id]);

                                            case 7:
                                                _context10.next = 9;
                                                return _database2.default.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id]);

                                            case 9:
                                                _context10.next = 25;
                                                break;

                                            case 11:
                                                _context10.next = 13;
                                                return _database2.default.query(sqlGetProgram, [row.id_session, req.user.id]);

                                            case 13:
                                                resultForIdProgram = _context10.sent;
                                                selectIdSession = row.id_session;
                                                // si la seance n'appartient à aucun programme 

                                                if (!(resultForIdProgram.rowCount == 0)) {
                                                    _context10.next = 24;
                                                    break;
                                                }

                                                _context10.next = 18;
                                                return _database2.default.query(sqlDeleteSessionExercise, [req.params.id_exercise, req.user.id]);

                                            case 18:
                                                _context10.next = 20;
                                                return _database2.default.query(sqlDeleteProgramSession, [selectIdSession, req.user.id]);

                                            case 20:
                                                _context10.next = 22;
                                                return _database2.default.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id]);

                                            case 22:
                                                _context10.next = 24;
                                                return _database2.default.query(sqlDeleteSession, [selectIdSession, req.user.id]);

                                            case 24:
                                                resultForIdProgram.rows.forEach(function () {
                                                    var _ref10 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee9(r) {
                                                        var resultAnySession, allSession;
                                                        return regeneratorRuntime.wrap(function _callee9$(_context9) {
                                                            while (1) {
                                                                switch (_context9.prev = _context9.next) {
                                                                    case 0:
                                                                        _context9.next = 2;
                                                                        return _database2.default.query(sqlGetAllSessionFromProgram, [r.id_program, req.user.id]);

                                                                    case 2:
                                                                        resultAnySession = _context9.sent;
                                                                        allSession = resultAnySession.rows;
                                                                        // si session n'est pas unique dans chaque programme 

                                                                        if (!(allSession.length > 1)) {
                                                                            _context9.next = 8;
                                                                            break;
                                                                        }

                                                                        allSession.forEach(function () {
                                                                            var _ref11 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8(session) {
                                                                                return regeneratorRuntime.wrap(function _callee8$(_context8) {
                                                                                    while (1) {
                                                                                        switch (_context8.prev = _context8.next) {
                                                                                            case 0:
                                                                                                _context8.next = 2;
                                                                                                return _database2.default.query(sqlDeleteSessionExercise, [allExercise[0].id_exercise, req.user.id]);

                                                                                            case 2:
                                                                                                _context8.next = 4;
                                                                                                return _database2.default.query(sqlDeleteProgramSession, [selectIdSession, req.user.id]);

                                                                                            case 4:
                                                                                                _context8.next = 6;
                                                                                                return _database2.default.query(sqlDeleteExercise, [allExercise[0].id_exercise, req.user.id]);

                                                                                            case 6:
                                                                                                _context8.next = 8;
                                                                                                return _database2.default.query(sqlDeleteSession, [selectIdSession, req.user.id]);

                                                                                            case 8:
                                                                                            case "end":
                                                                                                return _context8.stop();
                                                                                        }
                                                                                    }
                                                                                }, _callee8, undefined);
                                                                            }));

                                                                            return function (_x11) {
                                                                                return _ref11.apply(this, arguments);
                                                                            };
                                                                        }());
                                                                        _context9.next = 18;
                                                                        break;

                                                                    case 8:
                                                                        _context9.next = 10;
                                                                        return _database2.default.query(sqlDeleteSessionExercise, [req.params.id_exercise, req.user.id]);

                                                                    case 10:
                                                                        _context9.next = 12;
                                                                        return _database2.default.query(sqlDeleteProgramSession, [allSession[0].id_session, req.user.id]);

                                                                    case 12:
                                                                        _context9.next = 14;
                                                                        return _database2.default.query(sqlDeleteExercise, [req.params.id_exercise, req.user.id]);

                                                                    case 14:
                                                                        _context9.next = 16;
                                                                        return _database2.default.query(sqlDeleteSession, [allSession[0].id_session, req.user.id]);

                                                                    case 16:
                                                                        _context9.next = 18;
                                                                        return _database2.default.query(sqlDeleteProgram, [r.id_program, req.user.id]);

                                                                    case 18:
                                                                    case "end":
                                                                        return _context9.stop();
                                                                }
                                                            }
                                                        }, _callee9, undefined);
                                                    }));

                                                    return function (_x10) {
                                                        return _ref10.apply(this, arguments);
                                                    };
                                                }());

                                            case 25:
                                            case "end":
                                                return _context10.stop();
                                        }
                                    }
                                }, _callee10, undefined);
                            }));

                            return function (_x9) {
                                return _ref9.apply(this, arguments);
                            };
                        }());
                        return _context11.abrupt("return", 201);

                    case 25:
                        _context11.prev = 25;
                        _context11.t0 = _context11["catch"](9);

                        console.error(_context11.t0);

                    case 28:
                    case "end":
                        return _context11.stop();
                }
            }
        }, _callee11, undefined, [[9, 25]]);
    }));

    return function (_x8) {
        return _ref8.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=ExerciseRepository.js.map