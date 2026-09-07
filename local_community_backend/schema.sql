-- local_community database schema
-- PostgreSQL
-- Run: psql -U postgres -d local_community -f schema.sql
-- Or create DB first: createdb -U postgres local_community

-- Users table
CREATE TABLE IF NOT EXISTS users (
  userid     SERIAL PRIMARY KEY,
  uname      VARCHAR(100)  NOT NULL,
  email      VARCHAR(255)  NOT NULL UNIQUE,
  unumber    VARCHAR(20),
  country    VARCHAR(100),
  city       VARCHAR(100),
  address    TEXT,
  upassword  TEXT          NOT NULL,
  photo_path TEXT
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
  id    SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  img   TEXT DEFAULT 'default.png'
);

-- Posts table
CREATE TABLE IF NOT EXISTS posts (
  postid     SERIAL PRIMARY KEY,
  username   VARCHAR(100) NOT NULL,
  userphoto  TEXT,
  pdetails   TEXT         NOT NULL,
  ptags      TEXT,
  pimg       TEXT,
  created_at TIMESTAMPTZ  DEFAULT NOW()
);

-- Comments table
CREATE TABLE IF NOT EXISTS comments (
  id         SERIAL PRIMARY KEY,
  postid     INTEGER      NOT NULL REFERENCES posts(postid) ON DELETE CASCADE,
  userid     INTEGER      REFERENCES users(userid) ON DELETE SET NULL,
  userphoto  TEXT,
  username   VARCHAR(100),
  comment    TEXT         NOT NULL,
  created_at TIMESTAMPTZ  DEFAULT NOW()
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
  pid           SERIAL PRIMARY KEY,
  product_title VARCHAR(200) NOT NULL,
  title         VARCHAR(200),
  pdetails      TEXT,
  pimg          TEXT,
  brandname     VARCHAR(100),
  category_id   INTEGER      REFERENCES categories(id) ON DELETE SET NULL,
  categoryname  VARCHAR(100),
  price         NUMERIC(10, 2),
  imageurl      TEXT,
  created_at    TIMESTAMPTZ  DEFAULT NOW()
);
