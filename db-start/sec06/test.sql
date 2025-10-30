-- 1
select
	name,
    price,
    price * 0.85 as sale_price
from products;

-- 2
select
    concat_ws(' - ', name, address) as customer_info
from customers;

-- 3
select
	name,
    coalesce(description, name) as product_display_info
from products;

-- 4
select
	name,
    coalesce(description, name, '정보 없음') as display_text
from products;

-- 5
select
	email,
    substring_index(email, '@', 1) as user_id,
    char_length(substring_index(email, '@', 1)) as id_length
from customers;