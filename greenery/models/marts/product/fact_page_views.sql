{{
  config(
    materialized='table'
  )
}}

with events as 
(
  select
  *
  from _stg_postgres_events

),

session_times as
(
  select * from {{ ref('_int_session_timings')}}

)

SELECT 
e.session_id
, e.user_id
, st.session_start as session_start_utc
, st.session_end as session_end_utc
, sum(case when event_type = 'page_view' then 1 else 0 end)  as page_views
, sum(case when event_type = 'add_to_cart' then 1 else 0 end ) as add_to_cart
, sum(case when event_type = 'checkout' then 1 else 0 end) as checkout
, sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
, DATEDIFF('minute', st.session_end, st.session_end) as session_duration_minutes
from events e
left join session_times st
on e.session_id = st.session_id
group by
 e.session_id
 , e.user_id
 , session_start_utc
 , session_end_utc
 , session_duration_minutes




