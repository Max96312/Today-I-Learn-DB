-- 1
select
	count(*) as `총  구문 건수`,
    count(category) as `카테고리 보유 건수`
from
	order_stat;

-- 2
select
    sum(price * quantity) as `총 매출액`,
    avg(price * quantity) as `평균 주문 금액`,
    max(price) as `최고 단가`,
    min(price) as `최저 단가`
from
    order_stat;

-- 3
select
    category,
    sum(quantity) as `카테고리별 총 판매 수량`,
    sum(price * quantity) as `카테고리별 총 매출액`
from
    order_stat
group by
    category
order by
    `카테고리별 총 매출액` desc;

-- 4
select
    customer_name,
    count(*) as `총 주문 횟수`,
    sum(quantity) as `총 구매 수량`
from
    order_stat
group by
    customer_name
order by
    `총 주문 횟수` desc, `총 구매 수량` desc;

-- 5
select
    customer_name,
    sum(price * quantity) as `총 구매 금액`
from
    order_stat
group by
    customer_name
having
    sum(price * quantity) >= 400000
order by
    `총 구매 금액` desc;

-- 6
SELECT
    customer_name,
    count(*) as `주문 횟수`,
    sum(quantity * price) as `총 사용 금액`
from
    order_stat
where
    category != "도서" or category is null
group by
    customer_name
having
    count(*) >= 2
order by
    `총 사용 금액` desc;