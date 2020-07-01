"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _Muscle = require("../Models/Muscle");

var _Muscle2 = _interopRequireDefault(_Muscle);

var _AppExercise = require("../Models/AppExercise");

var _AppExercise2 = _interopRequireDefault(_AppExercise);

var _Equipment = require("../Models/Equipment");

var _Equipment2 = _interopRequireDefault(_Equipment);

var _database = require("../core/config/database");

var _database2 = _interopRequireDefault(_database);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

var repository = {};

repository.getAllAppExercises = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee() {
  var appExList, sqlGetAllAppExercises, result, exists, j, k, i;
  return regeneratorRuntime.wrap(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          appExList = [];
          sqlGetAllAppExercises = "\n    SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name\n    FROM _app_exercise ae\n    JOIN _app_exercise_muscle ta ON ae.id_app_exercise = ta.id_app_exercise\n    JOIN _muscle mu ON ta.id_muscle = mu.id_muscle\n    ORDER BY id_app_exercise\n    ";
          _context.prev = 2;
          _context.next = 5;
          return _database2.default.query(sqlGetAllAppExercises);

        case 5:
          result = _context.sent;

          // console.log(result.rows)
          exists = false;
          j = 0;
          k = -1;
          // console.log()
          // console.log("ID du dernier élément : " + result.rows[result.rows.length - 1].id_app_exercise)
          // console.log()

          for (i = 1; i <= result.rows[result.rows.length - 1].id_app_exercise; i++) {
            // console.log("(i) Tour de boucle : " + i)
            result.rows.map(function (row) {
              if (i === row.id_app_exercise) {
                if (!exists) {
                  appExList.push(new _AppExercise2.default(row.id_app_exercise, row.exercise_name, [], []));
                  exists = true;
                  k++;
                }
                // console.log("Avant push muscle ", appExList[k])
                _AppExercise2.default.class(appExList[k]).muscleList.push(new _Muscle2.default(row.id_muscle, row.muscle_name));
                // console.log("Après push muscle ", appExList[k])
                j++;
                // console.log("(j) Nb Muscle(s) ajouté(s) à cet AE : " + j)
                // console.log("(k) Indice dans appExList : " + k)
              }
            });
            exists = false;
            j = 0;
            // console.log()
          }
          // console.log(appExList)
          return _context.abrupt("return", appExList);

        case 13:
          _context.prev = 13;
          _context.t0 = _context["catch"](2);

          console.error(_context.t0);

        case 16:
        case "end":
          return _context.stop();
      }
    }
  }, _callee, undefined, [[2, 13]]);
}));

repository.getDetailAppExercise = function () {
  var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2(body) {
    var appEx, muscleList, equipmentList, Newsql, result, resultEquipment;
    return regeneratorRuntime.wrap(function _callee2$(_context2) {
      while (1) {
        switch (_context2.prev = _context2.next) {
          case 0:
            appEx = {};
            muscleList = [];
            equipmentList = [];
            // let Oldsql = `
            // SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name, eq.name as equipment_name, eq.id_equipment as id_equipment
            // FROM _app_exercise ae JOIN _app_exercise_muscle ta ON ae.id_app_exercise = ta.id_app_exercise
            // JOIN _muscle mu ON ta.id_muscle = mu.id_muscle
            // JOIN _app_exercise_equipment aeeq ON ae.id_app_exercise = aeeq.id_app_exercise
            // JOIN _equipment eq ON eq.id_equipment = aeeq.id_equipment
            // WHERE ae.id_app_exercise = $1
            // `

            Newsql = "\n    SELECT ae.id_app_exercise, ae.name as exercise_name, mu.id_muscle, mu.name as muscle_name\n    FROM _app_exercise ae \n    JOIN _app_exercise_muscle ta ON ae.id_app_exercise = ta.id_app_exercise\n    JOIN _muscle mu ON ta.id_muscle = mu.id_muscle\n    WHERE ae.id_app_exercise = $1\n    ";
            _context2.prev = 4;
            _context2.next = 7;
            return _database2.default.query(Newsql, [body.id_app_exercise]);

          case 7:
            result = _context2.sent;

            console.log(result.rows);
            result.rows.map(function (row) {
              var muscle = muscleList.filter(function (muscle) {
                return muscle.id === row.id_muscle;
              });
              if (muscle.length == 0) {
                muscleList.push(new _Muscle2.default(row.id_muscle, row.muscle_name));
              }
            });
            _context2.next = 12;
            return _database2.default.query("SELECT eq.id_equipment, eq.name\n        FROM _equipment eq\n        JOIN _app_exercise_equipment aeeq ON eq.id_equipment  = aeeq.id_equipment\n        WHERE aeeq.id_app_exercise = $1", [body.id_app_exercise]);

          case 12:
            resultEquipment = _context2.sent;


            if (resultEquipment.rowCount != 0) {
              resultEquipment.rows.map(function (row) {
                var equipment = equipmentList.filter(function (equipment) {
                  return equipment.id === row.id_equipment;
                });
                if (equipment.length == 0) {
                  equipmentList.push(new _Equipment2.default(row.id_equipment, row.name));
                }
              });
            }

            console.log("Endboucle", equipmentList);
            appEx = new _AppExercise2.default(result.rows[0].id_app_exercise, result.rows[0].exercise_name, muscleList, equipmentList);
            console.log(appEx);
            // var exists = false
            // var j = 0
            // var k = -1
            // for (var i = 1; i <= result.rows[result.rows.length - 1].id_app_exercise; i++) {
            //     result.rows.map((row) => {
            //         if (i === row.id_app_exercise) {
            //             if (!exists) {
            //                 appExList.push(new AppExercise(row.id_app_exercise, row.exercise_name, [], []))
            //                 exists = true
            //                 k++
            //             }
            //             // console.log("Avant push muscle ", appExList[j])
            //             var muscleExist = AppExercise.class(appExList[k]).muscleList.filter(muscle => muscle.id === row.id_muscle)
            //             // console.log(muscleExist.length)
            //             if (muscleExist.length === 0) {
            //                 AppExercise.class(appExList[k]).muscleList.push(new Muscle(row.id_muscle, row.muscle_name))
            //             }
            //             var equipmentExist = AppExercise.class(appExList[k]).equipmentList.filter(equipment => equipment.id === row.id_equipment)
            //             // console.log(equipmentExist.length)
            //             if (equipmentExist.length === 0) {
            //                 AppExercise.class(appExList[k]).equipmentList.push(new Equipment(row.id_equipment, row.equipment_name))
            //             }
            //             // console.log("Après push muscle ", appExList[j])
            //             j++
            //         }
            //     })
            //     exists = false
            //     j = 0
            // }
            // return appExList;
            return _context2.abrupt("return", appEx);

          case 20:
            _context2.prev = 20;
            _context2.t0 = _context2["catch"](4);

            console.error(_context2.t0);

          case 23:
          case "end":
            return _context2.stop();
        }
      }
    }, _callee2, undefined, [[4, 20]]);
  }));

  return function (_x) {
    return _ref2.apply(this, arguments);
  };
}();

repository.getAppExercisesByIdMuscle = function () {
  var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3(req) {
    var sql, result;
    return regeneratorRuntime.wrap(function _callee3$(_context3) {
      while (1) {
        switch (_context3.prev = _context3.next) {
          case 0:
            sql = "SELECT ae.id_app_exercise as id, ae.name FROM _app_exercise ae JOIN _app_exercise_muscle aem ON ae.id_app_exercise = aem.id_app_exercise WHERE aem.id_muscle = $1";
            _context3.prev = 1;
            _context3.next = 4;
            return _database2.default.query(sql, [req.params.id_muscle]);

          case 4:
            result = _context3.sent;
            return _context3.abrupt("return", result.rows);

          case 8:
            _context3.prev = 8;
            _context3.t0 = _context3["catch"](1);

            console.error(_context3.t0);

          case 11:
          case "end":
            return _context3.stop();
        }
      }
    }, _callee3, undefined, [[1, 8]]);
  }));

  return function (_x2) {
    return _ref3.apply(this, arguments);
  };
}();

repository.getAppExercisesByIdEquipment = function () {
  var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(req) {
    var sql, result;
    return regeneratorRuntime.wrap(function _callee4$(_context4) {
      while (1) {
        switch (_context4.prev = _context4.next) {
          case 0:
            sql = "SELECT ae.id_app_exercise as id, ae.name FROM _app_exercise ae JOIN _app_exercise_equipment aee ON ae.id_app_exercise = aee.id_app_exercise WHERE aee.id_equipment = $1";
            _context4.prev = 1;
            _context4.next = 4;
            return _database2.default.query(sql, [req.params.id_equipment]);

          case 4:
            result = _context4.sent;
            return _context4.abrupt("return", result.rows);

          case 8:
            _context4.prev = 8;
            _context4.t0 = _context4["catch"](1);

            console.error(_context4.t0);

          case 11:
          case "end":
            return _context4.stop();
        }
      }
    }, _callee4, undefined, [[1, 8]]);
  }));

  return function (_x3) {
    return _ref4.apply(this, arguments);
  };
}();

exports.default = repository;
//# sourceMappingURL=AppExerciseRepository.js.map