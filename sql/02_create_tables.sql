-- ----------------------------------------
-- CREATE TABLES
-- ----------------------------------------

-- Drop tables if they already exist
DROP TABLE IF EXISTS fact_transactions;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_stores;
DROP TABLE IF EXISTS stg_cafe_transactions;

-- Create staging table
CREATE TABLE stg_cafe_transactions(
	transaction_id INT,
	transaction_date DATE,
	transaction_time TIME,
	transaction_qty INT,
	store_id INT,
	store_location VARCHAR(255),
	product_id INT,
    unit_price FLOAT,
	product_category VARCHAR(255),
	product_type VARCHAR(255),
	product_detail VARCHAR(255)
);

-- Create dimension table for store information
CREATE TABLE dim_stores(
	store_id INT PRIMARY KEY,
	store_location VARCHAR(255)
);

-- Create dimension table for product information
CREATE TABLE dim_products(
	product_id INT PRIMARY KEY,
	product_category VARCHAR(255),
	product_type VARCHAR(255),
	product_detail VARCHAR(255)
);

-- Create fact table
CREATE TABLE fact_transactions(
	transaction_id INT PRIMARY KEY,
	transaction_date DATE,
	transaction_time TIME,
	transaction_qty INT,
	unit_price FLOAT,
	line_revenue FLOAT,
	store_id INT REFERENCES dim_stores(store_id),
	product_id INT REFERENCES dim_products(product_id)
);