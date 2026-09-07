const express = require('express');
const pool = require('../db');
const upload = require('../middleware/upload');

const router = express.Router();

// Upload post route
router.post('/uploadPost', upload.single('pimg'), async (req, res) => {
  try {
    const { email, pdetails, ptags } = req.body;
    const imagePath = req.file ? req.file.filename : null;

    if (!email || !pdetails || !ptags || !imagePath) {
      return res.status(400).send('Missing required fields');
    }

    // Fetch username and userphoto based on email
    const userQuery = `
      SELECT uname, photo_path 
      FROM users 
      WHERE email = $1;
    `;
    const userResult = await pool.query(userQuery, [email]);

    if (userResult.rows.length === 0) {
      return res.status(404).send('User not found');
    }

    const { uname: username, photo_path: userphoto } = userResult.rows[0];

    // Insert post into the database
    const postQuery = `
      INSERT INTO posts (username, userphoto, pdetails, ptags, pimg)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const postValues = [username, userphoto, pdetails, ptags, imagePath];
    const postResult = await pool.query(postQuery, postValues);

    res.status(201).send(`Post created successfully: ID ${postResult.rows[0].postid}`);
  } catch (error) {
    console.error('Error uploading post:', error);
    res.status(500).send('Error uploading post');
  }
});

// Get all posts route
router.get('/getPosts', async (req, res) => {
  try {
    const query = 'SELECT * FROM posts ORDER BY postid DESC';
    const result = await pool.query(query);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching posts:', error.message, error.stack);
    res.status(500).json({ error: 'Error fetching posts' });
  }
});

// Add comment
router.post('/add-comment', async (req, res) => {
  try {
    const { postid, userid, userphoto, username, comment } = req.body;
    const query = `
      INSERT INTO comments (postid, userid, userphoto, username, comment)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const result = await pool.query(query, [postid, userid, userphoto, username, comment]);
    res.status(201).json({ comment: result.rows[0] });
  } catch (error) {
    console.error('Error adding comment:', error);
    res.status(500).json({ error: 'Failed to add comment' });
  }
});

// Fetch comments for a specific post
router.get('/comments/:postid', async (req, res) => {
  try {
    const { postid } = req.params;
    const query = `
      SELECT * FROM comments 
      WHERE postid = $1 
      ORDER BY created_at DESC;
    `;
    const result = await pool.query(query, [postid]);
    res.status(200).json({ comments: result.rows });
  } catch (error) {
    console.error('Error fetching comments:', error);
    res.status(500).json({ error: 'Failed to fetch comments' });
  }
});

module.exports = router;
