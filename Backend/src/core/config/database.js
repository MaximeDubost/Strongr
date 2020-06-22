const { Pool } = require('pg')
let pool;

if (process.env.NODE_ENV === "production") {
    pool = new Pool({
        connectionString: "postgres://mbcxbrjhtvgoht:86df2167086cf0f125e7aa689bbcfc58e6052bc07ff44654e3687a3d898c0597@ec2-176-34-123-50.eu-west-1.compute.amazonaws.com:5432/devm9bav7s31bf"
    });
} else {
    pool = new Pool(
        {
            host: 'localhost',
            port: 5432,
            user: 'postgres',
            password: 'root',
            database: 'StrongrDB',
        });
}


module.exports = {
    query: (text, params) => pool.query(text, params),
}