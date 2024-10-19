{{
  config(
    materialized='table'
  )
}}

SELECT 
USER_ID
, FIRST_NAME
, LAST_NAME
, EMAIL
, PHONE_NUMBER
, CREATED_AT_UTC
, UPDATED_AT_UTC
, ADDRESS_ID
, FIRST_ORDER_AT_UTC
, MOST_RECENT_ORDER_AT_UTC
, ORDER_WITH_PROMO
, NUMBER_OF_ORDERS
, TOTAL_ORDER_COST
, CASE
    when number_of_orders > 1 then True
    else False
    END as repeat_buyer
  from {{ ref('_int_user_order') }}



