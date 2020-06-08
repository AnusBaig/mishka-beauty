const {
    handleSuccessResponse,
    handleErrorResponse,
    handleLog
} = require('../../router/utils/handleLog');
const config = require('../../../config/default.json');

module.exports = function (req, res, next) {
    if (config['requireAuths']) {
        if (!req.user.isAdmin)
            return handleErrorResponse('Access denied', res, 403);
    }

    next();
};