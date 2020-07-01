"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _bcrypt = require("bcrypt");

var _bcrypt2 = _interopRequireDefault(_bcrypt);

var _jsonwebtoken = require("jsonwebtoken");

var _jsonwebtoken2 = _interopRequireDefault(_jsonwebtoken);

var _nodemailer = require("nodemailer");

var _nodemailer2 = _interopRequireDefault(_nodemailer);

var _UserRepository = require("../repository/UserRepository");

var _UserRepository2 = _interopRequireDefault(_UserRepository);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var controller = {};

var transport = _nodemailer2.default.createTransport({
    service: 'gmail',
    secure: false,
    port: 25,
    auth: {
        user: 'team.strongr',
        pass: '#5tr0n63R'
    }
});
/**
 * @param id_user int
 */
controller.getUser = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req, res) {
        var body, user;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        body = {};
                        _context.next = 3;
                        return _UserRepository2.default.getUser(req.params.id_user);

                    case 3:
                        user = _context.sent;

                        if (user) {
                            body = {
                                message: 'User found',
                                user_info: user
                            };
                            res.status(200).json(body);
                        } else {
                            res.sendStatus(404);
                        }

                    case 5:
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
 * @param username varchar,
 * @param firstname varchar,
 * @param lastname varchar,
 * @param password varchar,
 * @param email varchar,
 */
controller.register = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req, res) {
        var userRegistered;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        _context2.prev = 0;
                        _context2.next = 3;
                        return _UserRepository2.default.register(req.body);

                    case 3:
                        userRegistered = _context2.sent;

                        res.sendStatus(userRegistered);
                        _context2.next = 10;
                        break;

                    case 7:
                        _context2.prev = 7;
                        _context2.t0 = _context2["catch"](0);

                        console.error(_context2.t0);

                    case 10:
                    case "end":
                        return _context2.stop();
                }
            }
        }, _callee2, undefined, [[0, 7]]);
    }));

    return function (_x3, _x4) {
        return _ref2.apply(this, arguments);
    };
}();
/**
 * @param email varchar
 */
controller.checkEmail = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req, res) {
        var emailChecked;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        _context3.prev = 0;
                        _context3.next = 3;
                        return _UserRepository2.default.checkEmail(req.body.email);

                    case 3:
                        emailChecked = _context3.sent;

                        res.sendStatus(emailChecked);
                        _context3.next = 10;
                        break;

                    case 7:
                        _context3.prev = 7;
                        _context3.t0 = _context3["catch"](0);

                        console.error(_context3.t0);

                    case 10:
                    case "end":
                        return _context3.stop();
                }
            }
        }, _callee3, undefined, [[0, 7]]);
    }));

    return function (_x5, _x6) {
        return _ref3.apply(this, arguments);
    };
}();
/**
 * @param id_user int
 * @param firstname varchar,
 * @param lastname varchar,
 * @param username varchar,
 * @param email varchar,
 * @param password varchar
 */
controller.updateUser = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req, res) {
        var userUpdated;
        return regeneratorRuntime.wrap(function _callee4$(_context4) {
            while (1) {
                switch (_context4.prev = _context4.next) {
                    case 0:
                        _context4.prev = 0;
                        _context4.next = 3;
                        return _UserRepository2.default.updateUser(req.params.id_user, req.body);

                    case 3:
                        userUpdated = _context4.sent;

                        res.sendStatus(userUpdated);
                        _context4.next = 10;
                        break;

                    case 7:
                        _context4.prev = 7;
                        _context4.t0 = _context4["catch"](0);

                        console.error(_context4.t0);

                    case 10:
                    case "end":
                        return _context4.stop();
                }
            }
        }, _callee4, undefined, [[0, 7]]);
    }));

    return function (_x7, _x8) {
        return _ref4.apply(this, arguments);
    };
}();
/**
 * @param id_user int
 */
controller.deleteUser = function () {
    var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req, res) {
        var userDeleted;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        _context5.prev = 0;
                        _context5.next = 3;
                        return _UserRepository2.default.deleteUser(req.params.id_user);

                    case 3:
                        userDeleted = _context5.sent;

                        res.sendStatus(userDeleted);
                        _context5.next = 10;
                        break;

                    case 7:
                        _context5.prev = 7;
                        _context5.t0 = _context5["catch"](0);

                        console.error(_context5.t0);

                    case 10:
                    case "end":
                        return _context5.stop();
                }
            }
        }, _callee5, undefined, [[0, 7]]);
    }));

    return function (_x9, _x10) {
        return _ref5.apply(this, arguments);
    };
}();
/**
 * @param email varchar,
 * @param password varchar
 */
controller.login = function () {
    var _ref6 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee6(req, res) {
        var result, token;
        return regeneratorRuntime.wrap(function _callee6$(_context6) {
            while (1) {
                switch (_context6.prev = _context6.next) {
                    case 0:
                        _context6.prev = 0;
                        _context6.next = 3;
                        return _UserRepository2.default.login(req.body);

                    case 3:
                        result = _context6.sent;

                        if (result.rows.length > 0) {
                            if (_bcrypt2.default.compareSync(req.body.password, result.rows[0].password)) {
                                token = _jsonwebtoken2.default.sign({
                                    id: result.rows[0].id_user,
                                    email: result.rows[0].email,
                                    username: result.rows[0].username
                                }, "SECRET");

                                res.status(200).json({ token: token });
                            } else {
                                res.sendStatus(401);
                            }
                        } else {
                            res.sendStatus(404);
                        }
                        _context6.next = 10;
                        break;

                    case 7:
                        _context6.prev = 7;
                        _context6.t0 = _context6["catch"](0);

                        console.error(_context6.t0);

                    case 10:
                    case "end":
                        return _context6.stop();
                }
            }
        }, _callee6, undefined, [[0, 7]]);
    }));

    return function (_x11, _x12) {
        return _ref6.apply(this, arguments);
    };
}();

controller.logout = function (req, res) {
    res.sendStatus(200);
};
/**
 * @param email
 */
controller.sendCode = function () {
    var _ref7 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee7(req, res) {
        var repositoryProcess, message;
        return regeneratorRuntime.wrap(function _callee7$(_context7) {
            while (1) {
                switch (_context7.prev = _context7.next) {
                    case 0:
                        _context7.prev = 0;
                        _context7.next = 3;
                        return _UserRepository2.default.sendCode(req.body.email);

                    case 3:
                        repositoryProcess = _context7.sent;

                        if (!(repositoryProcess != 404)) {
                            _context7.next = 11;
                            break;
                        }

                        message = {
                            from: 'team.strongr@gmail.com', // Sender address
                            to: req.body.email, // List of recipients
                            subject: 'Code de réinitialisation de mot de passe', // Subject line
                            text: "Bonjour, \n\n Votre code est le suivant : " + repositoryProcess + ".\n\n Si vous n’avez pas fait de demande pour un code, merci de contacter le service client pour vous assurer qu’il ne s’agit pas d’une tentative de fraude.\n\n\n - Strongr Team" // Plain text body
                        };
                        _context7.next = 8;
                        return transport.sendMail(message);

                    case 8:
                        res.sendStatus(200);
                        _context7.next = 12;
                        break;

                    case 11:
                        res.sendStatus(repositoryProcess);

                    case 12:
                        _context7.next = 17;
                        break;

                    case 14:
                        _context7.prev = 14;
                        _context7.t0 = _context7["catch"](0);

                        console.error(_context7.t0);

                    case 17:
                    case "end":
                        return _context7.stop();
                }
            }
        }, _callee7, undefined, [[0, 14]]);
    }));

    return function (_x13, _x14) {
        return _ref7.apply(this, arguments);
    };
}();
/**
 * @param recoverycode varchar
 */
controller.checkCode = function () {
    var _ref8 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee8(req, res) {
        var result, deleteCodeRepo;
        return regeneratorRuntime.wrap(function _callee8$(_context8) {
            while (1) {
                switch (_context8.prev = _context8.next) {
                    case 0:
                        _context8.prev = 0;
                        _context8.next = 3;
                        return _UserRepository2.default.checkCode(req.body);

                    case 3:
                        result = _context8.sent;

                        console.log(result);

                        if (!(result.rows.length != 0)) {
                            _context8.next = 12;
                            break;
                        }

                        _context8.next = 8;
                        return _UserRepository2.default.deleteCode(req.body);

                    case 8:
                        deleteCodeRepo = _context8.sent;

                        res.sendStatus(deleteCodeRepo);
                        _context8.next = 13;
                        break;

                    case 12:
                        res.sendStatus(401);

                    case 13:
                        _context8.next = 18;
                        break;

                    case 15:
                        _context8.prev = 15;
                        _context8.t0 = _context8["catch"](0);

                        console.error(_context8.t0);

                    case 18:
                    case "end":
                        return _context8.stop();
                }
            }
        }, _callee8, undefined, [[0, 15]]);
    }));

    return function (_x15, _x16) {
        return _ref8.apply(this, arguments);
    };
}();
/**
 * @param email varchar,
 * @param password  varchar
 */
controller.resetPassword = function () {
    var _ref9 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee9(req, res) {
        return regeneratorRuntime.wrap(function _callee9$(_context9) {
            while (1) {
                switch (_context9.prev = _context9.next) {
                    case 0:
                        _context9.prev = 0;
                        _context9.next = 3;
                        return _UserRepository2.default.resetPassword(req.body);

                    case 3:
                        res.sendStatus(200);
                        _context9.next = 9;
                        break;

                    case 6:
                        _context9.prev = 6;
                        _context9.t0 = _context9["catch"](0);

                        console.error(_context9.t0);

                    case 9:
                    case "end":
                        return _context9.stop();
                }
            }
        }, _callee9, undefined, [[0, 6]]);
    }));

    return function (_x17, _x18) {
        return _ref9.apply(this, arguments);
    };
}();

exports.default = controller;
//# sourceMappingURL=UserController.js.map