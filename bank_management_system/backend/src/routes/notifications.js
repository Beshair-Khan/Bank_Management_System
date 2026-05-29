const express    = require('express');
const router     = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllNotifications,
  deleteNotification
} = require('../controllers/notifications.controller');

router.get('/',                              getAllNotifications);
router.delete('/:id',       validateId,      deleteNotification);

module.exports = router;