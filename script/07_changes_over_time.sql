/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - This script explores how business performance evolves across time.
    - It combines yearly and monthly perspectives to highlight growth trends and category contributions.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT()
    - Date Functions: YEAR(), MONTH(), DATETRUNC(), FORMAT()
    - GROUP BY, ORDER BY 
===============================================================================
*/

-- Year-over-year growth in orders
SELECT 
YEAR(order_date) AS year,
COUNT(DISTINCT order_number) AS total_orders 
FROM gold.fact_sales 
GROUP BY YEAR(order_date) 
ORDER BY year;


-- Calculate yearly revenue per category 
SELECT 
YEAR(s.order_date) AS year, 
p.category, 
SUM(s.sales_amount) AS category_revenue 
FROM gold.fact_sales AS s 
JOIN gold.dim_products AS p 
ON s.product_key = p.product_key 
GROUP BY YEAR(s.order_date), p.category 
ORDER BY p.category, year;


-- Calculates each product category’s percentage contribution to total revenue per year
WITH yearly_total AS (
    SELECT 
        YEAR(order_date) AS year,
        SUM(sales_amount) AS total_revenue
    FROM gold.fact_sales
    GROUP BY YEAR(order_date)
)
SELECT 
    YEAR(s.order_date) AS year,
    p.category,
    SUM(s.sales_amount) AS category_revenue,
    CAST(
        ROUND(
            SUM(s.sales_amount) * 100.0 / yt.total_revenue,
            2
        )
    AS DECIMAL(5,2)) AS revenue_share_percent
FROM gold.fact_sales s
JOIN gold.dim_products p 
    ON s.product_key = p.product_key
JOIN yearly_total yt 
    ON YEAR(s.order_date) = yt.year
GROUP BY YEAR(s.order_date), p.category, yt.total_revenue
ORDER BY year, revenue_share_percent DESC;

-- Analyze monthly sales performance
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);
