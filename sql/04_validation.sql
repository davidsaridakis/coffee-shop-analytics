-- --------------------------------------------
-- Validate newly populated tables
-- --------------------------------------------

-- ====================================
-- Row Count Validation
-- ====================================
SELECT
    (SELECT COUNT(*) FROM stg_cafe_transactions) AS staging_row_count,
    (SELECT COUNT(*) FROM fact_transactions) AS fact_transactions_count;



-- ====================================
-- Dimension Validation
-- ====================================
SELECT
    (SELECT COUNT(DISTINCT store_id) FROM stg_cafe_transactions) AS staging_store_id_count,
    (SELECT COUNT(*) FROM dim_stores) AS dim_stores_count;

SELECT
    (SELECT COUNT(DISTINCT product_id) FROM stg_cafe_transactions) AS staging_product_count,
    (SELECT COUNT(*) FROM dim_products) AS dim_products_count; 

-- ====================================
-- Primary Key Validation
-- ====================================
SELECT
    (SELECT COUNT(DISTINCT transaction_id) FROM fact_transactions) AS unique_trans_ids,
    (SELECT COUNT(transaction_id) FROM fact_transactions) AS total_trans_ids;


-- ====================================
-- Null Value Validation
-- ====================================



-- ====================================
-- Referential Integrity Validation
-- ====================================



-- ====================================
-- Transformation Validation
-- ====================================
SELECT()


-- ====================================
-- Sample Data Inspection
-- ====================================