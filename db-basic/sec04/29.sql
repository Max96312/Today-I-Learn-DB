select *
from products p
join (
	select category, max(price)  as max_price
	from products
	group by category) as cmp
on p.category = cmp.category and p.price = cmp.max_price;