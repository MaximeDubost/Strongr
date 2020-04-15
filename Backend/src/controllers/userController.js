import bcrypt from 'bcrypt';
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer"

import UserRepository from "../repository/UserRepository"

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
/**
 * @param id_user int
 */
controller.getUser = async (req, res) => {
    let body = {};
    let user = await UserRepository.getUser(req.params.id_user);
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
        let userRegistered = await UserRepository.register(req.body);
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
        let emailChecked = await UserRepository.checkEmail(req.body.email);
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
        let userUpdated = await UserRepository.updateUser(req.params.id_user, req.body);
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
        let userDeleted = await UserRepository.deleteUser(req.params.id_user);
        res.sendStatus(userDeleted);
    } catch (error) {
        console.error(error);
    }
}
/**
 * @param email varchar,
 * @param password varchar
 */
controller.login = async (req, res) => {

    try {
        let result = await UserRepository.login(req.body);
        if (result.rows.length > 0) {
            if (bcrypt.compareSync(req.body.password, result.rows[0].password)) {
                var token = jwt.sign({
                    id: result.rows[0].id_user,
                    email: result.rows[0].email,
                    username: result.rows[0].username
                }, "SECRET")
                res.status(200).json({ token });
            } else {
                res.sendStatus(401);
            }
        } else {
            res.sendStatus(404);
        }
    } catch (error) {
        console.error(error);
    }
}

controller.logout = (req, res) => {
    res.sendStatus(200);
}
/**
 * @param email
 */
controller.sendCode = async (req, res) => {
    try {
        let repositoryProcess = await UserRepository.sendCode(req.body.email);
        if (repositoryProcess != 404) {
            const message = {
                from: 'team.strongr@gmail.com', // Sender address
                to: req.body.email,         // List of recipients
                subject: 'Code de réinitialisation de mot de passe', // Subject line
                text: "Bonjour, \n\n Votre code est le suivant : " + repositoryProcess + ".\n\n Si vous n’avez pas fait de demande pour un code, merci de contacter le service client pour vous assurer qu’il ne s’agit pas d’une tentative de fraude.\n\n\n - Strongr Team" // Plain text body
            };
            await transport.sendMail(message);
            res.sendStatus(200);
        } else {
            res.sendStatus(repositoryProcess);
        }
    } catch (error) {
        console.error(error)
    }
}
/**
 * @param recoverycode varchar
 */
controller.checkCode = async (req, res) => {
    try {
        let result = await UserRepository.checkCode(req.body);
        console.log(result);
        if (result.rows.length != 0) {
            let deleteCodeRepo = await UserRepository.deleteCode(req.body);
            res.sendStatus(deleteCodeRepo);
        } else {
            res.sendStatus(401);
        }
    } catch (error) {
        console.error(error);
    }
}
/**
 * @param email varchar,
 * @param password  varchar
 */
controller.resetPassword = async (req, res) => {
    try {
        await UserRepository.resetPassword(req.body)
        res.sendStatus(200)
    } catch (error) {
        console.error(error)
    }
}



export default controller;