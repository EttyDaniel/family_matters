DROP TABLE IF EXISTS accounts CASCADE;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  account_date TIMESTAMP NOT NULL DEFAULT Now()
);

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT Now(),
  is_primary boolean NOT NULL,
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS lists CASCADE;

CREATE TABLE lists (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  is_private boolean NOT NULL DEFAULT FALSE
);

DROP TABLE IF EXISTS list_items CASCADE;

CREATE TABLE list_items (
  id SERIAL PRIMARY KEY NOT NULL,
  item_name VARCHAR(255) NOT NULL,
  list_id INTEGER NOT NULL REFERENCES lists(id) on DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(id) on DELETE CASCADE,
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS user_lists CASCADE;

CREATE TABLE user_lists(
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id) on DELETE CASCADE,
  list_id INTEGER NOT NULL REFERENCES lists(id) on DELETE CASCADE,
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS events CASCADE;

CREATE TABLE events (
  id SERIAL PRIMARY KEY NOT NULL,
  event_name VARCHAR(255) NOT NULL,
  event_description VARCHAR(255),
  event_date TIMESTAMP NOT NULL DEFAULT Now(),
  all_day boolean DEFAULT TRUE,
  start_time TIME,
  end_time TIME,
  is_private boolean NOT NULL DEFAULT FALSE,
  event_address VARCHAR(255),
  reminder boolean NOT NULL DEFAULT FALSE  
);

DROP TABLE IF EXISTS user_events CASCADE;

CREATE TABLE user_events(
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) on DELETE CASCADE,
  event_id INTEGER NOT NULL REFERENCES events(id) on DELETE CASCADE,
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS contacts CASCADE;

CREATE TABLE contacts (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255),
  email VARCHAR(255),
  address VARCHAR(255),
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS meals CASCADE;

CREATE TABLE meals (
  id SERIAL PRIMARY KEY NOT NULL,
  day VARCHAR(255) NOT NULL,
  breakfast VARCHAR(255),
  lunch VARCHAR(255),
  snack VARCHAR(255),
  dinner VARCHAR(255),
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE
);

DROP TABLE IF EXISTS recipes CASCADE;

CREATE TABLE recipes (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  thumbnail_photo_url VARCHAR(255) NOT NULL, 
  preparation_time INTEGER,
  cooking_time INTEGER,
  serving INTEGER,
  ingredients TEXT NOT NULL,
  instructions TEXT NOT NULL,
  posted_by VARCHAR(255) NOT NULL,
  account_id INTEGER NOT NULL REFERENCES accounts(id) on DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(id) on DELETE CASCADE
);
