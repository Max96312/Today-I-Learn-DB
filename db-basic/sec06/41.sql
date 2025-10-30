select
	(select count(*) from orders) as total_orders,
    (select count(*) from orders where status = 'COMPLETED') as completed_count,
    (select count(*) from orders where status = 'SHIPPED') as shipped_count,
    (select count(*) from orders where status = 'PENDING') as pending_count