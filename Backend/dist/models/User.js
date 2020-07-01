"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var User = function User(id_user, email, password, firstname, lastname, phonenumber, birthdate, username, signeddate, recoverycode) {
    _classCallCheck(this, User);

    this.id_user = id_user;
    this.email = email;
    this.password = password;
    this.firstname = firstname;
    this.lastname = lastname;
    this.phonenumber = phonenumber;
    this.birthdate = birthdate;
    this.username = username;
    this.signeddate = signeddate;
    this.recoverycode = recoverycode;
};

exports.default = User;
//# sourceMappingURL=User.js.map