-- 1단계: 주문 목록 조회 (공통 코드 조인 없음)
SELECT
 o.order_id,
 m.name AS member_name,
 m.grade,
 o.order_status,
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
ORDER BY o.order_id;

-- 2단계: 주문 상태 코드 목록 조회
SELECT code, name
FROM common_code_detail
WHERE group_code = 'ORDER_STATUS';

-- 주문 목록에서 사용된 상태 코드들을 한 번에 조회
SELECT code, name
FROM common_code_detail
WHERE group_code = 'ORDER_STATUS'
 AND code IN ('ORDER', 'PAID', 'SHIPPING', 'DELIVERED', 'CANCEL');