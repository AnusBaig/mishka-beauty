if (process.env.NODE_ENV === 'development') {
    //app-credentials
    process.env.login_username = 'mishka@dev';
    process.env.login_password = 'mishka@dev';

    //db-credentials
    process.env.db_connection_string = 'mongodb://localhost/mishka';

    //Json Web Token
    process.env.mishka_jwtPrivateKey = 'jwt-Private-Key';

    //Set App PORT
    process.env.PORT = 3000;
} else if (process.env.NODE_ENV === 'production') {
    //app-credentials
    process.env.login_username = 'mishka@prod';
    process.env.login_password = 'mishka@prod';

    //db-credentials
    process.env.db_connection_string = '';

    //Json Web Token
    process.env.mishka_jwtPrivateKey = 'jwt-Private-Key';
}