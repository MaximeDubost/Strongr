import bcrypt from 'bcrypt';
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer"

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
controller.getUser = async (req, res, next) => {
    let body = {};
    let sqlGetUser = "SELECT * FROM _user as u WHERE u.id_user = $1::int";
    try {
        var result = await clt.query(sqlGetUser, [req.params.id_user])
        if (result.rows[0]) {
            console.log(result.rows[0]);
            body = {
                message: 'User found',
                user_info: result.rows[0]
            };
            res.status(200).json(body)
        } else {
            res.sendStatus(404)
        }
    } catch (error) {
        console.error(error)
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
    let sqlExist = "SELECT * FROM _user u WHERE u.username = $1::varchar";
    try {
        var result = await clt.query(sqlExist, [req.body.username])
        if (result.rows.length > 0) {
            res.sendStatus(409)
        } else {
            console.log(req.body.birthdate)
            var birth_to_datetime = new Date(req.body.birthdate)
            console.log(birth_to_datetime)
            let sqlRegister = "INSERT INTO _user (firstname, lastname, username, birthdate, phonenumber, email, password, signeddate) VALUES($1, $2, $3, $4, $5, $6, $7, $8)";
            await clt.query(sqlRegister, [req.body.firstname, req.body.lastname, req.body.username, birth_to_datetime, req.body.phonenumber, req.body.email, bcrypt.hashSync(req.body.password, 10), new Date()])
            res.sendStatus(201)
        }
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param email varchar
 */
controller.checkEmail = async (req, res, next) => {
    let sqlExistEmail = "SELECT * FROM _user u WHERE u.email = $1"
    try {
        var result = await clt.query(sqlExistEmail, [req.body.email])
        console.log(result.rows.length)
        if (result.rows.length > 0) {
            res.sendStatus(409)
        } else {
            res.sendStatus(200)
        }
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
controller.updateUser = async (req, res, next) => {
    let id_user = req.params.id_user;
    let sqlUpdate = "UPDATE _user SET firstname = $1::varchar, lastname = $2::varchar, username = $3::varchar, email = $4::varchar, password = $5::varchar WHERE id_user = $6::int";
    try {
        await clt.query(sqlUpdate, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, bcrypt.hashSync(req.body.password, 10), id_user]);
        res.sendStatus(200)
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param id_user int
 */
controller.deleteUser = async (req, res, next) => {
    let sqlDelete = "DELETE FROM _user as u WHERE u.id_user = $1::int";
    try {
        await clt.query(sqlDelete, [req.params.id_user])
        res.sendStatus(200)
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param email varchar,
 * @param password varchar
 */
controller.login = async (req, res, next) => {
    let sqlLogin;
    if (req.body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
    } else {
        sqlLogin = "SELECT * FROM _user as u WHERE u.username = $1::varchar ";
    }
    try {
        var result = await clt.query(sqlLogin, [req.body.connectId])
        if (result.rows.length > 0) {
            console.log(result.rows);
            console.log(bcrypt.compareSync(req.body.password, result.rows[0].password))
            console.log(req.body.password)
            console.log(result.rows[0].password)
            if (bcrypt.compareSync(req.body.password, result.rows[0].password)) {
                var token = jwt.sign({
                    id: result.rows[0].id_user,
                    email: result.rows[0].email,
                    username: result.rows[0].username
                }, "SECRET")
                res.status(200).json({ token })
            } else {
                res.sendStatus(401)
            }
        } else {
            res.sendStatus(404)
        }
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