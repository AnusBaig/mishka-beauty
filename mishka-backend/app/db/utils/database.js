const mysql = require('mysql2');
const config = require('config');

module.exports = mysql.createConnection({
    connectionLimit: 100,
    host: process.env.mishka_db_host,
    user: process.env.mishka_db_username,
    password: process.env.mishka_db_password,
    database: process.env.mishka_db_database,
    multipleStatements: true
});