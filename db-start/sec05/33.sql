select * from products order by price desc limit 2;

-- 1페이지
select * from products
limit 0, 2;

-- 2페이지
select * from products
limit 2, 2;

-- 3페이지
select * from products
limit 4, 2;

-- offset = (페이지번호 - 1) * 페이지당_게시물수`