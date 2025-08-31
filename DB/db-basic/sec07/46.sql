CREATE VIEW v_category_order_status AS
select
	p.category,
    count(*) as total_orders,
    sum(case when status = 'COMPLETED' then 1 else 0 end) as completed_count,
    sum(case when status = 'SHIPPED' then 1 else 0 end) as shipped_count,
    sum(case when status = 'PENDING' then 1 else 0 end) as pending_count
from
    orders o
join products p on o.product_id = p.product_id
group by p.category;

select * from v_category_order_status;

alter view v_category_order_status as
select
	p.category,
    sum(p.price * o.quantity) as total_sales,
    count(*) as total_orders,
    sum(case when status = 'COMPLETED' then 1 else 0 end) as completed_count,
    sum(case when status = 'SHIPPED' then 1 else 0 end) as shipped_count,
    sum(case when status = 'PENDING' then 1 else 0 end) as pending_count
from
    orders o
join products p on o.product_id = p.product_id
group by p.category;

select * from v_category_order_status;