const app = require("express")();
const {
    handleLog
} = require("./app/api/router/utils/handleLog");
const config = require("config");

const PORT = process.env.PORT || config.get("PORT") || 3000;
process.env.NODE_ENV = 'development';

require("./app/startup/logging")();
require("./app/startup/config")();
require("./app/private/set-credentials.js");
require("./app/startup/validation")();
require("./app/startup/db").connect();
require("./app/startup/routes")(app, PORT);
require("./app/startup/prod")(app);
handleLog(`App: ${config.get('appName')}`);
handleLog(`Execution mode: ${app.get('env')}`);

const server = app.listen(PORT, () =>
    handleLog(
        `Listening at ${server.address().address} on port ${
      server.address().port
    }...`
    )
);