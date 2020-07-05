const jwt = require('jsonwebtoken');
const {
    handleSuccessResponse,
    handleErrorResponse,
    handleLog
} = require('../../router/utils/handleLog');
const config = require('../../../../config/default.json');

function auth(req, res, next) {
    try {
        if (config['requireAuths']) {
            const token = req.header('x-auth-token');
            if (!token)
                return handleErrorResponse('Access denied. No token provided', res, 401);

            const decoded = jwt.verify(token, process.env.mishka_jwtPrivateKey);
            req.user = decoded;
        }
        next();
    } catch (ex) {
        handleErrorResponse('Invalid token', res, 400);
    }
}

module.exports = auth;