create index idx_items_item_name on items(item_name);

show index from items;

drop index idx_items_item_name on items;

explain select * from items where item_name = '게이밍 노트북';

create index idx_items_item_name on items(item_name);

explain select * from items where item_name = '게이밍 노트북';