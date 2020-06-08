const {
    handlePost
} = require('../../utils/handleRoutesCRUD');
const {
    validateUser
} = require('../../utils/validateClient');
const {
    generateAuthToken
} = require('../../utils/transformClientData');
const {
    handleSuccessResponse,
    handleErrorResponse,
    handleLog
} = require('../../utils/handleLog');
const {
    User
} = require('../../../models/user');
const bcrypt = require('bcrypt');
const config = require('config');
const express = require('express');
const router = express.Router();

router.post('/', async (req, res) => {
    try {
        const {
            error
        } = validateUser(req.body);
        if (error)
            return handleErrorResponse(error.details[0].message, res);

        let user = await User.findOne({
            email: req.body.email
        });
        if (!user)
            return handleErrorResponse(`Invalid email or password`, res);

        let isValid = bcrypt.compare(req.body.password, user.password);
        if (!isValid)
            return handleErrorResponse(`Invalid email or password`, res);

        const token = generateAuthToken(user);
        handleSuccessResponse(token, false, res);
    } catch (ex) {
        handleErrorResponse(`User not found, try again...`);
    }
});

module.exports = router;