const express    = require('express');
const router     = express.Router();
const validateId = require('../middleware/validateID');
const {
  getAllEmployees,
  createEmployee,
  updateEmployee,
  deleteEmployee
} = require('../controllers/employees.controller');

router.get('/',                           getAllEmployees);
router.post('/',                          createEmployee);
router.put('/:id',         validateId,    updateEmployee);
router.delete('/:id',      validateId,    deleteEmployee);

module.exports = router;