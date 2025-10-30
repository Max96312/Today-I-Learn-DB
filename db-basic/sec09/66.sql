explain select
	s.seller_name,
    i.item_name,
    i.price
from items i
join sellers s on i.seller_id = s.seller_id
where s.seller_name = '행복쇼핑';

show index from sellers;