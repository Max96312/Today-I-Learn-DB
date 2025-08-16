-- 1
select name AS 상품명, price AS 판매가
from products;

-- 2
select * from customers
where name = '장영실';

-- 3
select * from products
where price >= 10000 and stock_quantity < 50;

-- 4
select name, price from products
where product_id in (2, 3, 4);

-- 5
select name, address
from customers
where address like "서울특별시%"

-- 6
select * from products
where description is null;

-- 7
select * from products
order by price desc;

-- 8
select * from products
order by price, stock_quantity desc;

-- 9
select * from customers
order by join_date desc
limit 2;

-- 10
select distinct customer_id, product_id
from orders

-- 11
select name as "상품 이름",
    stock_quantity as "남은 수량"
from products
where price > 3000 and stock_quantity <= 100
order by stock_quantity desc
limit 3;