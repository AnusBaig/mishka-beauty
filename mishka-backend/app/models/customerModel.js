const db = require("../db/utils/database");
const {
    handleLog
} = require("../api/router/utils/handleLog");

module.exports.getAllCustomers = (res) => {
    db.query(`CALL getAllCustomers`, (err, result) => {
        if (err) {
            handleLog(err);
            throw err;
        } else {
            handleLog(result);
            res.send(result[0]);
        }
    });
};

module.exports.getCustomerDetail = (req, res) => {
    db.query(
        `CALL getCustomerDetails('${req.params.id}');
         CALL getCustomerOrders('${req.params.id}')`,
        (err, result) => {
            if (err) {
                console.log(err);
                throw err;
            } else {
                const customer = {
                    ...result[0][0],
                    orders: result[2],
                };
                console.log(customer);
                res.send(customer);
            }
        }
    )
};

module.exports.addNewCustomer = async ({
    username,
    name,
    email,
    password,
    address,
    phone
}) => {
    try {
        const [
            [result]
        ] = await db.promise().query(`CALL addCustomer('${username}','${name}','${email}','${password}','${address}','${phone}')`); //, (result, err) => {
        handleLog(result[0]);
        return result[0];
    } catch (e) {
        handleLog(e);
        return e;
    }
};

module.exports.validateAccount = async (key, user) => {
    try {
        const [
            [
                [result]
            ]
        ] = await db.promise().query(`CALL activateCustomer('${key}','${user}')`);
        handleLog(result);
        return result;
    } catch (e) {
        handleLog(e);
        return {
            Message: 'Error occurred while verifying your account or Your account is already verified',
            Success: 0
        };
    }
};

module.exports.resendVerification = () => {

};