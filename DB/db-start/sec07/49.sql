select
    category,
    count(*) as premium_order_count
from
    order_stat
where
    price >= 100000
group by
    category
having
    count(*) >= 2;