/*
===========================================================================================
Customer Behavior Analysis
===========================================================================================
Purpose:
    - Summarize customer activity using Recency, Frequency, and Monetary (RFM).
    - Build RFM metrics (Recency, Frequency, Monetary) for each customer.
    - Analyze customer spending behavior by gender or age group. 
    - Age is calculated precisely from birth_date, adjusting for birthdays not yet reached.
    - Unrealistic ages are excluded to ensure data quality.

  Terms Used:
   - Recency: Most recent purchase date 
   - Frequency: Total number of purchases
   - Monetary: Total spend

SQL Functions Used:
   - Aggregate Functions: SUM(), COUNT(), AVG()
   - Window Functions
   - GROUP BY, ORDER BY
   - Date Functions: DATEDIFF(), DATEADD()
   - Conditional Logic: CASE
==============================================================================================
*/

WITH rfm_base AS (
    SELECT
        c.first_name,
        c.last_name,
        s.customer_key,
        MAX(s.order_date) AS last_order_date,
        COUNT(s.order_number) AS frequency,
        SUM(s.sales_amount) AS monetary
    FROM gold.fact_sales AS s
    JOIN gold.dim_customers AS c
        ON s.customer_key = c.customer_key
    GROUP BY s.customer_key, c.first_name, c.last_name
),
rfm_scored AS (
    SELECT
        customer_key,
        first_name,
        last_name,
        DATEDIFF(year, last_order_date, GETDATE()) AS recency_years,
        frequency,
        monetary
    FROM rfm_base
)
SELECT *
FROM rfm_scored
ORDER BY monetary DESC;


-- Average spend by gender
SELECT gender, 
AVG(sales_amount) AS avg_spend
FROM gold.fact_sales s
JOIN gold.dim_customers c 
ON s.customer_key = c.customer_key
GROUP BY gender;


-- Customer behavior by age
WITH customer_age AS ( 
SELECT 
s.sales_amount,
DATEDIFF(YEAR, c.birth_date, GETDATE()) 
- CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, c.birth_date, GETDATE()), c.birth_date)
> GETDATE() 
THEN 1 
ELSE 0 
END AS age 
FROM gold.fact_sales s 
JOIN gold.dim_customers c 
ON s.customer_key = c.customer_key ) 
SELECT age, 
AVG(sales_amount) AS avg_spend 
FROM customer_age 
WHERE age BETWEEN 18 AND 100 
GROUP BY age;


