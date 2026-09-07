const express = require('express');
const bcrypt = require('bcryptjs');
const pool = require('../db');
const upload = require('../middleware/upload');
const { authLimiter } = require('../middleware/rateLimiter');

const router = express.Router();

// Register route
router.post('/register', authLimiter, upload.single('photo_path'), async (req, res) => {
  try {
    const { uname, email, unumber, country, city, address, upassword } = req.body;
    const imageFilename = req.file ? req.file.filename : null;

    // Check if email already exists
    const emailCheckResult = await pool.query(
      'SELECT userid FROM users WHERE email = $1',
      [email]
    );

    if (emailCheckResult.rows.length > 0) {
      return res.status(409).json({ message: 'Email is already registered' });
    }

    // Hash password before storing
    const hashedPassword = await bcrypt.hash(upassword, 12);

    const insertQuery = `
      INSERT INTO users (uname, email, unumber, country, city, address, upassword, photo_path)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING userid, uname, email;
    `;
    const values = [uname, email, unumber, country, city, address, hashedPassword, imageFilename];
    const result = await pool.query(insertQuery, values);

    res.status(201).json({
      message: 'User registered successfully',
      user: {
        userid: result.rows[0].userid,
        uname: result.rows[0].uname,
        email: result.rows[0].email,
      },
    });
  } catch (error) {
    console.error('Error registering user:', error);
    res.status(500).json({ message: 'Failed to register user' });
  }
});

// Login route
router.post('/login', authLimiter, async (req, res) => {
  try {
    const { email, upassword } = req.body;

    if (!email || !upassword) {
      return res.status(400).json({ message: 'Email and password are required' });
    }

    // Fetch user by email only - never compare plaintext password in SQL
    const query = `
      SELECT userid, uname, email, address, photo_path, upassword
      FROM users
      WHERE email = $1
    `;
    const result = await pool.query(query, [email]);

    if (result.rows.length === 0) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const user = result.rows[0];
    const passwordMatch = await bcrypt.compare(upassword, user.upassword);

    if (!passwordMatch) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    // Return user data without password
    const { upassword: _, ...safeUser } = user;
    return res.status(200).json(safeUser);
  } catch (error) {
    console.error('Error during login:', error.message);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;
