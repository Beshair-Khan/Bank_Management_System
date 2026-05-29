const express    = require('express');
const router     = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllLoans} = require('../controllers/loans.controller');

router.get('/',                         getAllLoans);
module.exports = router;