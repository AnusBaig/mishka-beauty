const winston = require("winston");
require("winston-mongodb");

winston
  .add(new winston.transports.Console())
  .add(
    new winston.transports.File({
      filename: "errors.log",
      level: "info",
    })
  );

module.exports = winston;