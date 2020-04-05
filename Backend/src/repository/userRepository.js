import bcrypt from 'bcrypt';
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer"

import UserError from "../errors/UserError"

const { Pool } = require('pg')
var clt = null;
const repository = {};

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
repository.getUser = async (id_user) => {
    let sqlGetUser = "SELECT * FROM _user as u WHERE u.id_user = $1::int";
    try {
        var result = await clt.query(sqlGetUser, [id_user]);

        if (result.rows[0]) {
            return result.rows[0];
        } else {
            return null;
        }
    } catch (error) {
        console.error(error)
    }
}

repository.regiter = async (body) => {
    let res;
    let sqlExist = "SELECT * FROM _user u WHERE u.username = $1::varchar";
    try {
        var result = await clt.query(sqlExist, [body.username]);
        if (result.rows.length > 0) {
            res = 409;
        } else {
            let birth_to_datetime = new Date(body.birthdate);
            let sqlRegister = "INSERT INTO _user (firstname, lastname, username, birthdate, phonenumber, email, password, signeddate) VALUES($1, $2, $3, $4, $5, $6, $7, $8)";
            await clt.query(sqlRegister, [body.firstname, body.lastname, body.username, birth_to_datetime, body.phonenumber, body.email, bcrypt.hashSync(body.password, bcrypt.genSaltSync(10)), new Date()])
            res = 201;
        }
        return res;
    } catch (error) {
        console.error(error)
    }
}

repository.checkEmail = async (email) => {
    let res;
    let sqlExistEmail = "SELECT * FROM _user u WHERE u.email = $1";
    try {
        var result = await clt.query(sqlExistEmail, [email])
        if (result.rows.length > 0) {
            res = 409;
        } else {
            res = 200;
        }
        return res;
    } catch (error) {
        console.error(error);
    }
}

repository.updateUser = async (id_user, body) => {
    let res;
    let birth_to_datetime = new Date(body.birthdate);
    let sqlUpdate = "UPDATE _user SET firstname = $1::varchar, lastname = $2::varchar, username = $3::varchar, email = $4::varchar, birthdate = $5::date, phonenumber = $6::varchar, password = $7::varchar  WHERE id_user = $8::int";
    try {
        await clt.query(sqlUpdate, [body.firstname, body.lastname, body.username, body.email, birth_to_datetime, body.phonenumber, bcrypt.hashSync(body.password, bcrypt.genSaltSync(10)), id_user]);
        res = 200;
    } catch (error) {
        console.error(error)
        res = 501;
    }
    return res;
}

repository.deleteUser = async (id_user) => {
    let res;
    let sqlDelete = "DELETE FROM _user as u WHERE u.id_user = $1::int";
    try {
        await clt.query(sqlDelete, [req.params.id_user])
        res = 200;
    } catch (error) {
        console.log(error);
        res = 501;
    }
    return res;
}

repository.login = async (body) => {
    let resReturned;
    let sqlLogin;

    if (body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
    } else {
        sqlLogin = "SELECT * FROM _user as u WHERE u.username = $1::varchar ";
    }
    try {
        let result = await clt.query(sqlLogin, [body.connectId])
        console.log(bcrypt.compareSync(body.password, result.rows[0].password));
        if (result.rows.length > 0) {
            console.log("body.password => ", body.password)
            if (bcrypt.compareSync(body.password, result.rows[0].password)) {
                token = jwt.sign({
                    id: result.rows[0].id_user,
                    email: result.rows[0].email,
                    username: result.rows[0].username
                }, "SECRET")
                resReturned.status = 200
                resReturned.token = token;
            } else {
                resReturned.status = 401;
            }
        } else {
            resReturned.status = 404;
        }
    } catch (error) {

    }
    return resReturned;
}



export default repository;