/*
================================================================================================================================
-- 1. Database Exploration
================================================================================================================================
Purpose: 
    - This section explores the database schema to understand its structure, available tables, and the columns within them. 
    - This is the foundation for any exploratory data analysis, ensuring we know what data is available and how it is organized.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
================================================================================================================================
*/

  -- Explore All Objects in the Database
SELECT*
FROM INFORMATION_SCHEMA.TABLES;

-- Explore All Columns in the Databse
SELECT*
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME= 'dim_customers';
