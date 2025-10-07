-- ## 자연 키 vs 대리 키3 - 성능 트레이드 오프

SELECT order_id, member_email, ordered_at FROM orders_n;

SELECT
    o.order_id,
    m.email AS member_email,
    o.ordered_at
FROM orders_s o
JOIN member_s m ON o.member_id = m.member_id;

select * from orders_n where member_email like 'member1%';

SELECT
    o.order_id,
    m.email AS member_email,
    o.ordered_at
FROM orders_s o
JOIN member_s m ON o.member_id = m.member_id
where m.email like 'member1%';

-- 주문 ID 100번에 대한 회원의 email을 확인하려면 JOIN이 필수다.
SELECT m.email
  FROM orders o
  JOIN member m ON o.member_id = m.member_id
WHERE o.order_id = 100;

-- member 테이블에는 2개의 인덱스가 필요하다.
-- 1. 기본 키(PK) 인덱스: member_id
-- 2. 고유(UNIQUE) 인덱스: email
CREATE TABLE member (
    member_id BIGINT NOT NULL AUTO_INCREMENT,
    email  VARCHAR(50) NOT NULL,
    ...
    PRIMARY KEY (member_id),
    UNIQUE KEY uq_email (email)
);
