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
 * 
 */
controller.getAllExercises = async (req, res, next) => {
    let sqlGetAllExercises = "SELECT * FROM _exercise";
    try {
        var result = await clt.query(sqlGetAllExercises)
        console.log(result.rows);
        res.status(200).json({data:result.rows})
    } catch (error) {
        console.error(error)
    }
}

export default controller;