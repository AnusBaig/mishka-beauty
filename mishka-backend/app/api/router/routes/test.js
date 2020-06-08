const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
    console.log('go0');
    throw new Error('Go to error');
});

module.exports = router;