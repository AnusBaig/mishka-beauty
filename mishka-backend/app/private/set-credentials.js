if (process.env.NODE_ENV === 'development') {

    //DB Configs
    process.env.mishka_db_host = '108.179.243.148';
    process.env.mishka_db_username = 'nhnxayvj_aqib';
    process.env.mishka_db_password = 'aqibBhai12345';
    process.env.mishka_db_database = 'nhnxayvj_mishka-beauty';

    //Mail Configs
    //----------FakeMailService----------
    process.env.fakemail_host='smtp.mailtrap.io';
    process.env.fakemail_port=2525;
    process.env.fakemail_user='73618658e6397c';
    process.env.fakemail_password='705dea9ff90c27'
    process.env.fakemail_from='Anus Baig <anusbaig58@gmail.com>';
    //----------FreeMailService----------
    process.env.mishka_fmail_host='smtp.gmail.com';
    process.env.mishka_fmail_port=465;
    process.env.mishka_fmail_user='ashfaqsultan85@gmail.com';
    process.env.mishka_fmail_password='automatically58'
    //----------PaidMailService----------
    process.env.mishka_mail_from='mbenfarhatahmede@canytimes.com';
    process.env.mishka_mail_api_key='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';


    //Json Web Token
    process.env.mishka_jwt_key = 'EFFF6A2C95446DE45212D06D0410F5D056A79638D28BB4D2F60CA0BA99764E166F93A60825AA585EA763CC8AC2F2C4C1FE168036AD150963ACD91E4670C1F587';

    //App Configs
    process.env.PORT = 3000;

    //Admin Credentials
    process.env.mishka_login_username = 'mishka@dev.user';
    process.env.mishka_login_password = 'mishka@dev.password';
} else if (process.env.NODE_ENV === 'production') {
    //app-credentials
    process.env.login_username = 'mishka@prod';
    process.env.login_password = 'mishka@prod';

    //db-credentials
    process.env.db_connection_string = '';

    //Json Web Token
    process.env.mishka_jwtPrivateKey = 'jwt-Private-Key';
}