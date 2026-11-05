USE ecommerce_analytics;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id   VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment       VARCHAR(20)
);

CREATE TABLE products (
    product_id   VARCHAR(30) PRIMARY KEY,
    product_name VARCHAR(255),
    category     VARCHAR(30),
    sub_category VARCHAR(30)
);

CREATE TABLE orders (
    order_id    VARCHAR(20) PRIMARY KEY,
    order_date  DATE,
    ship_date   DATE,
    ship_mode   VARCHAR(20),
    customer_id VARCHAR(20),
    city        VARCHAR(50),
    state       VARCHAR(50),
    postal_code CHAR(5),
    region      VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id    INT AUTO_INCREMENT PRIMARY KEY,
    order_id   VARCHAR(20),
    product_id VARCHAR(30),
    sales      DECIMAL(12,4),
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);