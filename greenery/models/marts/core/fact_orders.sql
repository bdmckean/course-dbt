
SELECT
  o.order_id
  , o.order_cost
  , o.shipping_cost
  , o.order_total
  , pc.promo_id
  , pc.discount AS promo_discount
  , o.user_id
  , u.first_name AS user_first_name
  , o.tracking_id
  , o.status AS shipment_status
  , CASE
    WHEN o.delivered_at_utc IS NULL THEN NULL
    ELSE DATEDIFF(day, o.created_at_utc, o.delivered_at_utc)
  END AS days_to_deliver
FROM {{ ref('_stg_postgres_orders') }} o
LEFT JOIN {{ ref('_stg_postgres_promos') }} pc
  ON o.promo_id = pc.promo_id
LEFT JOIN {{ ref('_stg_postgres_users') }} u
  ON o.user_id = u.user_id

