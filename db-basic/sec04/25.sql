select *
from orders
where (user_id, status) = (select user_id, status
							from orders
							where order_id = 3);

select
	o.order_id,
    o.user_id,
    u.name,
    p.name as product_name,
    o.order_date
from orders o
join users u on o.user_id = u.user_id
join products p on o.product_id = p.product_id
where (o.user_id, o.order_date) in (select user_id, min(order_date)
									from orders
									group by user_id);