const express  = require('express');
const router   = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllAccounts} = require('../controllers/accounts.controller');

router.get('/',      getAllAccounts);
module.exports = router;