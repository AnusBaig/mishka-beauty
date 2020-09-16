const {
    handleErrorResponse,
    handleSuccessResponse
} = require("./handleLog");
const bcrypt = require("bcrypt");
const jwt = require('jsonwebtoken');

async function hashedPassword(req) {
    let salt = await bcrypt.genSalt(10);
    let hashed = await bcrypt.hash(req.body.password, salt);
    req.body.password = hashed;
}

async function makeHashed(data, saltWeight = 15) {
    let salt = await bcrypt.genSalt(saltWeight);
    let hashed = await bcrypt.hash(data, salt);
    return hashed;
}

function generateAuthToken({
    username,
    email,
    isAdmin
}) {
    return jwt.sign({
        username,
        email,
        isAdmin
    }, process.env.mishka_jwt_key);
};

module.exports = {
    makeHashed,
    hashedPassword,
    generateAuthToken
}