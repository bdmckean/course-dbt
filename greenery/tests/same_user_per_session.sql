
with user_counts as
(
select
  session_id
  , count(distinct user_id) as users_in_session
from {{ ref('_stg_postgres_events')}}
group by session_id
)
select * from user_counts
where users_in_session != 1