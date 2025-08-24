-- 1
select product_id, name, price
from products
where price = (select max(price) from products);

-- 2
select order_id, user_id, order_date
from orders
where product_id = (select product_id from orders where order_id = 1) and order_id != 1;

-- 3
select
	name as `고객명`,
    (
		select count(*)
		from orders o
		where o.user_id = u.user_id
	) as `총주문횟수`
from users u
order by u.user_id;