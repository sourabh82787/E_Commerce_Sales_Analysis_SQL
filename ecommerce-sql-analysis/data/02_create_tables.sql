USE ecommerce_project;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(100),
    city            VARCHAR(50),
    gender          VARCHAR(10),
    signup_date     DATE
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(100),
    category        VARCHAR(50),
    unit_price      NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    order_date      DATE,
    order_status    VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id   INT PRIMARY KEY,
    order_id        INT REFERENCES orders(order_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT,
    unit_price      NUMERIC(10,2)
);
