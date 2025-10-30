select
	orders.order_id,
	orders.order_date,
    orders.user_id as orders_user_id,
    users.user_id as users_user_id,
    users.name
from orders
inner join users on orders.user_id = users.user_id
order by orders.order_id;

select
	orders.order_id,
	orders.order_date,
    orders.user_id as orders_user_id,
    users.user_id as users_user_id,
    users.name
from users
inner join orders on orders.user_id = users.user_id
order by orders.order_id;