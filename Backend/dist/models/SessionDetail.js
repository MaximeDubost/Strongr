"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var SessionDetail = function SessionDetail(id, name, session_type, exercises, creation_date, last_update) {
    _classCallCheck(this, SessionDetail);

    this.id = id;
    this.name = name;
    this.session_type = session_type;
    this.exercises = exercises;
    this.creation_date = creation_date;
    this.last_update = last_update;
};

exports.default = SessionDetail;
//# sourceMappingURL=SessionDetail.js.map