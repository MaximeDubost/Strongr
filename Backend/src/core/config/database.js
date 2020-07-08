const { Pool } = require("pg");
let pool;

if (process.env.NODE_ENV === "production") {
  pool = new Pool({
    connectionString: process.env.DATABASE_URL,
  });
} else {
  pool = new Pool({
    host: "localhost",
    port: 5432,
    user: "postgres",
    password: "root",
    database: "StrongrDB",
  });
}

module.exports = {
  query: (text, params) => pool.query(text, params),
};
