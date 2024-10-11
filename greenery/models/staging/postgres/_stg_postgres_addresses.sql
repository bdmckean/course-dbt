{{
  config(
    materialized='table'
  )
}}

SELECT 
address_id
, address
, zipcode
, state
, country
from {{ source('postgres', 'addresses') }}