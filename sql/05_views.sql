-- =============================================
-- Coffee Shop Analytics
-- File: 04_views.sql
-- =============================================
-- Purpose:
-- Create reusable reporting views that simplify
-- business analysis queries and reduce repetitive
-- joins and aggregations.
--
-- Views:
-- --------------------------------------------------
-- Create reusable reporting view containing hourly
-- transaction, revenue and volume metrics
-- --------------------------------------------------
CREATE OR REPLACE VIEW v_daily_hourly_sales_base AS
SELECT
    transaction_date,
    EXTRACT(HOUR FROM transaction_time) AS transaction_hour,
    CASE
        WHEN EXTRACT(ISODOW FROM transaction_date) IN (6,7)
        THEN TRUE
        ELSE FALSE
    END AS is_weekend,
    COUNT(transaction_id) AS total_transactions,
    SUM(line_revenue) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold
FROM fact_transactions
GROUP BY
    transaction_date,
    EXTRACT(HOUR FROM transaction_time),
    EXTRACT(ISODOW FROM transaction_date);

-- ------------------------------------------------
-- Create reusable reporting view combining 
-- transactional sales data with product attributes
-- ------------------------------------------------
CREATE OR REPLACE VIEW v_product_sales_reporting AS
SELECT
    ft.transaction_id,
    ft.transaction_date,
    ft.transaction_time,
    ft.transaction_qty,
    ft.unit_price,
    ft.line_revenue,
    dp.product_category,
    dp.product_detail,
    dp.product_type
FROM fact_transactions AS ft
JOIN dim_products AS dp
    ON ft.product_id = dp.product_id;