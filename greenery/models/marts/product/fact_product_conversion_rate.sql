


with product_events as
(
    select
    *
    from {{ ref('_int_product_events') }}
),
purchases AS (
    SELECT 
        session_id
        , product_id
        , MAX(CASE WHEN has_checkout = true THEN 1 ELSE 0 END) as has_purchase
    FROM product_events
    GROUP BY 1,2
)

SELECT 
    product_id
    , COUNT(DISTINCT session_id) as total_sessions
    , SUM(has_purchase) as sessions_with_purchase
    , ROUND(CAST(SUM(has_purchase) AS FLOAT) / 
          CAST(COUNT(DISTINCT session_id) AS FLOAT), 3) as purchase_ratio
FROM purchases
GROUP BY product_id
ORDER BY product_id






