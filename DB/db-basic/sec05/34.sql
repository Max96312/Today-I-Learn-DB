select u.name, u.email
from users u
join orders o on u.user_id = o.user_id
join products p on o.product_id = p.product_id
where p.category = '전자기기'
union
select name, email
from users
where address like "서울%";

select u.name, u.email
from users u
join orders o on u.user_id = o.user_id
join products p on o.product_id = p.product_id
where p.category = '전자기기'
union all
select name, email
from users
where address like "서울%";