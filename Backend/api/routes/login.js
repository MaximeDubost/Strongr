const express = require('express');
const sqlite3 = require('sqlite3').verbose();

const router = express.Router();
let db = new sqlite3.Database('../Database/mydb.db', sqlite3.OPEN_READWRITE, (err) => {
    if (err) {
        return console.error(err.message);
    }
    console.log('Connected to the Strongr SQlite database.');
});

router.post('/', async (req, res) => {
    console.log(req.body);
    var sqlLogin = "SELECT COUNT(*) as NbUser FROM user u WHERE u.email = ? AND u.password = ? GROUP BY u.id";
    db.get(sqlLogin,
        [req.body.email, req.body.password],
        (err, row) => {
            console.log(row);
            if (err) {
                console.log(err.message);
            } else if (row != undefined) {
                res.send({ messageSuccess: 'Authentificate with success' });
            } else {
                res.send({ messageFailure: 'Your email or/and password is/are wrong' });
            }
        }
    );
    db.close((err) => {
        if (err) {
            return console.error(err.message);
        }
        console.log('Connection Strongr database closed');
    });
});

module.exports = router; 