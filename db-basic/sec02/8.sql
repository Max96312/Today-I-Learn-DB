select *
from orders
inner join users
on orders.user_id = users.user_id;

select
  users.user_id,
  users.name,
  orders.order_date
from orders
inner join users
on orders.user_id = users.user_id
where orders.status = 'COMPLETED';