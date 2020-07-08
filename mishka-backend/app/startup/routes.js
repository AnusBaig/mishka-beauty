const error = require('../api/middleware/error');
const customers = require('../api/router/routes/customers');
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
    app.use('/api/customers', customers);
    // app.use('/api/auth', auth);
    app.use(error);
};