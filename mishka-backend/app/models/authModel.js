const db = require("../db/utils/database");
const {
    handleLog
} = require("../api/router/utils/handleLog");

module.exports.checkUserExists = async (username, email) => {
    let isUserExists = await db.promise().query(`Select isCustomerSignedUp('${username}','${email}')  as 'user'`);
    return isUserExists[0][0]['user'];
}

module.exports.login = async ({username,email,password}) => {
    let sql = '';
    if(!username) sql = `CALL authenticateCustomer('${email}','${password}',NULL);`;
    else if(!email) sql = `CALL authenticateCustomer(NULL,'${password}','${username}');`;

    try{
        const results = await db.promise().query(sql);
        return results[0][0][0];
    }
    catch(e){
        console.error(e);
        return {Message:`Cannot login at this moment`};
    }

}