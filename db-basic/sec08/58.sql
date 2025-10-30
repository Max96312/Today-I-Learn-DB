explain select * from items
order by stock_quantity;

select * from items where price between 50000 and 100000
order by price;

explain select * from items where price between 50000 and 100000
order by price;

select * from items where price between 50000 and 100000;

explain select * from items where price between 50000 and 100000;

explain select * from items where price between 50000 and 100000
order by price desc;

-- 내림차순 인덱스
drop index idx_items_price on items;
create index idx_items_price_desc on items(price DESC);

select * from items where price between 50000 and 100000;

explain select * from items where price between 50000 and 100000
order by price desc;

drop index idx_items_price_desc on items;
create index idx_items_price on items(price);