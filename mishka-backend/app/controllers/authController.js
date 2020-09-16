const {
    getAppUrl
} = require('../utils/appConfigs');
const axios = require('axios');
const {
    getBodyParam,
    getQueryParam
} = require('../api/router/utils/getClientData');
const {
    sendAuthorizedToken
} = require("../api/router/utils/sendClientData");
const {
    handleSuccessResponse,
    handleErrorResponse,
    handleLog,
} = require("../api/router/utils/handleLog");
const authModel = require('../models/authModel');

module.exports.login = async (req, res) => {
    const credentials = {
        username: req.body['username'],
        email: req.body['email'],
        password: getBodyParam('password', req, res)
    }

    const loggedIn = await authModel.login(credentials);

    if(loggedIn['Success']){
        if(!credentials.username) credentials.username = loggedIn["user"];
        else if(!credentials.email) credentials.email = loggedIn["user"];

        sendAuthorizedToken(res, credentials);
    }
    else{
        const login = {
            loginMessage: loggedIn['Message'],
            loggedIn: 0
        };
        res.send(login);
    }
}

module.exports.authenticateWithSocialAccount = async (req, res) => {
    const user = {
        username: req.user.email.split('@')[0],
        email: req.user.email,
        password: req.user.provider
    };

    const isUserExists = await authModel.checkUserExists(user.username, user.email);
    if (isUserExists) {
        sendAuthorizedToken(res, user);
        return;
    }

    const {
        data
    } = await axios.post(`${getAppUrl(req)}/api/customer/signup`, user);

    if (data['Success']) {
        sendAuthorizedToken(res, user);
    } else {
        const login = {
            loginMessage: `${user.username} cannot be logged in at this moment`,
            loggedIn: 0
        };
        res.send(login);
    }
}