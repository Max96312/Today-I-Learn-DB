select
	o.order_id,
    o.product_id,
    o.user_id as orders_user_id,
    u.user_id as users_user_id,
    u.name,
    u.email
from orders o
join users u on o.user_id = u.user_id
where o.user_id = 1;

select
	u.user_id as users_user_id,
    u.name,
    u.email,
	o.order_id,
    o.product_id,
    o.user_id as orders_user_id
from users u
join orders o on u.user_id = o.user_id
where u.user_id = 1;

select
	o.order_id,
    o.product_id,
    o.user_id as orders_user_id,
    u.user_id as users_user_id,
    u.name,
    u.email
from orders o
join users u on o.user_id = u.user_id
where o.user_id = 1;

select
	u.user_id as users_user_id,
    u.name,
    u.email,
	o.order_id,
    o.product_id,
    o.user_id as orders_user_id
from users u
join orders o on u.user_id = o.user_id
where u.user_id = 1;