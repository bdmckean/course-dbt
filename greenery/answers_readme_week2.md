
```
select
    count_if(number_of_orders > 1) / count_if(number_of_orders > 0)
    as fraction_repeat_buyers
from fact_user_order;
```
FRACTION_REPEAT_BUYERS
0.798387