


with product_events as
(
    select
    *
    from {{ ref('_int_product_events') }}
)


SELECT 
    product_id
    , COUNT(DISTINCT session_id) as total_sessions
    , COUNT_IF(has_purchase = true) as sessions_with_purchase
    , ROUND(CAST(count_if(has_purchase = true) AS FLOAT) / 
          CAST(COUNT(DISTINCT session_id) AS FLOAT), 3) as purchase_ratio
FROM product_events
GROUP BY product_id
ORDER BY product_id






