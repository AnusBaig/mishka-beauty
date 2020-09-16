const passport = require("passport");
const GoogleStrategy = require("passport-google-oauth20").Strategy;
const FacebookStrategy = require("passport-facebook").Strategy;

passport.serializeUser(function (user, done) {
    done(null, user);
});

passport.deserializeUser(function (obj, done) {
    done(null, obj);
});

passport.use(
    new GoogleStrategy({
            clientID: "624512562855-qu7rs9te4v4198oorqgn21ec3060vsv5.apps.googleusercontent.com",
            clientSecret: "Yw5PJOwEySu3GjF56YC4llZH",
            callbackURL: "/api/auth/google/redirect",
        },
        (accessToken, refreshToken, profile, done) => {
            console.log("Google Profile Accessed");
            console.log(profile);
            done(null, getRelevantDataFromSocialProfile(profile));
        }
    )
);

passport.use(
    new FacebookStrategy({
            clientID: "2731322633779414",
            clientSecret: "c716e64b8d759c6042eaf6ee31a9aec2",
            callbackURL: "/api/auth/facebook/redirect",
            profileFields: ['id', 'emails', 'name']
        },
        (accessToken, refreshToken, profile, done) => {
            console.log("FB Profile Accessed");
            console.log(profile);
            done(null, getRelevantDataFromSocialProfile(profile));
        }
    )
);

let getRelevantDataFromSocialProfile = ({
    _json,
    provider
}) => ({
    provider,
    ..._json
});

module.exports = passport;