import bcrypt from 'bcrypt';
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer"

import userRepository from "../repository/userRepository"
import UserError from "../errors/UserError"

const { Pool } = require('pg')
var clt = null;
const controller = {};

let transport = nodemailer.createTransport({
    service: 'gmail',
    secure: false,
    port: 25,
    auth: {
        user: 'team.strongr',
        pass: '#5tr0n63R'
    }
});
const pool = new Pool({
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'root',
    database: 'StrongrDB'
});

pool.connect((err, client, release) => {
    console.log("In pool connect");
    if (err) {
        return console.error("Error acquiring client", err.stack);
    } else {
        clt = client;
    }
});
/**
 * @param id_user int
 */
controller.getUser = async (req, res) => {
    let body = {};
    let user = await userRepository.getUser(req.params.id_user);
    if (user) {
        body = {
            message: 'User found',
            user_info: user
        };
        res.status(200).json(body)
    } else {
        res.sendStatus(404)
    }
}
/**
 * @param username varchar,
 * @param firstname varchar,
 * @param lastname varchar,
 * @param password varchar,
 * @param email varchar,
 */
controller.register = async (req, res, next) => {
    try {
        let userRegistered = await userRepository.regiter(req.body);
        res.sendStatus(userRegistered);
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param email varchar
 */
controller.checkEmail = async (req, res) => {
    try {
        let emailChecked = await userRepository.checkEmail(req.body.email);
        res.sendStatus(emailChecked);
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param id_user int
 * @param firstname varchar,
 * @param lastname varchar,
 * @param username varchar,
 * @param email varchar,
 * @param password varchar
 */
controller.updateUser = async (req, res) => {
    try {
        let userUpdated = await userRepository.updateUser(req.params.id_user, req.body);
        res.sendStatus(userUpdated);
    } catch (error) {
        console.error(error);
    }
}
/**
 * @param id_user int
 */
controller.deleteUser = async (req, res) => {
    try {
        let userDeleted = await userRepository.deleteUser(req.params.id_user);
        res.sendStatus(userDeleted);
    } catch (error) {
        console.error(error);
    }
}
/**
 * @param email varchar,
 * @param password varchar
 */
controller.login = async (req, res, next) => {

    try {
        let userLogged = await userRepository.login(req.body);
        console.log(userLogged);
    } catch (error) {
        console.error(error)
    }
}

controller.logout = (req, res) => {
    res.sendStatus(200)
}
/**
 * @param email
 */
controller.sendCode = async (req, res, next) => {
    var sqlEmailUser = "SELECT * FROM _user as u WHERE u.email = $1::varchar "
    try {
        var result = await clt.query(sqlEmailUser, [req.body.email])
        if (result.rows.length != 0) {
            var code = "";
            while (code.length < 8) {
                code += Math.floor(Math.random() * 9 + 1).toString()
            }
            var sqlChangeCode = "UPDATE _user SET recoverycode = $1::varchar WHERE id_user = $2::int"
            await clt.query(sqlChangeCode, [code, result.rows[0].id_user]);
            const message = {
                from: 'team.strongr@gmail.com', // Sender address
                to: req.body.email,         // List of recipients
                subject: 'Code de réinitialisation de mot de passe', // Subject line
                text: "Bonjour, \n\n Votre code est le suivant : " + code + ".\n\n Si vous n’avez pas fait de demande pour un code, merci de contacter le service client pour vous assurer qu’il ne s’agit pas d’une tentative de fraude.\n\n\n - Strongr Team" // Plain text body
            };
            var info = await transport.sendMail(message)
            res.sendStatus(200)
        } else {
            res.sendStatus(404)
        }
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param recoverycode varchar
 */
controller.checkCode = async (req, res, next) => {
    var sqlCheckCode = "SELECT * FROM _user WHERE recoverycode = $1::varchar"
    try {
        var result = await clt.query(sqlCheckCode, [req.body.code])
        console.log(result.rows)
        if (result.rows.length != 0) {
            res.sendStatus(200)
        } else {
            res.sendStatus(401)
        }
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param email varchar,
 * @param password  varchar
 */
controller.resetPassword = async (req, res, next) => {
    let body = {};
    var sqlResetPassword = "UPDATE _user SET password = $1::varchar WHERE email = $2::varchar"
    try {
        await clt.query(sqlResetPassword, [bcrypt.hashSync(req.body.password, 10), req.body.email])
        res.sendStatus(200)
    } catch (error) {
        console.error(error)
    }
}



export default controller;