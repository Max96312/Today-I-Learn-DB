select
	name,
    description
from products;

select
	name,
    ifnull(description, '상품 설명 없음') as description
from products;

select
	name,
    coalesce(description, '상품 설명 없음') as description
from products;