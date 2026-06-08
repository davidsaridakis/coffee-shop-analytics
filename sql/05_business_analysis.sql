-- =============================================
-- Objective: 
-- Use historical transactional data to support
-- Staffing decisions
-- Product mix decisions
-- Operational decisions (Bakery production) 
-- =============================================

-- ======================================================
-- 1. Staff Planning: Identifying daily demand patterns
-- ======================================================

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


-- -----------------------------------------
-- Average count of transactions by hour
-- -----------------------------------------
-- Tells us about demand on staff throughout
-- the day. 
-- -----------------------------------------
SELECT
    transaction_hour,
    is_weekend,
    ROUND(AVG(total_transactions), 2) AS avg_hourly_transaction_count
FROM v_daily_hourly_sales_base
GROUP BY
    transaction_hour,
    is_weekend
ORDER BY transaction_hour;


-- -------------------------------------------
-- Average revenue by hour
-- -------------------------------------------
-- Which hours generate the most revenue?
-- Does this correlate with transaction count?
-- -------------------------------------------
SELECT
    transaction_hour,
    is_weekend,
    ROUND(AVG(total_revenue), 2) AS average_hourly_revenue
FROM v_daily_hourly_sales_base
GROUP BY
    transaction_hour,
    is_weekend
ORDER BY transaction_hour;


-- ------------------------------------------------
-- Average units_sold by hour
-- ------------------------------------------------
-- Is business high-volume, low-cost transactions?
-- Are there any low-volume high-cost transactions?
-- ------------------------------------------------
SELECT
    transaction_hour,
    is_weekend,
    ROUND(AVG(total_units_sold), 2) AS average_hourly_units_sold
FROM v_daily_hourly_sales_base
GROUP BY
    transaction_hour,
    is_weekend
ORDER BY transaction_hour;


-- =============================================
-- 2. Product Mix: Identifying product behaviour
-- =============================================

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


-- -----------------------------------------
-- Revenue Concentration
-- -----------------------------------------
-- Which product categories are responsible  
-- for driving revenue?
-- -----------------------------------------
SELECT
    product_category,
    ROUND(CAST(SUM(line_revenue) AS NUMERIC), 2) AS total_revenue
FROM v_product_sales_reporting
GROUP BY product_category
ORDER BY total_revenue DESC;


-- ------------------------------------
-- Volume by Category
-- ------------------------------------
-- Which product categories have the 
-- highest sales volume?
-- ------------------------------------
SELECT
    product_category,
    SUM(transaction_qty) AS total_units_sold
FROM v_product_sales_reporting
GROUP BY product_category
ORDER BY total_units_sold DESC;


-- ------------------------------------
-- Category Sales Behaviour over Time
-- ------------------------------------
-- How do products sell over the course
-- of a day?
-- ------------------------------------
WITH daily_total_units AS (
    SELECT 
        transaction_date,
        EXTRACT(HOUR FROM transaction_time) As transaction_hour,
        product_category,
        SUM(transaction_qty) AS total_units_sold
    FROM v_product_sales_reporting
    GROUP BY
        transaction_date,
        EXTRACT(HOUR FROM transaction_time),
        product_category
)
SELECT
    product_category,
    transaction_hour,
    AVG(total_units_sold) AS average_units_sold
FROM daily_total_units
GROUP BY
    transaction_hour,
    product_category
ORDER BY 
    transaction_hour,
    product_category;


-- -------------------------------------
-- Top 5 product categories by revenue generated
-- -------------------------------------
SELECT
    product_category,
    ROUND(CAST(SUM(line_revenue) AS NUMERIC), 2) AS total_revenue
FROM v_product_sales_reporting
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 5;


-- ==================================================
-- 3. Operational Planning: Food prep and production
-- ==================================================
-- Calculate daily averages for the different 
-- product types
-- --------------------------------------------------
WITH daily_bakery_totals AS (
    SELECT
        transaction_date,
        EXTRACT(ISODOW FROM transaction_date) AS day_of_week,
        product_type,
        SUM(transaction_qty) AS total_bakery_products
    FROM v_product_sales_reporting
    WHERE product_category = 'Bakery'
    GROUP BY
        transaction_date,
        EXTRACT(ISODOW FROM transaction_date),
        product_type
)
SELECT
    day_of_week,
    product_type,
    ROUND(AVG(total_bakery_products), 2) AS avg_bakery_sold
FROM daily_bakery_totals
GROUP BY 
    day_of_week,
    product_type
ORDER BY day_of_week,
product_type;

-- -------------------------------------------------
-- Morning vs Afternoon Comparison
-- -------------------------------------------------
WITH bakery_shift_sales AS (
    SELECT
        transaction_date,
        EXTRACT(ISODOW FROM transaction_date) AS day_of_week,
        CASE
            WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 6 AND 11
            THEN 'Morning sales'
            ELSE 'Rest of day sales'
        END AS shift,

        SUM(transaction_qty) AS total_day_sales
    FROM v_product_sales_reporting
    WHERE product_category = 'Bakery'
    GROUP BY
        transaction_date,
        EXTRACT(ISODOW FROM transaction_date),
        CASE
            WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 6 AND 11
            THEN 'Morning sales'
            ELSE 'Rest of day sales'
        END
)
SELECT
    day_of_week,
    shift,
    ROUND(AVG(total_day_sales), 2) AS avg_units_sold
FROM bakery_shift_sales
GROUP BY
    day_of_week,
    shift
ORDER BY
    day_of_week,
    shift;
