"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _SessionRepository = require("../repository/SessionRepository");

var _SessionRepository2 = _interopRequireDefault(_SessionRepository);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var controller = {};

controller.getSessions = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req, res) {
        var session;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        _context.prev = 0;
                        _context.next = 3;
                        return _SessionRepository2.default.getSessions(req);

                    case 3:
                        session = _context.sent;

                        res.status(200).json(session);
                        _context.next = 10;
                        break;

                    case 7:
                        _context.prev = 7;
                        _context.t0 = _context["catch"](0);

                        console.log(_context.t0);

                    case 10:
                    case "end":
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[0, 7]]);
    }));

    return function (_x, _x2) {
        return _ref.apply(this, arguments);
    };
}();

controller.getSessionDetail = function () {
    var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(req, res) {
        var sessions;
        return regeneratorRuntime.wrap(function _callee2$(_context2) {
            while (1) {
                switch (_context2.prev = _context2.next) {
                    case 0:
                        _context2.prev = 0;
                        _context2.next = 3;
                        return _SessionRepository2.default.getSessionDetail(req);

                    case 3:
                        sessions = _context2.sent;

                        if (sessions === 404) {
                            res.sendStatus(session);
                        } else {
                            res.status(200).json(sessions);
                        }
                        _context2.next = 10;
                        break;

                    case 7:
                        _context2.prev = 7;
                        _context2.t0 = _context2["catch"](0);

                        console.log(_context2.t0);

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

controller.addSession = function () {
    var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req, res) {
        var result;
        return regeneratorRuntime.wrap(function _callee3$(_context3) {
            while (1) {
                switch (_context3.prev = _context3.next) {
                    case 0:
                        _context3.prev = 0;

                        console.log(req.body);
                        _context3.next = 4;
                        return _SessionRepository2.default.addSession(req);

                    case 4:
                        result = _context3.sent;

                        if (result == 501) {
                            res.sendStatus(result);
                        } else {
                            res.sendStatus(result);
                        }
                        _context3.next = 11;
                        break;

                    case 8:
                        _context3.prev = 8;
                        _context3.t0 = _context3["catch"](0);

                        console.log(_context3.t0);

                    case 11:
                    case "end":
                        return _context3.stop();
                }
            }
        }, _callee3, undefined, [[0, 8]]);
    }));

    return function (_x5, _x6) {
        return _ref3.apply(this, arguments);
    };
}();

controller.deleteSession = function () {
    var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req, res) {
        var result;
        return regeneratorRuntime.wrap(function _callee4$(_context4) {
            while (1) {
                switch (_context4.prev = _context4.next) {
                    case 0:
                        _context4.prev = 0;
                        _context4.next = 3;
                        return _SessionRepository2.default.deleteSession(req);

                    case 3:
                        result = _context4.sent;

                        if (result == 501) {
                            res.sendStatus(501);
                        } else {
                            res.sendStatus(200);
                        }
                        _context4.next = 10;
                        break;

                    case 7:
                        _context4.prev = 7;
                        _context4.t0 = _context4["catch"](0);

                        console.log(_context4.t0);

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

controller.updateSession = function () {
    var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5(req, res) {
        var result;
        return regeneratorRuntime.wrap(function _callee5$(_context5) {
            while (1) {
                switch (_context5.prev = _context5.next) {
                    case 0:
                        _context5.prev = 0;
                        _context5.next = 3;
                        return _SessionRepository2.default.updateSession(req);

                    case 3:
                        result = _context5.sent;

                        if (result == 501) {
                            res.sendStatus(501);
                        } else {
                            res.sendStatus(200);
                        }
                        _context5.next = 10;
                        break;

                    case 7:
                        _context5.prev = 7;
                        _context5.t0 = _context5["catch"](0);

                        console.log(_context5.t0);

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

exports.default = controller;
//# sourceMappingURL=SessionController.js.map