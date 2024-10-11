{{
  config(
    materialized='table'
  )
}}

SELECT 
promo_id
,discount
,status
from {{ source('postgres', 'promos') }}