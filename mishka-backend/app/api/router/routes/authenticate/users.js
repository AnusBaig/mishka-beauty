const {
    Fawn
} = require("../../../startup/db");
const {
    save,
    docsCount
} = require("../../utils/handleDb");
const {
    getBodyParam
} = require("../../utils/getClientData");
const {
    validateUser
} = require("../../utils/validateClient");
const {
    makeHashed,
    generateAuthToken,
} = require("../../utils/transformClientData");
const jwt = require("jsonwebtoken");
const {
    handleSuccessResponse,
    handleErrorResponse,
    handleLog,
} = require("../../utils/handleLog");
const auth = require("../../../middleware/authenticate/auth");
const authAdmin = require("../../../middleware/authenticate/authAdmin");
const {
    User
} = require("../../../app/db/models/user");
const express = require("express");
const router = express.Router();

router.get("/", async (req, res));

router.get("/:id", async (req, res));

router.post("/", async (req, res) => {
    const {
        error
    } = validateUser(req.body);
    if (error) return handleErrorResponse(error.details[0].message, res);

    let user = await User.findOne({
        email: req.body.email,
    });

    if (user) {
        return handleErrorResponse(
            `User already regestered with email ${req.body.email}`,
            res
        );
    }

    user = {};
    user["id"] = await docsCount(User) + 1;

    await makeHashed(req);

    const params = ["email", "password", "name", "isAdmin"];
    for (let param of params) user[param] = getBodyParam(param, req, res);

    user = await save(User, user);
    if (!user)
        return handleErrorResponse("User couldnot be regestered", res, 500);

    let token = "";
    try {
        token = generateAuthToken(user);
    } catch (ex) {
        handleErrorResponse(
            "Token cannot be genrated.Intenel Server error occurred.",
            res,
            500
        );
    }

    res.header("x-auth-token", token)
        .header('access-control-expose-headers', 'x-auth-token')
        .send(user);
});

module.exports = router;