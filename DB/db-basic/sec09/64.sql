create index idx_items_price_category_temp on items(price, category);

explain select * from items where category >= '패션' and price = 20000;

drop index idx_items_price_category_temp on items;

explain select * from items where category >= '패션' and price = 20000;

show index from items;

explain select * from items where category in ('패션', '헬스/뷰티') and price = 20000;