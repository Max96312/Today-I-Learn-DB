-- 카테고리별 주문 건수
select
	category,
	count(*) as `카테고리별 주문 건수`
from
	order_stat
group by
	category;

-- 고객별로 총 몇번이나 주문했을까?
select
	customer_name,
    count(*) as `주문 횟수`
from
	order_stat
group by
	customer_name;

select
	customer_name,
    count(*) as `주문 횟수`,
    sum(quantity) as `총 구매 수량`,
    sum(price * quantity) as `총 구매 금액`
from
	order_stat
group by
	customer_name
order by
	`총 구매 금액` desc;

--
select
	customer_name,
    category,
    sum(price * quantity) as `카테고리별 구매 금액`
from
	order_stat
group by
	customer_name, category
order by
	customer_name, `카테고리별 구매 금액` desc;