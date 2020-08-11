// All web pages to be served at admin request

const Express = require('express');

const admin = Express.Router();

admin.get('/webPage1', (req, res) => {
    res.send('Request for admin web page 1');
})

admin.get('/webPage2', (req, res) => {
    res.send('Request for admin web page 2');
})

admin.get('/*', (req, res) => {
    res.send('Request for admin not found');
})

module.exports = admin;