USE ecommerce_analytics;

SELECT 'customers' AS tbl, COUNT(*) AS n FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;

SELECT
    YEAR(o.order_date)      AS order_year,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY order_year;


SELECT
    o.region,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.region
ORDER BY total_sales DESC;


SELECT
    p.product_name,
    p.category,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_sales DESC
LIMIT 10;


SELECT
    p.category,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.sales) * 100 / (SELECT SUM(sales) FROM order_items), 1) AS pct_of_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;


SELECT
    c.segment,
    COUNT(DISTINCT c.customer_id)                        AS customers,
    COUNT(DISTINCT o.order_id)                           AS orders,
    ROUND(SUM(oi.sales), 2)                              AS total_sales,
    ROUND(SUM(oi.sales) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.segment
ORDER BY total_sales DESC;


WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        ROUND(SUM(oi.sales), 2) AS total_spent
    FROM customers c
    JOIN orders o       ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    RANK()     OVER (ORDER BY total_spent DESC) AS spend_rank,
    NTILE(4)   OVER (ORDER BY total_spent DESC) AS spend_quartile
FROM customer_sales
ORDER BY spend_rank
LIMIT 10;


WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
        SUM(oi.sales)                      AS total_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT
    order_month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND((total_sales - LAG(total_sales) OVER (ORDER BY order_month)) * 100
          / LAG(total_sales) OVER (ORDER BY order_month), 1) AS mom_growth_pct
FROM monthly
ORDER BY order_month;