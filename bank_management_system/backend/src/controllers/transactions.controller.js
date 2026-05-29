const pool = require('../config/db');

// GET all transactions
const getAllTransactions = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT t.*, tt.type_name, a.account_number
       FROM transactions t
       JOIN transaction_types tt ON t.type_id = tt.type_id
       JOIN accounts a ON t.account_id = a.account_id
       ORDER BY t.txn_date ASC`
    );
    res.json({ success: true, count: result.rows.length, data: result.rows });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAllTransactions,
};