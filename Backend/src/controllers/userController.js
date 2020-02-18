import bcrypt from 'bcrypt';
//const sqlite3 = require('sqlite3').verbose();
const { Pool, Client } = require('pg')


const controller = {};

const client = new Client({
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'root',
    database: 'StrongrDB'
});

client.connect(err => {
    if (err) {
        console.log(err);
        throw err
    } else {
        console.log('Connected to client')
    }
});

controller.getUser = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlGetUser = "SELECT * FROM _user as u WHERE u.id_user = $1::int";
    try {
        var result = await client.query(sqlGetUser, [req.params.id_user])
        if (result.rows[0]) {
            console.log(result.rows[0]);
            body = {
                message: 'User found',
                user_info: result.rows[0]
            };
        } else {
            body = { message: 'User not found' };
        }
    } catch (error) {
        console.error(error)
    }
    res.status(status).json(body);
}

controller.addUser = async (req, res) => {
    let body = {};
    let status = 200;
    let sqlExist = "SELECT * FROM _user u WHERE u.username = $1::varchar OR u.email = $2::varchar";
    try {
        var result = await client.query(sqlExist, [req.body.username, req.body.email])
        if (result.rows.length > 0) {
            status = 409
            body = { message: "A user with this email or username already exists" };

        } else {
            let sqlRegister = "INSERT INTO _user (firstname, lastname, username, email, password) VALUES($1::varchar, $2::varchar, $3::varchar, $4::varchar, $5::varchar )";
            var result = await client.query(sqlRegister, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, bcrypt.hashSync(req.body.password, 10)])
            status = 201;
            body = { message: "User added with success" };
        }
    } catch (error) {
        console.error(error)
    }
    res.status(status).json(body);
}
controller.updateUser = async (req, res) => {
    let body = {};
    let status = 200;
    let id_user = req.params.id_user;
    let sqlUpdate = "UPDATE _user SET firstname = $1::varchar, lastname = $2::varchar, username = $3::varchar, email = $4::varchar, password = $5::varchar WHERE id_user = $6::int";
    try {
        await client.query(sqlUpdate, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, bcrypt.hashSync(req.body.password, 10), id_user]);
        body = { message: "User updated with success" };
    } catch (error) {
        console.error(error)
    }
    res.status(status).json(body);
}

controller.deleteUser = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlDelete = "DELETE FROM _user as u WHERE u.id_user = $1::int";
    try {
        await client.query(sqlDelete, [req.params.id_user])
        body = { message: "User deleted with success" };
    } catch (error) {
        console.error(error)
    }
    res.status(status).json(body);
}
controller.login = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlLogin;
    if (req.body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM _user as u WHERE u.email = $1::varchar ";
    } else {
        sqlLogin = "SELECT * FROM _user as u WHERE u.username = $1::varchar ";
    }
    try {
        var result = await client.query(sqlLogin, [req.body.connectId])
        if (result.rows.length > 0) {
            if (bcrypt.compareSync(req.body.password, result.rows[0].password)) {
                body = { message: "Authentificate with success" };
            } else {
                body = { message: "Authentification failed" };
                status = 401;
            }
        } else {
            body = { message: "Your identificator (user or email) isn\'t in our DB so register please" };
        }
    } catch (error) {
        console.error(error)
    }
    res.status(status).json(body);
}

export default controller;