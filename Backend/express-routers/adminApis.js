// All REST API data to be served at admin request in background

const Express = require('express');

const adminBack = Express.Router();

adminBack.get('/:resource', (req, res) => {
    res.send(
        JSON.stringify({ 'page': `Admin Background-${req.params.resource}` })
    );
})

adminBack.get('/*', (req, res) => {
    res.send(
        JSON.stringify({ 'page': 'Not found' })
    );
})

module.exports = adminBack;