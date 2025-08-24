-- 비상관 서브쿼리
select
	name,
    price,
    (select avg(price) from products)
from products;

-- 상관 서브쿼리
select
	p.product_id,
    p.name,
    p.price,
    (select count(*) from orders o where o.product_id = p.product_id) as order_count
from products p;

-- JOIN으로 해결하는 방법
SELECT p.product_id, p.name, p.price, COUNT(o.order_id) AS order_count
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.name, p.price;