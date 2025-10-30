-- 1
select
    name,
    category,
    case
        when category = "전자기기" then "Electronics"
        when category = "도서" then "Books"
        when category = "패션" then "Fashion"
        else 'Etc'
    end as categroy_english
from products

-- 2
select
	order_id,
    quantity,
    case
		when quantity >= 2 then '다량 주문'
        else '단일 주문'
	end as order_type
from orders
order by
	case
		when quantity >=2 then 1
        else 2
	end asc;

-- 3
select
	case
		when stock_quantity >= 50 then '재고 충분'
        when stock_quantity >= 20 then '재고 보통'
        else '재고 부족'
	end as stock_level,
    count(*) as product_count
from products
group by stock_level;

-- 4
select
	u.name,
    count(o.order_id) as total_orders,
    sum(case when p.category = '전자기기' then 1 else 0 end) as electoronics_orders,
    sum(case when p.category = '도서' then 1 else 0 end) as book_orders,
    sum(case when p.category = '패션' then 1 else 0 end) as fashion_orders
from users u
left join orders o on u.user_id = o.user_id
left join products p on o.product_id = p.product_id
group by u.name;