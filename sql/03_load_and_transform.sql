-- --------------------------------------------
-- Load and Transform Data
-- --------------------------------------------

-- Remove all rows from database tables to avoid duplication
-- NOTE: delete the dependent tables first
TRUNCATE TABLE 
    fact_transactions
    dim_stores
    dim_products;


-- Populate dim_stores dimension table
INSERT INTO dim_stores (store_id, store_location)
SELECT DISTINCT 
    store_id,
    store_location 
FROM stg_cafe_transactions;


-- Populate dim_products dimension table
INSERT INTO dim_products (product_id, product_category, product_type, product_detail)
SELECT DISTINCT
    product_id,
    product_category,
    product_type,
    product_detail
FROM stg_cafe_transactions;

-- Populate fact_transactions fact table
INSERT INTO fact_transactions (
    transaction_id,
	transaction_date,
	transaction_time,
	transaction_qty,
	unit_price,
	line_revenue,
	store_id,
	product_id
)
SELECT DISTINCT
    stg.transaction_id,
	stg.transaction_date,
	stg.transaction_time,
	stg.transaction_qty,
	stg.unit_price,
	(stg.transaction_qty * stg.unit_price) AS line_revenue,
	s.store_id,
	p.product_id
FROM stg_cafe_transactions AS stg
JOIN dim_stores AS s
    ON stg.store_id = s.store_id
JOIN dim_products AS p
    ON stg.product_id = p.product_id;
