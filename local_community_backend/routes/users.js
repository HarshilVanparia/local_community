const express = require('express');
const pool = require('../db');

const router = express.Router();

// Get user profile
router.get('/getUserProfile', async (req, res) => {
  const userId = req.query.userId;
  if (!userId) {
    return res.status(400).json({ message: 'User ID is required' });
  }

  try {
    // Fixed: column is userid not id
    const query = 'SELECT uname, email, address, photo_path FROM users WHERE userid = $1';
    const result = await pool.query(query, [userId]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error retrieving user profile' });
  }
});

module.exports = router;
