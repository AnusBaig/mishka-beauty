const mysql = require('mysql');

module.exports = mysql.createConnection({
    connectionLimit: 100,
    host: '108.179.243.148',
    user: 'nhnxayvj_aqib',
    password: 'aqibBhai12345',
    database: 'nhnxayvj_mishka-beauty',
    multipleStatements: true
});