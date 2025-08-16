select distinct customer_id from orders;

select customer_id, product_id from orders
order by customer_id, product_id;

select distinct customer_id, product_id from orders
order by customer_id, product_id;