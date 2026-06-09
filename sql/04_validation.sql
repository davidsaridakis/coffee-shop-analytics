-- ==================================================
-- Coffee Shop Analytics
-- File: 04_validation.sql
--
-- Purpose:
-- Validate loaded data and verify row counts,
-- key integrity, referential integrity and 
-- transformation accuracy.
-- ==================================================

-- ------------------------------------
-- 1. Row Count Validation
-- ------------------------------------
SELECT
    (SELECT COUNT(*) FROM stg_cafe_transactions) AS staging_row_count,
    (SELECT COUNT(*) FROM fact_transactions) AS fact_transactions_count;


-- ------------------------------------
-- 2. Dimension Validation
-- ------------------------------------
SELECT
    (SELECT COUNT(DISTINCT store_id) FROM stg_cafe_transactions) AS staging_store_id_count,
    (SELECT COUNT(*) FROM dim_stores) AS dim_stores_count;

SELECT
    (SELECT COUNT(DISTINCT product_id) FROM stg_cafe_transactions) AS staging_product_count,
    (SELECT COUNT(*) FROM dim_products) AS dim_products_count; 


-- ------------------------------------
-- 3. Primary Key Validation
-- ------------------------------------
SELECT
    (SELECT COUNT(DISTINCT transaction_id) FROM fact_transactions) AS unique_trans_ids,
    (SELECT COUNT(transaction_id) FROM fact_transactions) AS total_trans_ids;


-- ------------------------------------
-- 4. Null Value Validation
-- ------------------------------------
SELECT
    (SELECT COUNT(*) FROM fact_transactions WHERE transaction_id IS NULL) AS transaction_id_null_count,
    (SELECT COUNT(*) FROM fact_transactions WHERE unit_price IS NULL) AS unit_price_null_count,
    (SELECT COUNT(*) FROM fact_transactions WHERE transaction_qty IS NULL) AS transaction_qty_null_count,
    (SELECT COUNT(*) FROM fact_transactions WHERE product_id IS NULL) AS product_id_null_count,
    (SELECT COUNT(*) FROM fact_transactions WHERE store_id IS NULL) AS store_id_null_count;


-- ------------------------------------
-- 5. Referential Integrity Validation
-- ------------------------------------
SELECT COUNT(*) AS invalid_store_refs
FROM fact_transactions AS ft
LEFT JOIN dim_stores AS ds
    ON ft.store_id = ds.store_id
WHERE ds.store_id IS NULL;

SELECT COUNT(*) AS invalid_product_refs
FROM fact_transactions AS ft
LEFT JOIN dim_products AS dp
    ON ft.product_id = dp.product_id
WHERE dp.product_id IS NULL;


-- ------------------------------------
-- 6. Revenue Transformation Validation
-- ------------------------------------
SELECT
    COUNT(*) AS invalid_revenue_rows
FROM fact_transactions
WHERE line_revenue <> unit_price * transaction_qty; 

SELECT
    (SELECT SUM(line_revenue) 
    FROM fact_transactions) AS fact_revenue,

    (SELECT SUM(unit_price * transaction_qty)
    FROM stg_cafe_transactions) AS staging_revenue;


-- ------------------------------------
-- 7. Sample Data Inspection
-- ------------------------------------
SELECT * 
FROM fact_transactions 
LIMIT 10;