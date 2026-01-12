/*
--================================================================
Customer Behavior Analysis
--================================================================
Purpose:
    - Summarize customer activity using Recency, Frequency, and Monetary (RFM).
    - Build RFM metrics (Recency, Frequency, Monetary) for each customer.

  Terms Used:
   - Recency: Most recent purchase date 
   - Frequency: Total number of purchases
   - Monetary: Total spend

SQL Functions Used:
   - Aggregate Functions: SUM(), COUNT()
   - Window Functions
   - GROUP BY, ORDER BY
===============================================================================
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

