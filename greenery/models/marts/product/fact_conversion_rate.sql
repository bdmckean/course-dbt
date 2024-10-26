


{{ dbt_utils.log_info("doing fact_conversion_rate.sql") }}

with session_events as (
  select * 
  from {{ ref('_int_session_events') }}
),
purchases AS (
    SELECT 
        session_id,
        MAX(CASE WHEN has_checkout = true THEN 1 ELSE 0 END) as has_purchase
    FROM session_events
    GROUP BY session_id
)

SELECT 
    COUNT(DISTINCT session_id) as total_sessions,
    SUM(has_purchase) as sessions_with_purchase,
    ROUND(CAST(SUM(has_purchase) AS FLOAT) / CAST(COUNT(DISTINCT session_id) AS FLOAT), 3) as conversion_ratio
FROM purchases