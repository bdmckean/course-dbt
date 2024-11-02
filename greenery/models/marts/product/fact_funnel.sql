



with events as (
  select *
  from {{ ref('_int_session_events') }}
)

SELECT 
  count_if(has_page_view = true) as sessions_with_page_view
  ,  count_if(has_add_to_cart = true) as sessions_with_add_to_cart
  , count_if(has_checkout = true) as sessions_with_checkout
  ,  sessions_with_page_view - sessions_with_add_to_cart as lost_after_page_view
  ,  (sessions_with_page_view - sessions_with_add_to_cart) / sessions_with_page_view as percent_lost_after_page_view
  ,  sessions_with_add_to_cart - sessions_with_checkout as lost_after_add_to_cart
  ,  (sessions_with_add_to_cart - sessions_with_checkout) / sessions_with_add_to_cart as percent_lost_after_add_to_cart

from events





