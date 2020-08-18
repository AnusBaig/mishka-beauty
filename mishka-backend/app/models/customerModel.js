const db = require("../db/utils/database");

module.exports.getAllCustomers = res => {
    db.query(`SELECT * FROM category_table`, (err, result) => {
        if (err) {
            console.log(err);
            throw err;
        } else {
            console.log(result);
            res.send(result[0]);
        }
    })
};

// module.exports.getCustomerDetail = (req, res) => {
//     db.query(
//         `CALL getCustomerDetails('${req.params.id}');
//          CALL GetCustomerOrders('${req.params.id}')`,
//         (err, result) => {
//             if (err) {
//                 console.log(err);
//                 throw err;
//             } else {
//                 const customer = {
//                     ...result[0][0],
//                     orders: result[2],
//                 };
//                 console.log(customer);
//                 res.send(customer);
//             }
//         }
//     )
// };