select
	u.user_id,
    u.name,
    o.user_id,
    o.order_id
from users u
left join orders o on u.user_id = o.user_id
order by u.user_id;

select
	u.user_id,
    u.name,
    u.email,
    o.order_id
from users u
left join orders o on u.user_id = o.user_id
where o.order_id is null;