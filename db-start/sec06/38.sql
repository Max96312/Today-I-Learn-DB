select name, price, stock_quantity, price * stock_quantity
from products;

select
	name,
	price,
	stock_quantity,
    price * stock_quantity as total_stock_value
from products;

select
	name,
	price,
	stock_quantity,
    price + 3000 as expected_price
from products;

select
	name,
	price,
	stock_quantity,
    price - 1000 as discounted_price
from products;


select
	name,
	price,
	stock_quantity,
    price / 10 as monthly_payment
from products;