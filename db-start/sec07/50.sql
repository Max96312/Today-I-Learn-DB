select
    customer_name,
    sum(price * quantity) as total_purchase
from
    order_stat
where
    total_purchase >= 400000
group by
    customer_name;

select
    customer_name,
    sum(price * quantity) as total_purchase
from
    order_stat
where
    order_date < '2025-05-14'
group by
    customer_name
having
    count(*) >= 2
order by
    total_purchase desc
limit 1;