{{
  config(
    materialized='table'
  )
}}

SELECT 
product_id
,name
,price
,inventory
from {{ source('postgres', 'products') }}