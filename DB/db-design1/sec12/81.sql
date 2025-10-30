-- ## 쇼핑몰 기능 확인2

SELECT
    DATE_FORMAT(ordered_at, '%Y-%m') AS `year_month`,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM
    orders
WHERE
    order_status NOT IN ('CANCELED') -- 취소된 주문은 매출에서 제외
GROUP BY
    `year_month`
ORDER BY
    `year_month`;


-- 판매량 기준 TOP 5
SELECT
    oi.product_name,
    SUM(oi.order_quantity) AS total_quantity_sold,
    SUM(oi.order_price * oi.order_quantity) AS total_sales_amount
FROM
    order_item oi
JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status NOT IN ('CANCELED')
AND
    o.ordered_at BETWEEN '2025-08-01 00:00:00' AND '2025-09-30 23:59:59'
GROUP BY
    oi.product_name
ORDER BY
    total_quantity_sold DESC, total_sales_amount DESC
LIMIT 5;


SELECT
    m.member_id,
    m.member_name,
    m.email,
    SUM(o.total_amount) AS total_purchase_amount,
    COUNT(o.order_id) AS total_order_count
FROM
    member m
JOIN
    orders o ON m.member_id = o.member_id
WHERE
    o.order_status NOT IN ('CANCELED')
GROUP BY
    m.member_id, m.member_name, m.email
ORDER BY
    total_purchase_amount DESC
LIMIT 2;


SELECT
    product_id,
    product_name,
    stock_quantity
FROM
    product
WHERE
    stock_quantity < 50
ORDER BY
    stock_quantity ASC;

