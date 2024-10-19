{{
  config(
    materialized='table'
  )
}}

SELECT 
user_id
,first_name
,last_name
,email
,phone_number
,created_at as created_at_utc
,updated_at as updated_at_utc
,address_id
from {{ source('postgres', 'users') }}