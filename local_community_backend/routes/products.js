const express = require('express');
const pool = require('../db');
const upload = require('../middleware/upload');

const router = express.Router();

// Add Product Endpoint
router.post('/addProduct', upload.single('pimg'), async (req, res) => {
  const { product_title, title, pdetails, brandName, categoryId } = req.body;
  const pimg = req.file ? req.file.filename : null;

  console.log('Received product:', req.body);
  console.log('Uploaded Product Image:', req.file);

  if (
    !product_title?.trim() ||
    !title?.trim() ||
    !pdetails?.trim() ||
    !brandName?.trim() ||
    !categoryId ||
    !pimg
  ) {
    return res.status(400).json({
      error: 'All fields (product title, category title, details, brand name, category ID, and image) are required',
    });
  }

  const sql = `
    INSERT INTO products (product_title, title, pdetails, pimg, brandName, category_id)
    VALUES ($1, $2, $3, $4, $5, $6) RETURNING pid
  `;

  try {
    const result = await pool.query(sql, [
      product_title,
      title,
      pdetails,
      pimg,
      brandName,
      categoryId,
    ]);

    res.status(201).json({
      message: 'Product added successfully',
      productId: result.rows[0].pid,
    });
  } catch (err) {
    console.error('Error inserting product:', err);
    res.status(500).json({ error: 'Database error while adding product' });
  }
});

// Add Category Endpoint
router.post('/addCategory', upload.single('img'), async (req, res) => {
  const customTitle = req.body.title;
  let imageName = 'default.png';

  if (req.file) {
    imageName = req.file.filename;
  }

  console.log('Received category title:', customTitle);
  console.log('Category image:', imageName);

  if (!customTitle?.trim()) {
    console.error('Error: Missing category title');
    return res.status(400).json({ error: 'Category title is required' });
  }

  try {
    const query = `
      INSERT INTO categories (title, img)
      VALUES ($1, $2) RETURNING id
    `;
    const values = [customTitle, imageName];
    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      console.error('Error: No rows returned from database');
      throw new Error('Insertion failed. No rows returned.');
    }

    const newCategoryId = result.rows[0].id;
    console.log('Inserted category ID:', newCategoryId);

    res.status(201).json({ categoryId: newCategoryId });
  } catch (error) {
    console.error('Database error:', error.message);
    res.status(500).json({ error: 'Failed to add category.' });
  }
});

// Get all categories
router.get('/getCategories', async (req, res) => {
  try {
    console.log('Fetching categories...');
    const query = 'SELECT id, title, img FROM categories ORDER BY id ASC';
    const result = await pool.query(query);
    console.log('Fetched categories:', result.rows);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching categories:', error.message, error.stack);
    res.status(500).json({ error: 'Error fetching categories' });
  }
});

// Fetch products by category
router.get('/products/:category', async (req, res) => {
  const { category } = req.params;
  try {
    const query = `
      SELECT title, price, imageurl 
      FROM products 
      WHERE categoryname = $1;
    `;
    const result = await pool.query(query, [category]);
    console.log('Fetched products:', result.rows);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

module.exports = router;
