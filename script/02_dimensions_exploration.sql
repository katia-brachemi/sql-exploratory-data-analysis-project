/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
   - This section explores the categorical dimensions of the dataset.
   - It helps identify the countries customers come from and the product hierarchy
     (categories, subcategories, and product names). 

SQL Functions Used:
  - DISTINCT
  - ORDER BY

===============================================================================
*/

-- Retrieve the list of all countries where customers are located
SELECT DISTINCT country
FROM gold.dim_customers;

-- Retrieve the product hierarchy: categories, subcategories, and product names.
SELECT DISTINCT category,subcategory,product_name
FROM gold.dim_products
ORDER BY 1,2,3;

