// All web pages to be served at customer request

const Express = require('express');

const customer = Express.Router();

customer.get('/webPage1', (req, res) => {
    res.send('Request for customer web page 1');
})

customer.get('/webPage2', (req, res) => {
    res.send('Request for customer web page 2');
})

customer.get('/*', (req, res) => {
    res.send('Request for customer not found');
})

module.exports = customer;