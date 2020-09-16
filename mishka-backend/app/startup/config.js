const {
    handleSevereErrorResponse
} = require('../api/router/utils/handleLog');
const config = require('config'); //../../config/development.json');

module.exports = function () {
    if (config['requireAuths'] && !process.env.mishka_jwtPrivateKey)
        handleSevereErrorResponse('FATAL Error: jwtPrivateKey is not defined');

    // if (!process.env.db_connection_string)
    //     handleSevereErrorResponse('DB_CONN Error: db-conString is not defined');

    // process.env.NODE_ENV='production';
    // console.log(process.env.NODE_ENV);
    // console.log('JWT Key: '+process.env.mishka_jwtPrivateKey+' from config: '+config.get('credentials.jwtPrivateKey'));
    // console.log('DB Connection String: '+process.env.db_connection_string+' from config: '+config.get('credentials.dbConString'));
};