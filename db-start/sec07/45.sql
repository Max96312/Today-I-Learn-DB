-- count()
select count(*)
from order_stat;

select count(category)
from order_stat;

select
	count(*) as `전체 주문 건수`,
	count(category) as `카테고리 등록 건수`
from order_stat;

-- sum(), avg()
select
	sum(price * quantity) as `총 매출액`,
    avg(price * quantity) as `평균 주문 금액`
from order_stat;

select
	sum(quantity) as `총 매출 수량`,
    avg(quantity) as `주문당 평균 수량`
from order_stat;

-- max(), min()
select
	max(price) as 최고가,
    min(price) as 최저가
from order_stat;

select
	max(order_date) as `최근 주문일`,
    min(order_date) as `최초 주문일`
from order_stat;

-- count([distinct] 칼럼명)
select
	count(customer_name) as `총 주문  건수`,
	count(distinct customer_name) as `순수 고객 수`
from order_stat;