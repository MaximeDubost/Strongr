import bcrypt from 'bcrypt';
import jwt from "jsonwebtoken";
import UserError from "../errors/UserError"
//const sqlite3 = require('sqlite3').verbose();
const { Pool } = require('pg')
var clt = null;

const controller = {};

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
            res.status(200).json(body);
        } else {
            throw new UserError(404, 'User not found');
        }
    } catch (error) {
        next(error)
    }
}

controller.addUser = async (req, res, next) => {
    let body = {};
    let sqlExist = "SELECT * FROM _user u WHERE u.username = $1::varchar OR u.email = $2::varchar";
    try {
        var result = await clt.query(sqlExist, [req.body.username, req.body.email])
        if (result.rows.length > 0) {
            throw new UserError(409, "A user with this email or username already exists");
        } else {
            let sqlRegister = "INSERT INTO _user (firstname, lastname, username, email, password) VALUES($1::varchar, $2::varchar, $3::varchar, $4::varchar, $5::varchar )";
            var result = await clt.query(sqlRegister, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, bcrypt.hashSync(req.body.password, 10)])
            body = { message: "User added with success" }
            res.status(201).json(body)
        }
    } catch (error) {
        next(error)
    }
}
controller.updateUser = async (req, res, next) => {
    let body = {};
    let id_user = req.params.id_user;
    let sqlUpdate = "UPDATE _user SET firstname = $1::varchar, lastname = $2::varchar, username = $3::varchar, email = $4::varchar, password = $5::varchar WHERE id_user = $6::int";
    try {
        await clt.query(sqlUpdate, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, bcrypt.hashSync(req.body.password, 10), id_user]);
        body = { message: "User updated with success" };
        res.status(200).json(body);
    } catch (error) {
        next(error)
    }
}

controller.deleteUser = async (req, res, next) => {
    let body = {};
    let status = 200;

    let sqlDelete = "DELETE FROM _user as u WHERE u.id_user = $1::int";
    try {
        await clt.query(sqlDelete, [req.params.id_user])
        body = { message: "User deleted with success" };
        res.status(200).json(body);
    } catch (error) {
        next(error)
    }
}
controller.login = async (req, res, next) => {
    let body = {};
    let status = 200;

    let sqlLogin;
    if (req.body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
    } else {
        sqlLogin = "SELECT * FROM _user as u WHERE u.username = $1::varchar ";
    }
    try {
        var result = await clt.query(sqlLogin, [req.body.connectId])
        if (result.rows.length > 0) {
            if (bcrypt.compareSync(req.body.password, result.rows[0].password)) {
                var token = jwt.sign({
                    id: result.rows[0].id_user,
                    email: result.rows[0].email,
                    username: result.rows[0].username
                }, "SECRET")
                body = {
                    message: "Authentificate with success"
                };
                res.set("authorization", "Bearer " + token).status(status).json(body);
            } else {
                throw new UserError(401, "Authentification failed");
            }
        } else {
            throw new UserError(404, "Your identificator (user or email) isn\'t in our DB so register please");
        }
    } catch (error) {
        next(error)
    }
}

controller.logout = async (req, res) => {
    let body = {};
    res.removeHeader("authorization")
    body = {
        message: "Disconnected"
    }
    res.status(200).json(body)
}


export default controller;