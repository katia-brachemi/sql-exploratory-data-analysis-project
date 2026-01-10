/*
===============================================================================
Performance Analysis
===============================================================================
Purpose:
    - Identify top and bottom-performing products, subcategories, and customers.
    - Show where revenue is concentrated and how customers contribute to overall performance.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT()
    - Ranking Functions: RANK()
    - GROUP BY, ORDER BY, TOP
===============================================================================
*/

-- Retrieve the 5 products generating the highest revenue 
SELECT TOP 5
p.product_name,
SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Retrieve the 5 subcategories generating the highest revenue
-- Using Window Function: 
SELECT*
FROM (
SELECT 
p.subcategory,
SUM(s.sales_amount) AS total_revenue,
RANK () OVER( ORDER BY SUM(s.sales_amount) DESC) AS rank_subcat
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON s.product_key = p.product_key
GROUP BY p.subcategory) t
WHERE rank_subcat <= 5;

-- Retrieve the 5 lowest-performing products by revenue
SELECT TOP 5
p.product_name,
SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Retrieve the top 10 customers ranked by total revenue generated
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
ON s.customer_key = c.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC;

-- Retrieve the 3 customers with the fewest orders placed
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT s.order_number) AS total_orders
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
ON s.customer_key = c.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders ASC;
