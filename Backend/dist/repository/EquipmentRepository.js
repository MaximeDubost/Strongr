"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};
repository.getEquipmentByID = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req) {
        var sql, result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        sql = "\n    SELECT id_equipment as id, name, description, image\n    FROM _equipment \n    WHERE id_equipment = $1    \n    ";
                        _context.prev = 1;
                        _context.next = 4;
                        return _database2.default.query(sql, [req.params.id_equipment]);

                    case 4:
                        result = _context.sent;
                        return _context.abrupt("return", result.rows);

                    case 8:
                        _context.prev = 8;
                        _context.t0 = _context["catch"](1);

                        console.log(_context.t0);
                        return _context.abrupt("return", 500);

                    case 12:
                    case "end":
                        return _context.stop();
                }
            }
        }, _callee, undefined, [[1, 8]]);
    }));

    return function (_x) {
        return _ref.apply(this, arguments);
    };
}();
exports.default = repository;
//# sourceMappingURL=EquipmentRepository.js.map