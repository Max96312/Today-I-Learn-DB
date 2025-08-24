select * from orders
where product_id in (
	select product_id
    from products
    where category = '전자기기')
order by order_id;


-- any
select name, price
from products
where price > any (
	select price from products where category = '전자기기');

select name, price
from products
where price >  (
	select min(price) from products where category = '전자기기');

-- all
select name, price
from products
where price > all (
	select price from products where category = '전자기기');

select name, price
from products
where price > (
	select max(price) from products where category = '전자기기');