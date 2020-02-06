const sqlite3 = require('sqlite3').verbose();

const controller = {};


let db = new sqlite3.Database('../Database/strongrDB.db', sqlite3.OPEN_READWRITE, (err) => {
    if (err) {
        return console.error(err.message);
    }
    console.log('Connected to the Strongr SQlite database.');
});

controller.getUser = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlGetUser = "SELECT * FROM _User as u WHERE u.id_user = ?";
    db.get(sqlGetUser, [req.params.id_user], (err, rows) => {
        if (err) throw err;
        if (rows) {
            console.log(rows);
            body = {
                message: 'User found',
                user_info: rows
            };
        } else {
            body = { message: 'User not found' };
        }
        res.status(status).json(body);
    });
}

controller.addUser = async (req, res) => {
    let body = {};
    let status = 200;
    let sqlExist = "SELECT * FROM _User u WHERE u.username = ? OR u.email = ?";
    db.get(sqlExist, [req.body.username, req.body.email], (err, rows) => {
        if (err) throw err;
        if (rows) {
            body = { message: "A user with this email or username already exists" };
            res.status(status).json(body);
        } else {
            let sqlRegister = "INSERT INTO _User ('firstname', 'lastname', 'username', 'email', 'password') VALUES( ?, ?, ?, ?, ? )";
            db.get
            db.run(sqlRegister, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, req.body.password], (err, result) => {
                if (err) throw err;
                body = { message: "User added with success" };
                res.status(status).json(body);
            });
        }
    });
}
controller.updateUser = async (req, res) => {
    let body = {};
    let status = 200;
    let id_user = req.params.id_user;
    let sqlUpdate = "UPDATE _User SET firstname = ?, lastname = ?, username = ?, email = ?, password = ? WHERE id_user = ?";
    db.run(sqlUpdate, [req.body.firstname, req.body.lastname, req.body.username, req.body.email, req.body.password, id_user], (err, result) => {
        if (err) throw err;
        body = { message: "User updated with success" };
        res.status(status).json(body);
    });
}

controller.deleteUser = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlDelete = "DELETE FROM _User as u WHERE u.id_user = ?";
    db.run(sqlDelete, [req.params.id_user], (err, result) => {
        if (err) throw err;
        body = { message: "User deleted with success" };
        res.status(status).json(body);
    });

}
controller.login = async (req, res) => {
    let body = {};
    let status = 200;

    let sqlLogin;
    if (req.body.connectId.indexOf('@') != -1) {
        sqlLogin = "SELECT * FROM _User as u WHERE u.email = ? AND u.password = ?";
    } else {
        sqlLogin = "SELECT * FROM _User as u WHERE u.username = ? AND u.password = ?";
    }
    db.get(sqlLogin, [req.body.connectId, req.body.password], (err, rows) => {
        if (err) throw err;
        if (rows) {
            body = { message: 'Authentificate with success' };
        } else {
            body = { message: 'Your email or/and password is/are wrong' };
        }
        res.status(status).json(body);
    });
}

export default controller;