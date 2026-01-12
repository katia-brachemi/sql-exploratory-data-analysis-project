/*
===========================================================================================
Delivery Performance Analysis  
===========================================================================================
 Purpose:
     - Evaluate delivery performance using two key metrics:
     - Average shipping delay (days between order and shipping).
     - Compare shipping delays across product lines and countries.
     - On-time delivery rate (percentage of orders shipped by due date).

SQL Functions Used:
   - Aggregate Functions: COUNT(), AVG()
   - Window Functions
   - GROUP BY, ORDER BY
   - Date Functions: DATEDIFF()
   - Conditional Logic: CASE
===========================================================================================
*/

 -- Average shipping delay in days
SELECT AVG(DATEDIFF(day, order_date, shipping_date)) AS avg_shipping_delay
FROM gold.fact_sales;

-- Average shipping delay by product line
SELECT 
    p.product_line,
    AVG(DATEDIFF(day, order_date, shipping_date)) AS avg_shipping_delay_days
FROM gold.fact_sales s
JOIN gold.dim_products p ON s.product_key = p.product_key
GROUP BY p.product_line
ORDER BY avg_shipping_delay_days DESC;

-- Average shipping delay by country
SELECT 
    c.country,
    AVG(DATEDIFF(day, order_date, shipping_date)) AS avg_shipping_delay_days
FROM gold.fact_sales s
JOIN gold.dim_customers c ON s.customer_key = c.customer_key
GROUP BY c.country
ORDER BY avg_shipping_delay_days DESC;

-- On-time delivery rate (% of orders shipped by due date)
SELECT 
    CAST(
        COUNT(CASE WHEN shipping_date <= due_date THEN 1 END) * 100.0 / COUNT(*) 
        AS INT
    ) AS on_time_rate
FROM gold.fact_sales;

