select
	u.user_id, u.name, u.email, u.address,
    o.order_id, o.order_date, o.quantity
from orders o
join users u on o.user_id = u.user_id;

select
	u.user_id, u.name, u.email, u.address,
    o.order_id, o.order_date, o.quantity,
    p.product_id, p.name, p.price
from orders o
join users u on o.user_id = u.user_id
join products p on o.product_id = p.product_id;

select
	u.user_id, u.name, u.email, u.address,
    o.order_id, o.order_date, o.quantity,
    p.product_id, p.name, p.price
from orders o
join users u on o.user_id = u.user_id
join products p on o.product_id = p.product_id
where u.address like "서울시%"
	and o.order_date >= '2025-06-01' and o.order_date < '2025-07-01 '

select
	u.user_id as customer_name,
    u.email,
    o.order_date,
    p.name as product_name,
    p.price,
    o.quantity
from orders o
join users u on o.user_id = u.user_id
join products p on o.product_id = p.product_id
where u.address like "서울시%"
	and o.order_date >= '2025-06-01' and o.order_date < '2025-07-01 '
order by o.order_date desc;