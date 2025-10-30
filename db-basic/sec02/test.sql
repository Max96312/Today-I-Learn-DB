-- 1
select
    o.order_id,
    p.name,
    p.stock_quantity
from orders o
inner join products p
on o.product_id = p.product_id;

-- 2
select
    o.order_id,
    u.name as user_name,
    p.name as product_name,
    o.order_date
from orders o
inner join users u
on o.user_id = u.user_id
inner join products p
on o.product_id = p.product_id
where o.status = "SHIPPED";

-- 3
select
	u.name as user_name,
    SUM(o.quantity * p.price) as total_purchase_amount
from orders o
join users u on o.user_id = u.user_id
join products p on o.product_id = p.product_id
group by o.user_id
order by total_purchase_amount desc;