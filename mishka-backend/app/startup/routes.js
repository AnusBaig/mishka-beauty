const error = require('../api/middleware/error');
const test = require('../api/router/routes/test');
// const users = require('../api/router/routes/authenticate/users');
// const auth = require('../api/router/routes/authenticate/auth');
const cors = require('cors');
const express = require('express');

module.exports = function (app) {
    if (app.get('env') === 'development') {
        const morgan = require('morgan');
        app.use(morgan('tiny'));
    }

    app.use(cors());
    app.use(express.json());
    app.use(express.urlencoded({
        extended: true
    }));
    // app.use('/api/customers', customers);
    // app.use('/api/users', users);
    app.use('/api/test', test);
    // app.use('/api/auth', auth);
    app.use(error);
};