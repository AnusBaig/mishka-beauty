const auth = require("../../middleware/authenticate/auth");
const authAdmin = require("../../middleware/authenticate/authAdmin");
// const sql = require('../../../db/documents/sql-script/procedures/customer.sql');
const customerController = require("../../../controllers/customerController");
const express = require("express");
const router = express.Router();

router.get("/",[auth,authAdmin], customerController.getAllCustomers);

router.get("/:id",[auth,authAdmin], customerController.getCustomerDetail);

router.post("/signup", customerController.addNewCustomer);

router.get("/resendVerification", customerController.resendVerification);

router.get("/validate", customerController.validateAccount);

module.exports = router;