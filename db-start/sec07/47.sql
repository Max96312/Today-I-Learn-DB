select
	category,
    count(*)
from
	order_stat
group by category;

select
	category,
    product_name, -- X
    quantity, -- X
    count(*),
    sum(quantity)
from
	order_stat
group by category;

select
	category,
    min(product_name),
    max(quantity),
    count(*),
    sum(quantity)
from
	order_stat
group by category;