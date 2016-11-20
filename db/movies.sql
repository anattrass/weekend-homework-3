DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers (
  id SERIAL8 primary key,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE films (
  id SERIAL8 primary key,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE tickets (
  id SERIAL8 primary key,
  film_id INT8 references films(id) ON DELETE CASCADE,
  customer_id INT8 references customers(id) ON DELETE CASCADE,
  customer_funds INT2 references customers(funds) ON DELETE CASCADE,
  film_price INT2 references films(price) ON DELETE CASCADE
);