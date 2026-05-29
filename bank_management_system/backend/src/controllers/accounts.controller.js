const pool = require('../config/db');

// GET all accounts
const getAllAccounts = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT a.*, c.first_name, c.last_name, c.email 
       FROM accounts a 
       JOIN customers c ON a.customer_id = c.customer_id`
    );
    res.json({ success: true, count: result.rows.length, data: result.rows });
  } catch (err) {
    next(err);
  }
};


module.exports = {
  getAllAccounts
};