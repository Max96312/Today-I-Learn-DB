select o.order_id, o.user_id, o.product_id, o.order_date
from orders o
where o.user_id in (
	select user_id
	from users
	where address like '서울%');
    
select o.order_id, o.user_id, o.product_id, o.order_date
from orders o
join users u on o.user_id = u.user_id
where u.address like '서울%';