const pool = require('../config/db');

// GET all notifications
const getAllNotifications = async (req, res, next) => {
  try {
    const result = await pool.query(
      `SELECT n.*, 
              c.first_name, c.last_name
       FROM notifications n
       JOIN customers c ON n.customer_id = c.customer_id
       ORDER BY n.sent_at DESC`
    );
    res.json({ success: true, count: result.rows.length, data: result.rows });
  } catch (err) {
    next(err);
  }
};
// DELETE notification
const deleteNotification = async (req, res, next) => {
  try {
    const result = await pool.query(
      'DELETE FROM notifications WHERE notif_id=$1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Notification not found' });
    }
    res.json({ success: true, message: 'Notification deleted successfully' });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAllNotifications,
  deleteNotification
};