 {{
    config(
        materialized='view'
    )
}}


with product_sessions as
(
    select * 
    from {{ ref('_stg_postgres_events') }}
    where product_id is not null
),
purchase as
(
    select session_id
    from {{ ref('_stg_postgres_events') }}
    where event_type = 'checkout'
)

SELECT 
    s.session_id
    , s.product_id
    , {{ has_item('event_type', 'page_view') }}
    , {{ has_item('event_type','add_to_cart') }} 
    , case when p.session_id is not null then true
        else false end as has_purchase

FROM product_sessions s
full outer join purchase p
on s.session_id = p.session_id
GROUP BY s.session_id, s.product_id, p.session_id
ORDER BY s.product_id, s.session_id