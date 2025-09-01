explain select * from items where price between 50000 and 100000;

create index idx_items_price on items(price);

explain select * from items where price between 50000 and 100000;

select * from items where price between 50000 and 100000;