-- between
select * from products
where price between 5000 and 15000;

-- not between
select * from products
where price < 5000 or price > 15000;

select * from products
where price not between 5000 and 15000;

-- where - in
select * from products
where name = '갤럭시' or name = '아이폰' or name = '에어팟';

select * from products
where name in ('갤럭시', '아이폰', '에어팟');

-- where - not in
select * from products
where name != '갤럭시' and name != '아이폰' and name != '에어팟';

select * from products
where name not in ('갤럭시', '아이폰', '에어팟');

-- like
select * from customers where email = 'sejong';

select * from customers where email like 'sejong%';
select * from customers where email like '%example.com';

select * from customers where address like '서울특별시%';
select * from customers where address not like '서울특별시%';