How many users do we have?

```
select count(*) from _stg_postgres_users;
```

130

On average, how many orders do we receive per hour?
```
select
    (count(distinct(order_id)) / datediff("hours", min(created_at), max(created_at))) as per_hour_avg
from _stg_postgres_orders;
```

7.680851



On average, how long does an order take from being placed to being delivered?
```
with delivery_times as(
select
    timediff("days", created_at, delivered_at) as order_delivery_time
    from _stg_postgres_orders
)
select avg(order_delivery_time) as average_delivery_time from delivery_times;
```
3.89 days


How many users have only made one purchase? Two purchases? Three+ purchases?

```
WITH user_order_counts AS (
  SELECT 
    user_id,
    COUNT(DISTINCT order_id) AS order_count
  FROM _stg_postgres_orders
  GROUP BY user_id
),
order_frequency AS (
  SELECT
    CASE
      WHEN order_count = 1 THEN '1 order'
      WHEN order_count = 2 THEN '2 orders'
      ELSE '3 or more orders'
    END AS order_frequency,
    COUNT(*) AS user_count
  FROM user_order_counts
  GROUP BY 
    CASE
      WHEN order_count = 1 THEN '1 order'
      WHEN order_count = 2 THEN '2 orders'
      ELSE '3 or more orders'
    END
)
SELECT *
FROM order_frequency
ORDER BY 
  CASE order_frequency
    WHEN '1 order' THEN 1
    WHEN '2 orders' THEN 2
    WHEN '3 or more orders' THEN 3
  END;
  ```


| ORDER_FREQUENCY	| USER_COUNT |
| ----------------- | __________ |
|1 order.           | 25.        |
|2 orders.          | 28.        |
|3 or more orders   | 71         |


Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.



On average, how many unique sessions do we have per hour?
```
select
    (count(distinct(session_id)) / datediff("hours", min(created_at), max(created_at))) as per_hour_avg
from _stg_postgres_events;
```

10.14
