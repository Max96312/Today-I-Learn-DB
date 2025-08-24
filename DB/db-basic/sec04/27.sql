select product_id, name, price
from products
where product_id in (select distinct product_id from orders);

-- EXISTS를 사용한 더 효율적인 방법
select product_id, name, price
from products p
where exists (select 1
				from orders o
                where o.product_id = p.product_id);

select product_id, name, price
from products p
where not exists (select 1
				from orders o
                where o.product_id = p.product_id);