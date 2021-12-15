CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(60) UNIQUE, password VARCHAR(60), email VARCHAR(70) UNIQUE, phone_number INTEGER);
CREATE TABLE spaces (id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), price INTEGER, name VARCHAR(60), description VARCHAR(240));
CREATE TABLE bookings (id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), space_id INTEGER REFERENCES spaces(id), date VARCHAR(60), approved BOOLEAN);

This is for both makers_bnb and makers_bnb_test databases.