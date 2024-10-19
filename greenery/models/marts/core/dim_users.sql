{{
  config(
    materialized='table'
  )
}}

SELECT 
user_id
, first_name
, last_name
, email
, phone_number
, created_at_utc
, updated_at_utc
, address_id
from {{ ref('_stg_postgres_users') }}