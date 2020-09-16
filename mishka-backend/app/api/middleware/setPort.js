module.exports = function (port) {
    return function (req, res, next) {
        req.port = port;
        next();
    }
}