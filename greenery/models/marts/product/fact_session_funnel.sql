



with events as (
  select *
  from {{ ref('_stg_postgres_events') }}
),

session_times as (
  select * 
  from {{ ref('_int_session_timings') }}
)

SELECT 
  e.session_id
  , e.user_id
  , st.session_start as session_start_utc
  , st.session_end as session_end_utc
  , {{ count_items('event_type', 'page_view') }} as page_views
  , {{ count_items('event_type', 'add_to_cart') }} as add_to_cart
  , {{ count_items('event_type', 'checkout') }} as checkout
  , {{ count_items('event_type', 'package_shipped') }} as package_shipped
  , DATEDIFF('minute', st.session_start, st.session_end) as session_duration_minutes  -- Fixed the DATEDIFF calculation
from events e
left join session_times st
  on e.session_id = st.session_id
group by 1,2,3,4




