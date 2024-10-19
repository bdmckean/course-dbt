{{
  config(
    materialized='view'
  )
}}

SELECT 
u.user_id
, u.first_name
, u.last_name
, u.email
, u.phone_number
, u.created_at_utc
, u.updated_at_utc
, u.address_id
, min(o.created_at_utc) as first_order_at_utc
, max(o.created_at_utc) as most_recent_order_at_utc
, count(CASE WHEN promo_id IS NOT NULL THEN 1 END) AS order_with_promo
, count(o.order_id) as number_of_orders
, sum(o.order_cost) as total_order_cost
from {{ ref('_stg_postgres_users') }} u
left join {{ ref('_stg_postgres_orders') }} o
  on u.user_id = o.user_id
group by 
u.user_id
, u.first_name
, u.last_name
, u.email
, u.phone_number
, u.created_at_utc
, u.updated_at_utc
, u.address_id