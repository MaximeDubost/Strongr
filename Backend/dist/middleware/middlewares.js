'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _jsonwebtoken = require('jsonwebtoken');

var _jsonwebtoken2 = _interopRequireDefault(_jsonwebtoken);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var middleware = {};

middleware.checkAuth = function (req, res, next) {
    var authHeader = req.headers['authorization'];
    var token = authHeader && authHeader.split(' ')[1];

    if (token == null) return res.sendStatus(401);

    _jsonwebtoken2.default.verify(token, "SECRET", function (err, user) {
        console.log(err);
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
};

exports.default = middleware;
//# sourceMappingURL=middlewares.js.map