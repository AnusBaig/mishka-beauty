const error = require("../api/middleware/error");
const passport = require("../services/authenticionService");
const customer = require("../api/router/routes/customerRoute");
const auth = require("../api/router/routes/authenticate/authRoute");
const cors = require("cors");
const setPort = require("../api/middleware/setPort");
const express = require("express");

module.exports = function (app, port) {
    if (app.get("env") === "development") {
        const morgan = require("morgan");
        app.use(morgan("tiny"));
    }

    app.use(cors());
    app.use((req, res, next) => {
        req.port = port;
        next();
    });
    app.use(express.json());
    app.use(
        express.urlencoded({
            extended: true,
        })
    );
    app.use(passport.initialize());
    app.use(passport.session());
    app.use("/api/auth", auth);
    app.use("/api/customer", customer);
    app.use(error);
};