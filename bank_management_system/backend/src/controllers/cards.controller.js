const pool = require('../config/db');

// GET all cards
const getAllCards = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT c.*, 
              cu.first_name, cu.last_name,
              a.account_number
       FROM cards c
       JOIN customers cu ON c.customer_id = cu.customer_id
       JOIN accounts a   ON c.account_id  = a.account_id
       ORDER BY c.card_id`
    );
    res.json({ success: true, count: result.rows.length, data: result.rows });
  } catch (err) {
    next(err);
  }
};
// PATCH block or unblock a card
const updateCardStatus = async (req, res, next) => {
  try {
    const { status } = req.body;
    const result = await pool.query(
      `UPDATE cards SET status=$1 
       WHERE card_id=$2 RETURNING *`,
      [status, req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Card not found' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (err) {
    next(err);
  }
};
module.exports = {
  getAllCards,
  updateCardStatus
};