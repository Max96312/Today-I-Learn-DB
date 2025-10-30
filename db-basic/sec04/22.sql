select name, price
from products
where price > (
	select avg(price)
	from products);