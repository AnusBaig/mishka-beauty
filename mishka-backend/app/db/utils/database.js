const mysql = require('mysql');

module.exports = mysql.createConnection({
    connectionLimit: 100,
    host: '108.179.243.148',
    user: 'nhnxayvj_omama',
    password: '123456',
    database: 'nhnxayvj_mishka1',
    multipleStatements: true
});