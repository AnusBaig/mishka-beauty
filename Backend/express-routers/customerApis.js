// All REST API data to be served at customer request in background

const Express = require('express');

const customerBack = Express.Router();

customerBack.get('/:resource', (req, res) => {
    res.send(
        JSON.stringify({ 'page': `Customer Background-${req.params.resource}` })
    );
})

customerBack.get('/*', (req, res) => {
    res.send(
        JSON.stringify({ 'page': 'Not found' })
    );
})

module.exports = customerBack;