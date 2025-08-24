select *
from users
where address = (
	select u.address
	from orders o
	join users u on u.user_id = o.user_id
	where o.order_id = 1)