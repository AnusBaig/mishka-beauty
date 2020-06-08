// const debug= require('debugg')('app:debug');
require('../src/services/loggingService');
const config = require('config');
const {
    handleSevereErrorResponse
} = require('../router/utils/handleLog');
require('express-async-errors');

module.exports = function () {
    process
        .on('uncaughtException', e => handleSevereErrorResponse(e.stack, e))
        .on('unhandledRejection', e => handleSevereErrorResponse(e.stack, e));

}