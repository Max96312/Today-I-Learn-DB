-- 1
select p.name, p.price
from products p
left join orders o on p.product_id = o.product_id
where p.category = "전자기기"
	and o.order_id is null;

-- 2
select
	u.name,
	count(o.order_id) as order_count
from users u
left join orders o on u.user_id = o.user_id
group by u.user_id, u.name
order by u.name;

-- 3
select u.name, u.email
from orders o
right join  users u on o.user_id = u.user_id
where o.order_id is null;

-- 4
select
	u.name as user_name,
    p.name as product_name
from users u
left join orders o on u.user_id = o.user_id
left join products p on p.product_id = o.product_id
order by user_name, product_name;
