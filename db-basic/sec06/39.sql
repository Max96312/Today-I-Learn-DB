select
    name,
    price,
    case
        when price >= 100000 then '고가'
        when price >= 30000 then '중가'
        else '저가'
    end as price_label
from
    products
order by
    case
        when price >= 100000 then 1
        when price >= 30000 then 2
        else 3
    end,
    price desc
;