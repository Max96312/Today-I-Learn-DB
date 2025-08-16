select * from customers
where email = 'yisunsin@example.com';

select * from products
where price >= 10000;

select * from products
where price >= 5000 and stock_quantity >= 50;

select * from products
where price = 20000 or stock_quantity >= 100;

select * from products
where price != 20000;