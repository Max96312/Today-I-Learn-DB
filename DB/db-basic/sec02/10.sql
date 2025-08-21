select
	o.order_id,
	o.order_date,
    o.user_id as orders_user_id,
    u.user_id as users_user_id,
    u.name
from orders o
inner join users u on o.user_id = u.user_id
order by o.order_id;

select
	o.order_id,
	o.order_date,
    o.user_id as orders_user_id,
    u.user_id as users_user_id,
    u.name
from users u
inner join orders o on o.user_id = u.user_id
order by o.order_id;