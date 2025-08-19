select
  category,
  sum(price * quantity) as total_sales
from
  order_stat
where
  sum(price * quantity) >= 50000
group by
  category;

select
    category,
    sum(price * quantity) as total_sales
from
    order_stat
group by
    category
having
	sum(price * quantity) >= 500000;

select
	customer_name,
    count(*) as order_count
from
	order_stat
group by
	customer_name
having
	count(*) >= 3;