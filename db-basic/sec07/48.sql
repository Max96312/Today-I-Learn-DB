-- 1
create view v_customer_email_list as
select
    user_id,
    name as 고객명,
    email as 이메일
from users;

-- 2
select
	o.order_id,
    u.name as '고객명',
    p.name as '상품명',
    o.quantity as '주문수량',
    o.status as '주문상태'
from users u
join orders o on o.user_id = u.user_id
join products p on p.product_id = o.product_id;

-- 3
create view `v_electronics_sales_status` as
select
	p.category,
    count(o.order_id) as 'total_orders',
    sum(o.quantity * p.price) as 'total_sales'
from products p
join orders o on o.product_id = p.product_id
group by p.category
having p.category = '전자기기';

-- 4
alter view `v_electronics_sales_status` as
select
	p.category,
    count(o.order_id) as 'total_orders',
    sum(o.quantity * p.price) as 'total_sales',
    avg(o.quantity * p.price) as 'average\_order\_value'
from products p
join orders o on o.product_id = p.product_id
group by p.category
having p.category = '전자기기';

select * from v_electronics_sales_status;