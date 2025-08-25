select
    order_id,
    user_id,
    product_id,
    quantity,
    status,
    case status
        when 'PENDING' then '주문 대기'
        when 'COMPLETED' then '결제 완료'
        when 'SHIPPED' then '배송'
        when 'CANCELLED' then '주문 취소'
        else '알 수 없음'
    end as status_korean
from
    orders;

select
    name,
    price,
    case
        when price >= 100000 then '고가'
        when price >= 30000 then '중가'
        else '저가'
    end as price_label
from
    products;