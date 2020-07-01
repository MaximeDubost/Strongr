'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _Session = require('../models/Session');

var _Session2 = _interopRequireDefault(_Session);

var _SessionDetail = require('../models/SessionDetail');

var _SessionDetail2 = _interopRequireDefault(_SessionDetail);

var _SessionType = require('../models/SessionType');

var _SessionType2 = _interopRequireDefault(_SessionType);

var _ExerciseSession = require('../models/ExerciseSession');

var _ExerciseSession2 = _interopRequireDefault(_ExerciseSession);

var _database = require('../core/config/database');

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.getSessions = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var sessionList, sql, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        sessionList = [];
                        sql = '\n    SELECT s.id_session, s.name as name_session, st.name as session_type_name, COUNT(se.id_exercise) as exercise_count, null as tonnage\n    FROM _session s\n    JOIN _session_type st ON s.id_session_type = st.id_session_type\n    JOIN _session_exercise se ON s.id_session = se.id_session\n    WHERE s.id_user = $1\n    GROUP BY s.id_session, s.name, st.name, s.last_update\n    ORDER BY s.last_update DESC\n    ';
                        _context.prev = 2;
                        _context.next = 5;
                        return _database2.default.query(sql, [req.user.id]);

                    case 5:
                        result = _context.sent;

                        console.log(result);
                        if (result.rowCount != 0) {
                            result.rows.map(function (row) {
                                sessionList.push(new _Session2.default(row.id_session, row.name_session, row.session_type_name, row.exercise_count, row.tonnage));
                            });
                        }
                        return _context.abrupt('return', sessionList);

                    case 11:
                        _context.prev = 11;
                        _context.t0 = _context['catch'](2);

                        console.log(_context.t0);

                    case 14:
                    case 'end':
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[2, 11]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();

repository.getSessionDetail = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req) {
        var exercises_list, sql, resultSessionType, sessionType, resultExercises, data;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        exercises_list = [];
                        sql = '\n    SELECT s.id_session, st.id_session_type, se.place as place, s.name as session_name, st.name as session_type_name, s.creation_date, s.last_update\n    FROM _session s\n    JOIN _session_type st ON s.id_session_type = st.id_session_type\n    JOIN _session_exercise se ON s.id_session = se.id_session\n    WHERE s.id_user = $1 AND s.id_session = $2\n    ';
                        _context2.prev = 2;
                        _context2.next = 5;
                        return _database2.default.query(sql, [req.user.id, req.params.id_session]);

                    case 5:
                        resultSessionType = _context2.sent;
                        sessionType = new _SessionType2.default(resultSessionType.rows[0].id_session_type, resultSessionType.rows[0].session_type_name);


                        sql = '\n        SELECT e.id_exercise, se.place, e.name as name_exercise, ae.name as app_exercise_name, COUNT(sett.id_set) as set_count, null as tonnage \n        FROM _session s\n        JOIN _session_exercise se on s.id_session = se.id_session \n        JOIN _exercise e on se.id_exercise = e.id_exercise \n        JOIN _app_exercise ae on e.id_app_exercise = ae.id_app_exercise\n        JOIN _set sett ON e.id_exercise = sett.id_exercise\n        WHERE s.id_user = $1 and s.id_session = $2\n        GROUP BY e.id_exercise, se.place, ae.name, e.name\n        ORDER BY se.place;\n        ';
                        _context2.next = 10;
                        return _database2.default.query(sql, [req.user.id, req.params.id_session]);

                    case 10:
                        resultExercises = _context2.sent;

                        if (resultExercises.rowCount > 0) {
                            resultExercises.rows.map(function (row) {
                                console.log("ROW : " + row);
                                var exercise = new _ExerciseSession2.default(row.id_exercise, row.place, row.name_exercise, row.app_exercise_name, row.set_count, row.tonnage);
                                exercises_list.push(exercise);
                            });
                        }
                        data = new _SessionDetail2.default(resultSessionType.rows[0].id_session, resultSessionType.rows[0].session_name, sessionType, exercises_list, resultSessionType.rows[0].creation_date, resultSessionType.rows[0].last_update);

                        console.log(data);
                        return _context2.abrupt('return', data);

                    case 17:
                        _context2.prev = 17;
                        _context2.t0 = _context2['catch'](2);

                        console.log(_context2.t0);
                        return _context2.abrupt('return', 501);

                    case 21:
                    case 'end':
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[2, 17]]);
    }));

    return function (_x2) {
        return _ref2.apply(this, arguments);
    };
}();

repository.addSession = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req) {
        var sqlAddSession, sqlGetLastSessionCreated, getIdSession;
        return regeneratorRuntime.wrap(function _callee4$(_context4) {
            while (1) {
                switch (_context4.prev = _context4.next) {
                    case 0:
                        // console.log(req.body)
                        sqlAddSession = "INSERT INTO _session (id_user, id_session_type, name, creation_date, last_update) VALUES ($1, $2, $3, $4, $5)";
                        _context4.prev = 1;
                        _context4.next = 4;
                        return _database2.default.query(sqlAddSession, [req.user.id, req.body.id_session_type, req.body.name, new Date(), new Date()]);

                    case 4:
                        sqlGetLastSessionCreated = "SELECT id_session FROM _session WHERE id_user = $1 ORDER BY creation_date DESC";
                        _context4.next = 7;
                        return _database2.default.query(sqlGetLastSessionCreated, [req.user.id]);

                    case 7:
                        getIdSession = _context4.sent;

                        req.body.exercises.forEach(function () {
                            var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(exercise) {
                                var parsed_exercise, sqlGetIdAppExercise, getIdAppExercise, insertInSessionExercise;
                                return regeneratorRuntime.wrap(function _callee3$(_context3) {
                                    while (1) {
                                        switch (_context3.prev = _context3.next) {
                                            case 0:
                                                parsed_exercise = JSON.parse(exercise);
                                                sqlGetIdAppExercise = "SELECT id_app_exercise FROM _exercise WHERE id_exercise = $1";
                                                _context3.next = 4;
                                                return _database2.default.query(sqlGetIdAppExercise, [parsed_exercise.id]);

                                            case 4:
                                                getIdAppExercise = _context3.sent;
                                                insertInSessionExercise = "INSERT INTO _session_exercise (id_user, id_user_1, id_session, id_exercise, id_app_exercise, place) VALUES ($1, $2, $3, $4, $5, $6)";
                                                _context3.next = 8;
                                                return _database2.default.query(insertInSessionExercise, [req.user.id, req.user.id, getIdSession.rows[0].id_session, parsed_exercise.id, getIdAppExercise.rows[0].id_app_exercise, parsed_exercise.place]);

                                            case 8:
                                            case 'end':
                                                return _context3.stop();
                                        }
                                    }
                                }, _callee3, undefined);
                            }));

                            return function (_x4) {
                                return _ref4.apply(this, arguments);
                            };
                        }());
                        return _context4.abrupt('return', 201);

                    case 12:
                        _context4.prev = 12;
                        _context4.t0 = _context4['catch'](1);

                        console.log(_context4.t0);
                        return _context4.abrupt('return', 501);

                    case 16:
                    case 'end':
                        return _context4.stop();
                }
            }
        }, _callee4, undefined, [[1, 12]]);
    }));

    return function (_x3) {
        return _ref3.apply(this, arguments);
    };
}();

repository.deleteSession = function () {
    var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req) {
        var sqlDeleteSession;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        console.log(req.body);
                        sqlDeleteSession = "DELETE FROM _session WHERE id_user = $1 AND id_session = $2";
                        _context5.prev = 2;
                        _context5.next = 5;
                        return _database2.default.query(sqlDeleteSession, [req.user.id, req.params.id_session]);

                    case 5:
                        return _context5.abrupt('return', 200);

                    case 8:
                        _context5.prev = 8;
                        _context5.t0 = _context5['catch'](2);

                        console.log(_context5.t0);
                        return _context5.abrupt('return', 501);

                    case 12:
                    case 'end':
                        return _context5.stop();
                }
            }
        }, _callee5, undefined, [[2, 8]]);
    }));

    return function (_x5) {
        return _ref5.apply(this, arguments);
    };
}();

repository.updateSession = function () {
    var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(req) {
        var sql;
        return regeneratorRuntime.wrap(function _callee7$(_context7) {
            while (1) {
                switch (_context7.prev = _context7.next) {
                    case 0:
                        sql = "UPDATE _session SET name = $1, last_update = $2 WHERE id_user = $3 AND id_session = $4";
                        _context7.prev = 1;
                        _context7.next = 4;
                        return _database2.default.query(sql, [req.body.name, new Date(), req.user.id, req.params.id_session]);

                    case 4:
                        sql = "DELETE FROM _session_exercise WHERE id_user = $1 AND id_user_1 = $2 AND id_session = $3";
                        _context7.next = 7;
                        return _database2.default.query(sql, [req.user.id, req.user.id, req.params.id_session]);

                    case 7:
                        sql = "INSERT INTO _session_exercise (id_user, id_user_1, id_session, id_exercise, id_app_exercise, place) VALUES ($1,$2,$3,$4,$5,$6)";
                        req.body.exercises.forEach(function () {
                            var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(exercise) {
                                var exercises_parsed, result;
                                return regeneratorRuntime.wrap(function _callee6$(_context6) {
                                    while (1) {
                                        switch (_context6.prev = _context6.next) {
                                            case 0:
                                                exercises_parsed = JSON.parse(exercise);
                                                _context6.next = 3;
                                                return _database2.default.query("SELECT id_app_exercise FROM _app_exercise WHERE name = $1", [exercises_parsed.appExerciseName]);

                                            case 3:
                                                result = _context6.sent;

                                                console.log(result);
                                                _context6.next = 7;
                                                return _database2.default.query(sql, [req.user.id, req.user.id, req.params.id_session, exercises_parsed.id, result.rows[0].id_app_exercise, exercises_parsed.place]);

                                            case 7:
                                            case 'end':
                                                return _context6.stop();
                                        }
                                    }
                                }, _callee6, undefined);
                            }));

                            return function (_x7) {
                                return _ref7.apply(this, arguments);
                            };
                        }());
                        return _context7.abrupt('return', 200);

                    case 12:
                        _context7.prev = 12;
                        _context7.t0 = _context7['catch'](1);

                        console.log(_context7.t0);
                        return _context7.abrupt('return', 501);

                    case 16:
                    case 'end':
                        return _context7.stop();
                }
            }
        }, _callee7, undefined, [[1, 12]]);
    }));

    return function (_x6) {
        return _ref6.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=SessionRepository.js.map