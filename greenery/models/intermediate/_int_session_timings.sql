{{
  config(
    materialized='view'
  )
}}


with session_times as
(
select 
   session_id
   , min(created_at_utc) as session_start
   , max(created_at_utc) as session_end
  from {{ ref('_stg_postgres_events') }}
  group by session_id
)
select * from session_times