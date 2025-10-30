-- 1
select name, email from users
union
select name, email from retired_users;

-- 2
select u.name as 고객명, u.email as 이메일
from users u
join orders o on o.user_id = u.user_id
join products p on p.product_id = o.product_id
where p.category = '전자기기'
union all
select distinct u.name as 고객명, u.email as 이메일
from users u
join orders o on o.user_id = u.user_id
where o.quantity >= 2;

-- 3
select
	created_at as 이벤트_날짜,
    '고객 가입' as 이벤트_종류,
    name as 상세_내용
from users
union all
select
	order_date as 이벤트_날짜,
    '상품 주문' as 벤트_종류,
    p.name as 상세_내용
from orders o
join products p on p.product_id = o.order_id
order by 이벤트_날짜 desc;


-- 4
select
	e.name as 이름,
    '직원' as 역할,
    concat(e.name , '@my-shop.com') as 이메일
from employees e
join employees m on m.manager_id = e.employee_id
union all
select
	name as 이름,
    '고객' as 역할,
    email as 이메일
from users
order by 이름;