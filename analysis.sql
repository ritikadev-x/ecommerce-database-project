-- =========================================
-- E-commerce Database Design Project
-- File: analysis.sql
-- Description: Contains SQL queries to analyze the data and generate business insights from the E-commerce database.
-- Author: Ritika
-- =========================================
SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;

 -- ANALYSIS QUERIES
-- Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payments;

-- Orders by Status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

-- Average Payment Amount
SELECT AVG(amount) AS average_payment
FROM payments;

-- Revenue by Product
SELECT p.product_name,
       SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Top Customers by Spend
SELECT c.name,
       SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Best Selling Products
SELECT p.product_name,
       SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Cancelled Orders Count
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

-- Products with Low Stock
SELECT product_name, stock
FROM products
WHERE stock < 50;