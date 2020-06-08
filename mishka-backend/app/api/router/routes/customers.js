const {
    Customer
} = require('../../models/customer');
const auth = require('../../middleware/authenticate/auth');
const authAdmin = require('../../middleware/authenticate/authAdmin');
const express = require('express');
const router = express.Router();

router.get('/', async (req, res));

router.get('/:id', async (req, res));

router.post('/', auth, async (req, res));

router.put('/:id', auth, async (req, res));

router.delete('/:id', [auth, authAdmin], async (req, res));

module.exports = router;