"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _bcrypt = require("bcrypt");

var _bcrypt2 = _interopRequireDefault(_bcrypt);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

/**
 * @param id_user int
 */
repository.getUser = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(id_user) {
        var sqlGetUser, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        sqlGetUser = "SELECT * FROM _user as u WHERE u.id_user = $1::int";
                        _context.prev = 1;
                        _context.next = 4;
                        return _database2.default.query(sqlGetUser, [id_user]);

                    case 4:
                        result = _context.sent;

                        if (!result.rows[0]) {
                            _context.next = 9;
                            break;
                        }

                        return _context.abrupt("return", result.rows[0]);

                    case 9:
                        return _context.abrupt("return", null);

                    case 10:
                        _context.next = 15;
                        break;

                    case 12:
                        _context.prev = 12;
                        _context.t0 = _context["catch"](1);

                        console.error(_context.t0);

                    case 15:
                    case "end":
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[1, 12]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();

repository.register = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(body) {
        var res, sqlExist, result, birth_to_datetime, sqlRegister;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        res = void 0;
                        sqlExist = "SELECT * FROM _user u WHERE u.username = $1::varchar";
                        _context2.prev = 2;
                        _context2.next = 5;
                        return _database2.default.query(sqlExist, [body.username]);

                    case 5:
                        result = _context2.sent;

                        if (!(result.rows.length > 0)) {
                            _context2.next = 10;
                            break;
                        }

                        res = 409;
                        _context2.next = 15;
                        break;

                    case 10:
                        birth_to_datetime = new Date(body.birthdate);
                        sqlRegister = "INSERT INTO _user (email, password, firstname, lastname, phonenumber, birthdate, username, signeddate) VALUES($1, $2, $3, $4, $5, $6, $7, $8)";
                        _context2.next = 14;
                        return _database2.default.query(sqlRegister, [body.email, _bcrypt2.default.hashSync(body.password, 10), body.firstname, body.lastname, body.phonenumber, birth_to_datetime, body.username, new Date()]);

                    case 14:
                        res = 201;

                    case 15:
                        return _context2.abrupt("return", res);

                    case 18:
                        _context2.prev = 18;
                        _context2.t0 = _context2["catch"](2);

                        console.error(_context2.t0);

                    case 21:
                    case "end":
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[2, 18]]);
    }));

    return function (_x2) {
        return _ref2.apply(this, arguments);
    };
}();

repository.checkEmail = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(email) {
        var res, sqlExistEmail, result;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        res = void 0;
                        sqlExistEmail = "SELECT * FROM _user u WHERE u.email = $1";
                        _context3.prev = 2;
                        _context3.next = 5;
                        return _database2.default.query(sqlExistEmail, [email]);

                    case 5:
                        result = _context3.sent;

                        if (result.rows.length > 0) {
                            res = 409;
                        } else {
                            res = 200;
                        }
                        return _context3.abrupt("return", res);

                    case 10:
                        _context3.prev = 10;
                        _context3.t0 = _context3["catch"](2);

                        console.error(_context3.t0);

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

repository.updateUser = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(id_user, body) {
        var res, birth_to_datetime, sqlUpdate;
        return regeneratorRuntime.wrap(function _callee4$(_context4) {
            while (1) {
                switch (_context4.prev = _context4.next) {
                    case 0:
                        res = void 0;
                        birth_to_datetime = new Date(body.birthdate);
                        sqlUpdate = "UPDATE _user SET firstname = $1::varchar, lastname = $2::varchar, username = $3::varchar, email = $4::varchar, birthdate = $5::date, phonenumber = $6::varchar, password = $7::varchar  WHERE id_user = $8::int";
                        _context4.prev = 3;
                        _context4.next = 6;
                        return _database2.default.query(sqlUpdate, [body.firstname, body.lastname, body.username, body.email, birth_to_datetime, body.phonenumber, _bcrypt2.default.hashSync(body.password, _bcrypt2.default.genSaltSync(10)), id_user]);

                    case 6:
                        res = 200;
                        _context4.next = 13;
                        break;

                    case 9:
                        _context4.prev = 9;
                        _context4.t0 = _context4["catch"](3);

                        console.error(_context4.t0);
                        res = 501;

                    case 13:
                        return _context4.abrupt("return", res);

                    case 14:
                    case "end":
                        return _context4.stop();
                }
            }
        }, _callee4, undefined, [[3, 9]]);
    }));

    return function (_x4, _x5) {
        return _ref4.apply(this, arguments);
    };
}();

repository.deleteUser = function () {
    var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(id_user) {
        var sqlDelete;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        sqlDelete = "DELETE FROM _user as u WHERE u.id_user = $1::int";
                        _context5.prev = 1;
                        _context5.next = 4;
                        return _database2.default.query(sqlDelete, [id_user]);

                    case 4:
                        return _context5.abrupt("return", 200);

                    case 7:
                        _context5.prev = 7;
                        _context5.t0 = _context5["catch"](1);

                        console.log(_context5.t0);
                        return _context5.abrupt("return", 501);

                    case 11:
                    case "end":
                        return _context5.stop();
                }
            }
        }, _callee5, undefined, [[1, 7]]);
    }));

    return function (_x6) {
        return _ref5.apply(this, arguments);
    };
}();

repository.login = function () {
    var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(body) {
        var sqlLogin;
        return regeneratorRuntime.wrap(function _callee6$(_context6) {
            while (1) {
                switch (_context6.prev = _context6.next) {
                    case 0:
                        sqlLogin = void 0;


                        if (body.connectId.indexOf('@') != -1) {
                            sqlLogin = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
                        } else {
                            sqlLogin = "SELECT * FROM _user as u WHERE u.username = $1::varchar ";
                        }
                        _context6.prev = 2;
                        _context6.next = 5;
                        return _database2.default.query(sqlLogin, [body.connectId]);

                    case 5:
                        return _context6.abrupt("return", _context6.sent);

                    case 8:
                        _context6.prev = 8;
                        _context6.t0 = _context6["catch"](2);

                        console.log(_context6.t0);

                    case 11:
                    case "end":
                        return _context6.stop();
                }
            }
        }, _callee6, undefined, [[2, 8]]);
    }));

    return function (_x7) {
        return _ref6.apply(this, arguments);
    };
}();

repository.sendCode = function () {
    var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(email) {
        var sqlEmailUser, result, code, sqlChangeCode;
        return regeneratorRuntime.wrap(function _callee7$(_context7) {
            while (1) {
                switch (_context7.prev = _context7.next) {
                    case 0:
                        _context7.prev = 0;
                        sqlEmailUser = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
                        _context7.next = 4;
                        return _database2.default.query(sqlEmailUser, [email]);

                    case 4:
                        result = _context7.sent;

                        if (!(result.rows.length != 0)) {
                            _context7.next = 14;
                            break;
                        }

                        code = "";

                        while (code.length < 8) {
                            code += Math.floor(Math.random() * 9 + 1).toString();
                        }
                        sqlChangeCode = "UPDATE _user SET recoverycode = $1::varchar WHERE id_user = $2::int";
                        _context7.next = 11;
                        return _database2.default.query(sqlChangeCode, [code, result.rows[0].id_user]);

                    case 11:
                        return _context7.abrupt("return", code);

                    case 14:
                        return _context7.abrupt("return", 404);

                    case 15:
                        _context7.next = 20;
                        break;

                    case 17:
                        _context7.prev = 17;
                        _context7.t0 = _context7["catch"](0);

                        console.log(_context7.t0);

                    case 20:
                    case "end":
                        return _context7.stop();
                }
            }
        }, _callee7, undefined, [[0, 17]]);
    }));

    return function (_x8) {
        return _ref7.apply(this, arguments);
    };
}();

repository.checkCode = function () {
    var _ref8 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8(body) {
        var sqlCheckCode;
        return regeneratorRuntime.wrap(function _callee8$(_context8) {
            while (1) {
                switch (_context8.prev = _context8.next) {
                    case 0:
                        sqlCheckCode = "SELECT * FROM _user WHERE email = $1::varchar AND recoverycode = $2::varchar";
                        _context8.next = 3;
                        return _database2.default.query(sqlCheckCode, [body.email, body.code]);

                    case 3:
                        return _context8.abrupt("return", _context8.sent);

                    case 4:
                    case "end":
                        return _context8.stop();
                }
            }
        }, _callee8, undefined);
    }));

    return function (_x9) {
        return _ref8.apply(this, arguments);
    };
}();

repository.deleteCode = function () {
    var _ref9 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee9(body) {
        var sqlDeleteCode;
        return regeneratorRuntime.wrap(function _callee9$(_context9) {
            while (1) {
                switch (_context9.prev = _context9.next) {
                    case 0:
                        sqlDeleteCode = "UPDATE _user SET recoverycode = NULL WHERE email = $1::varchar";
                        _context9.prev = 1;
                        _context9.next = 4;
                        return _database2.default.query(sqlDeleteCode, [body.email]);

                    case 4:
                        return _context9.abrupt("return", 200);

                    case 7:
                        _context9.prev = 7;
                        _context9.t0 = _context9["catch"](1);

                        console.log(_context9.t0);
                        return _context9.abrupt("return", _context9.t0);

                    case 11:
                    case "end":
                        return _context9.stop();
                }
            }
        }, _callee9, undefined, [[1, 7]]);
    }));

    return function (_x10) {
        return _ref9.apply(this, arguments);
    };
}();

repository.resetPassword = function () {
    var _ref10 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee10(body) {
        var sqlResetPassword;
        return regeneratorRuntime.wrap(function _callee10$(_context10) {
            while (1) {
                switch (_context10.prev = _context10.next) {
                    case 0:
                        sqlResetPassword = "UPDATE _user SET password = $1::varchar WHERE email = $2::varchar";
                        _context10.prev = 1;
                        _context10.next = 4;
                        return _database2.default.query(sqlResetPassword, [_bcrypt2.default.hashSync(body.password, 10), body.email]);

                    case 4:
                        return _context10.abrupt("return", _context10.sent);

                    case 7:
                        _context10.prev = 7;
                        _context10.t0 = _context10["catch"](1);

                        console.log(_context10.t0);

                    case 10:
                    case "end":
                        return _context10.stop();
                }
            }
        }, _callee10, undefined, [[1, 7]]);
    }));

    return function (_x11) {
        return _ref10.apply(this, arguments);
    };
}();

exports.default = repository;
//# sourceMappingURL=UserRepository.js.map