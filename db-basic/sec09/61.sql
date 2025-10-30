explain select item_id, price, item_name from items where price between 50000 and 100000;

explain select item_id, price from items where price between 50000 and 100000;

drop index idx_items_price on items;

create index idx_items_price_name on items (price, item_name);

explain select item_id, price, item_name from items where price between 50000 and 100000;