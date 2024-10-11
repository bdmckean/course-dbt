How many users do we have?

select count(*) from _stg_postgres_users;
130

On average, how many orders do we receive per hour?
select 
    count(distinct order_id) as order_count,
    date_trunc("hour", created_at) as date_hour
from _stg_postgres_orders
group by date_hour
order by date_hour asc;

ORDER_COUNT	DATE_HOUR
11	2021-02-10 00:00:00.000
8	2021-02-10 01:00:00.000
3	2021-02-10 02:00:00.000
6	2021-02-10 03:00:00.000
5	2021-02-10 04:00:00.000
3	2021-02-10 05:00:00.000
9	2021-02-10 06:00:00.000
8	2021-02-10 07:00:00.000
4	2021-02-10 08:00:00.000
9	2021-02-10 09:00:00.000
10	2021-02-10 10:00:00.000
11	2021-02-10 11:00:00.000
7	2021-02-10 12:00:00.000
10	2021-02-10 13:00:00.000
7	2021-02-10 14:00:00.000
8	2021-02-10 15:00:00.000
7	2021-02-10 16:00:00.000
10	2021-02-10 17:00:00.000
7	2021-02-10 18:00:00.000
5	2021-02-10 19:00:00.000
10	2021-02-10 20:00:00.000
7	2021-02-10 21:00:00.000
6	2021-02-10 22:00:00.000
6	2021-02-10 23:00:00.000
4	2021-02-11 00:00:00.000
6	2021-02-11 01:00:00.000
8	2021-02-11 02:00:00.000
6	2021-02-11 03:00:00.000
8	2021-02-11 04:00:00.000
7	2021-02-11 05:00:00.000
4	2021-02-11 06:00:00.000
4	2021-02-11 07:00:00.000
8	2021-02-11 08:00:00.000
6	2021-02-11 09:00:00.000
15	2021-02-11 10:00:00.000
14	2021-02-11 11:00:00.000
5	2021-02-11 12:00:00.000
4	2021-02-11 13:00:00.000
11	2021-02-11 14:00:00.000
8	2021-02-11 15:00:00.000
12	2021-02-11 16:00:00.000
5	2021-02-11 17:00:00.000
8	2021-02-11 18:00:00.000
3	2021-02-11 19:00:00.000
10	2021-02-11 20:00:00.000
8	2021-02-11 21:00:00.000
6	2021-02-11 22:00:00.000
14	2021-02-11 23:00:00.000

On average, how long does an order take from being placed to being delivered?
with delivery_times as(
select
    timediff("days", created_at, delivered_at) as order_delivery_time
    from _stg_postgres_orders
)
select avg(order_delivery_time) as average_delivery_time from delivery_times;
3.89 days


How many users have only made one purchase? Two purchases? Three+ purchases?
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

ORDER_FREQUENCY	USER_COUNT
1 order	25
2 orders	28
3 or more orders	71


Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.



On average, how many unique sessions do we have per hour?
select
    (count(distinct(session_id)) / datediff("hours", min(created_at), max(created_at))) as per_hour_avg
from _stg_postgres_events;
10.14
