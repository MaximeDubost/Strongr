"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _SessionType = require("../Models/SessionType");

var _SessionType2 = _interopRequireDefault(_SessionType);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.readSessionType = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var session_type_list, sql, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        session_type_list = [];
                        sql = "\n        SELECT id_session_type, name, description\n        FROM _session_type\n    ";
                        _context.prev = 2;
                        _context.next = 5;
                        return _database2.default.query(sql);

                    case 5:
                        result = _context.sent;

                        if (result.rowCount > 0) {
                            result.rows.forEach(function (row) {
                                session_type_list.push(new _SessionType2.default(row.id_session_type, row.name, row.description));
                            });
                        }
                        console.log(session_type_list);
                        return _context.abrupt("return", session_type_list);

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

exports.default = repository;
//# sourceMappingURL=SessionTypeRepository.js.map