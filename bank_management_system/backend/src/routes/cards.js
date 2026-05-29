const express    = require('express');
const router     = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllCards,
  updateCardStatus
} = require('../controllers/cards.controller');

router.get('/',                          getAllCards);
router.patch('/:id/status', validateId,  updateCardStatus);

module.exports = router;