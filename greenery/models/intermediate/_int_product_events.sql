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
    , product_id
    , {{ has_item('event_type', 'page_view') }}
    , {{ has_item('event_type','add_to_cart') }} 
    , {{ has_item('event_type','product_shipped') }}
    , {{ has_item('event_type','checkout') }}
FROM sessions
GROUP BY 1,2
ORDER BY product_id, session_id