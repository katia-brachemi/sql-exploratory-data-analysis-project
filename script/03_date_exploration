/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
  - This section reviews the dataset’s coverage period and customer demographics.
  - It highlights the first and last orders, total years of sales, and the youngest and oldest customers.

SQL Functions Used:
    - MIN()
    - MAX()
    - DATEDIFF()
===============================================================================
*/


-- Find the earliest and latest order dates in the sales table
SELECT MIN(order_date) AS first_order_date,
	   Max(order_date) AS last_order_date
FROM gold.fact_sales;

-- Calculate how many years of sales data are available
SELECT 
DATEDIFF(year,MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales;

-- Identify the youngest and oldest customers based on birth date
SELECT
MAX(birth_date) AS youngest_birth,
MIN(birth_date) AS oldest_birth
FROM gold.dim_customers;

-- Calculate the youngest and oldest customers by age (in years)
SELECT
DATEDIFF(year, MIN(birth_date), GETDATE()) AS oldest_customer,
DATEDIFF(year, MAX(birth_date), GETDATE()) AS youngest_customer
FROM gold.dim_customers;
