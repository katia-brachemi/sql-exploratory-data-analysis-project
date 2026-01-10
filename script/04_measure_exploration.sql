/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - This section calculates the main business metrics: sales, items sold, average price, orders, products, and customers. 
    - These metrics provide a baseline overview of performance and customer activity.

SQL Functions Used:
    - COUNT()
    - SUM()
    - AVG()
===============================================================================
*/

-- Calculate the total sales revenue
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Calculate the total number of items sold
SELECT
SUM(quantity) AS items_sold
FROM gold.fact_sales;


-- Calculate the average selling price across all transactions
SELECT
AVG(price) AS avg_selling
FROM gold.fact_sales;

-- Count the total number of distinct orders
SELECT 
COUNT( DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- Count the total number of distinct products available
SELECT 
COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products;

-- Count the total number of distinct customers in the dataset
SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers;

-- Count the number of customers who have placed at least one order
SELECT COUNT(DISTINCT customer_key) AS customer_orders
FROM gold.fact_sales;

-- Generate a report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measue_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measue_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT( DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.dim_customers

