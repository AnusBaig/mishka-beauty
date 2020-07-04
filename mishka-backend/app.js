const app = require("express")();
const {
    handleLog
} = require("./app/api/router/utils/handleLog");

require("./app/private/set-credentials");
require("./app/startup/logging")();
require("./app/startup/config")();
require("./app/startup/validation")();
require("./app/startup/routes")(app);
require("./app/startup/prod")(app);
require("./app/startup/db").connect();

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => handleLog(`Listening on port ${PORT}...`));