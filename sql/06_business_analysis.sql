-- =============================================
-- Coffee Shop Analytics
-- File: 06_business_analysis.sql
--
-- Purpose: 
-- Analyse transactional sales data to support
-- staffing decisions, product mix analysis and
-- operational planning
-- =============================================

-- ======================================================
-- 1. Staff Planning: Identifying daily demand patterns
-- ======================================================

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


-- ---------------------------------------------------------
-- Product Category Contribution
-- ---------------------------------------------------------
-- Which product categories contribute disproportionately 
-- to revenue relative to their sales volume?
-- ---------------------------------------------------------
SELECT
    product_category,
    SUM(line_revenue) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold,

    ROUND(
        100.0 * SUM(line_revenue)
        / SUM(SUM(line_revenue)) OVER (),
        2
    ) AS revenue_share_pct,

    ROUND(
        100.0 * SUM(transaction_qty)
        / SUM(SUM(transaction_qty)) OVER (),
        2
    ) AS volume_share_pct,

    ROUND(
        (
            100.0 * SUM(line_revenue)
            / SUM(SUM(line_revenue)) OVER ()
        ) -
        (
            100.0 * SUM(transaction_qty)
            / SUM(SUM(transaction_qty)) OVER ()
        ),
        2
    ) AS share_difference

FROM v_product_sales_reporting
GROUP BY product_category
ORDER BY revenue_share_pct DESC;



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


-- ----------------------------------------------
-- Top 5 product categories by revenue generated
-- ----------------------------------------------
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
-- product types in 'Bakery' category
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
