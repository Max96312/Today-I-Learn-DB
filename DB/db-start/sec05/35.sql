select * from products
where description = null;

select * from products
where description is null;

select * from products
where description is not null;

select * from products
order by description asc;

select * from products
order by description desc;

-- NULL 위치를 강제로 바꾸고 싶을 때
select product_id, name, description, description is null from products
order by description is null desc, description desc;

select product_id, name, description from products
order by (description is null) desc, description desc;