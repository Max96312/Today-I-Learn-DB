select product_id, name, category, price
from products p1
where price >= (select avg(price)
                from products p2
                where p2.category = p1.category);