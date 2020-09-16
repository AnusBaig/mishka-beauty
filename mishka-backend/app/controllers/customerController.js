const customerModel = require('../models/customerModel');
const {
    getAppUrl
} = require('../utils/appConfigs');
const {
    getBodyParam,
    getQueryParam
} = require('../api/router/utils/getClientData');
const sendFakeEmail = require('../services/Fake Services/fakeEmailService');
const sendEmail = require('../services/emailSendingService');
const {
    handleLog
} = require('../api/router/utils/handleLog');
const axios = require('axios');

module.exports.getAllCustomers = async (req, res) => {
    customerModel.getAllCustomers(res);
};

module.exports.getCustomerDetail = async (req, res) => {
    customerModel.getCustomerDetail(req, res);
};

module.exports.addNewCustomer = async (req, res) => {
    const user = {
        username: getBodyParam('username', req, res),
        email: getBodyParam('email', req, res),
        password: getBodyParam('password', req, res),
        name: req.body['name'],
        address: req.body['address'],
        phone: req.body['phone']
    }
    const signupResponse = await customerModel.addNewCustomer(user);

    if (signupResponse.Success) {
        const key = `${signupResponse.Key}@${user.username}`;
        const url = `${getAppUrl(req)}${req.baseUrl}/validate?uk=${key}`;

        //Fake Email Service
        // if(process.env.NODE_ENV=='development')
        const emailResponse = await sendFakeEmail(user.email, 'Please Verify Your Account', url + '\n\n' + signupResponse.Message);

        //Real Email Service
        // if(process.env.NODE_ENV=='production')
        // const emailResponse = await sendEmail(user.email, 'Please Verify Your Account', url + '\n\n' + signupResponse.Message);
    }
    res.send(signupResponse);
};

module.exports.validateAccount = async (req, res) => {
    const userKey = getQueryParam('uk', req, res);
    const key = userKey.split('@');

    const result = await customerModel.validateAccount(key[0], key[1]);
    res.send(result);
};

module.exports.resendVerification = async (req, res) => {
    await customerModel.resendVerification();
}