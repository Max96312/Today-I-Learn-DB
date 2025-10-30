DROP TABLE IF EXISTS orders_3nf;
DROP TABLE IF EXISTS member_3nf;

-- 1. member 테이블 생성 (회원 정보)
CREATE TABLE member_3nf (
    member_id INT NOT NULL,
    member_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (member_id)
);

-- 2. orders 테이블 생성 (주문 정보, member_name 제거)
CREATE TABLE orders_3nf (
    order_id   INT NOT NULL,
    member_id  INT NOT NULL,
    ordered_at DATETIME NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (member_id) REFERENCES member_3nf (member_id)
);

-- member_3nf 데이터 삽입 (회원 정보는 이제 중복 없이 한 번만 저장된다)
INSERT INTO member_3nf (member_id, member_name) VALUES
(1, '션'),
(2, '네이트');

-- orders_3nf 데이터 삽입
INSERT INTO orders_3nf (order_id, member_id, ordered_at) VALUES
(1001, 1, '2025-08-20 10:00:00'),
(1002, 2, '2025-08-21 11:00:00'),
(1003, 1, '2025-08-21 12:00:00');


SELECT * FROM member_3nf;

SELECT * FROM orders_3nf;