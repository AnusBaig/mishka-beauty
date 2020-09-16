const {
  validateUser
} = require("../../utils/validateClient");
const authController = require("../../../../controllers/authController");
const bcrypt = require("bcrypt");
const config = require("config");
const express = require("express");
const router = express.Router();
const passport = require("passport");

router.post("/login", authController.login);

router.get(
  "/google",
  passport.authenticate("google", {
    scope: ["profile", 'email'],
  })
);

router.get("/google/redirect", passport.authenticate("google"), (req, res) => authController.authenticateWithSocialAccount(req, res));

router.get("/facebook",
  passport.authenticate("facebook", {
    scope: ["email"] // 'user_birthday', 'user_gender'],
  }));

router.get("/facebook/redirect", passport.authenticate("facebook"), (req, res) => authController.authenticateWithSocialAccount(req, res));

module.exports = router;