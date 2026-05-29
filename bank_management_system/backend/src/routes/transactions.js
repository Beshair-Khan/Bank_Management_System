const express    = require('express');
const router     = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllTransactions,
} = require('../controllers/transactions.controller');

router.get('/',                        getAllTransactions);
module.exports = router;