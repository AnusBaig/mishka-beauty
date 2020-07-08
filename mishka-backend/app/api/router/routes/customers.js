const auth = require("../../middleware/authenticate/auth");
const authAdmin = require("../../middleware/authenticate/authAdmin");
const db = require("../../../db/utils/database");
// const sql = require('../../../db/documents/sql-script/procedures/customer.sql');
const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
    db.query(`CALL GetAllCustomers`, (err, result) => {
        if (err) {
            console.log(err);
            throw err;
        } else {
            console.log(result);
            res.send(result[0]);
        }
    });
});

router.get("/:id", async (req, res) => {
    db.query(
        `CALL getCustomerDetails('${req.params.id}');
         CALL GetCustomerOrders('${req.params.id}')`,
        (err, result) => {
            if (err) {
                console.log(err);
                throw err;
            } else {
                const customer = {
                    ...result[0][0],
                    orders: result[2]
                };
                console.log(customer);
                res.send(customer);
            }
        }
    );
});

// router.get('/:id', async (req, res){});

// router.post('/', auth, async (req, res){});

// router.put('/:id', auth, async (req, res){});

// router.delete('/:id', [auth, authAdmin], async (req, res){});

module.exports = router;