const auth = require("../../middleware/authenticate/auth");
const authAdmin = require("../../middleware/authenticate/authAdmin");
// const sql = require('../../../db/documents/sql-script/procedures/customer.sql');
const customerController = require('../../../controllers/customerController');
const express = require("express");
const router = express.Router();

router.get("/", customerController.getAllCustomers);

// router.get("/:id", customerController.getCustomerDetail);

// router.get('/:id', async (req, res){});

// router.post('/', auth, async (req, res){});

// router.put('/:id', auth, async (req, res){});

// router.delete('/:id', [auth, authAdmin], async (req, res){});

module.exports = router;