const pool = require('../config/db');

const getAllLoans = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT l.*, 
              c.first_name, c.last_name,
              lt.type_name, lt.interest_rate,
              e.first_name AS officer_first_name, e.last_name AS officer_last_name
       FROM loans l
       JOIN customers c   ON l.customer_id  = c.customer_id
       JOIN loan_types lt ON l.loan_type_id = lt.loan_type_id
       JOIN employees e   ON l.employee_id  = e.employee_id`
    );
    res.json({ success: true, count: result.rows.length, data: result.rows });
  } catch (err) {
    next(err);
  }
};


module.exports = {
  getAllLoans
};