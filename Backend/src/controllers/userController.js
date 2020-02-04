const sqlite3 = require('sqlite3').verbose();

const controller = {};


let db = new sqlite3.Database('../Database/strongrDB.db', sqlite3.OPEN_READWRITE, (err) => {
    if (err) {
        return console.error(err.message);
    }
    console.log('Connected to the Strongr SQlite database.');
}); 


controller.addUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {
        let sqlLogin = "INSERT INTO 'user' ('name', 'surname', 'email', 'password') VALUES( ?, ?, ?, ? );";
        const res = await db.run(sqlLogin, [req.body.name, req.body.surname, req.body.email,req.body.password]);
        body = res;

    } catch (err) {
        status = 500;
        console.log(err);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.updateUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.deleteUser = async (req, res) => {
    let body = {};
    let status = 200;

    try {

    } catch (err) {
        status = 500;
        console.log(err.message);
        body = { message: 'Une erreur est survenue...' };
    }
    res.status(status).json(body);
}
controller.login = async (req, res) => {
    let body = {};
    let status = 200;


    let sqlLogin;
    if (req.body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM user u WHERE u.email = ? AND u.password = ? GROUP BY u.id";
    } else {
        sqlLogin = "SELECT * FROM user u WHERE u.username = ? AND u.password = ? GROUP BY u.id";
    }
    
    try {
        const res = await db.query(sqlLogin, [req.body.connectId, req.body.password]);
        if (res  !=  undefined) {
            req.session.idUser = res.id;
            body = {messageSuccess: 'Authentificate with success'}; 
        }else{
            body = {messageFailure: 'Your email or/and password is/are wrong'};
            status = 401;
        }
        await db.close();
        console.log('Connection Strongr database closed');
    } catch (err) {
        body = { message: 'Une erreur est survenue...' };
        console.log(err.message);
        body = err.message;
        status = 501;
    }


    res.status(status).json(body);
}
export default controller;