-- 1
select
	e.employee_id,
    e.name,
    e.manager_id,
    m.name as manager_name
from employees e
join employees m on m.employee_id = e.employee_id
where e.manager_id = 4;

-- 2
create table materials(
	material varchar(20));

insert into materials
values
	("Cotton"),
	("Slik");

select
    concat('기본티셔츠-' , c.color, '-', s.size, '-', m.material),
    s.size,
    c.color,
    m.material
from sizes s
cross join colors c
cross join materials m;

-- 3
select
	u.name as customer_name,
    p.name as product_name,
    o.order_date,
    o.quantity
from users u
join orders o on o.user_id = u.user_id
join products p on p.product_id = o.product_id
where u.name = "네이트"
order by o.order_date desc;

-- 4
select
	u.name as customer_name,
    sum(p.price * o.quantity) as total_spent
from users u
join orders o on o.user_id = u.user_id
join products p on p.product_id = o.product_id
where u.address like "서울시%"
group by u.user_id, u.name
order by total_spent desc;