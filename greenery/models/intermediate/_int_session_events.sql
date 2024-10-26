{{
  config(
    materialized='view'
  )
}}



with sessions as
(
    select * 
    from {{ ref('_stg_postgres_events') }}
)


SELECT 
    session_id
    , min(created_at_utc) as session_start
    , max(created_at_utc) as session_end
    , {{ has_item('event_type', 'page_view') }}
    , {{ has_item('event_type','add_to_cart') }} 
    , {{ has_item('event_type','product_shipped') }}
    , {{ has_item('event_type','checkout') }}
FROM sessions
GROUP BY session_id
order by session_id
