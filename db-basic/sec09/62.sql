show index from items;

DROP INDEX idx_items_item_name ON items;
DROP INDEX idx_items_price_name ON items;
DROP INDEX idx_items_price ON items;
DROP INDEX idx_items_price_category_temp ON items;
DROP INDEX idx_items_category_price ON items;

create index idx_items_category_price on items(category, price);

explain select * from items where category = '전자기기';

explain select * from items where category = '전자기기' and price = 120000;

explain select * from items where category = '전자기기' and price > 100000;

explain select * from items where category = '전자기기' and price = 120000
order by price;