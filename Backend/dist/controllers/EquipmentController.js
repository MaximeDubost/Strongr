"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _EquipmentRepository = require("../repository/EquipmentRepository");

var _EquipmentRepository2 = _interopRequireDefault(_EquipmentRepository);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var controller = {};

controller.getEquipmentByID = function () {
    var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(req, res) {
        var result;
        return regeneratorRuntime.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        _context.next = 2;
                        return _EquipmentRepository2.default.getEquipmentByID(req);

                    case 2:
                        result = _context.sent;

                        if (result != 500) {
                            res.status(200).json(result);
                        } else {
                            res.sendStatus(result);
                        }

                    case 4:
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
exports.default = controller;
//# sourceMappingURL=EquipmentController.js.map