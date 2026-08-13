-- 데이터베이스가 존재하지 않으면 생성
CREATE DATABASE IF NOT EXISTS my_shop4;
USE my_shop4;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
 order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 member_id BIGINT NOT NULL,
 order_status VARCHAR(20) NOT NULL,
 total_amount INT NOT NULL,
 created_at DATETIME NOT NULL
);

INSERT INTO orders (member_id, order_status, total_amount, created_at) VALUES
(1, '주문완료', 50000, '2026-01-15 10:30:00'),
(2, '결제완료', 75000, '2026-01-15 11:00:00'),
(3, '배송중', 30000, '2026-01-15 12:00:00'),
(1, '배송완료', 120000, '2026-01-14 09:00:00'),
(4, '주문취소', 45000, '2026-01-13 15:00:00');
SELECT * FROM orders;

INSERT INTO orders (member_id, order_status, total_amount, created_at) VALUES
(5, '주문 완료', 80000, '2026-01-16 10:00:00'),
(6, 'ORDER_COMPLETE', 65000, '2026-01-16 11:00:00');
SELECT * FROM orders;

SELECT * FROM orders WHERE order_status = '주문완료';

INSERT INTO orders (member_id, order_status, total_amount, created_at) VALUES
(7, '배송증', 55000, '2026-01-17 09:00:00'); -- '배송중'을 '배송증'으로 오타

SET SQL_SAFE_UPDATES = 0; -- 안전 업데이트 모드 끄기

UPDATE orders SET order_status = '주문성공' WHERE order_status = '주문완료';

SET SQL_SAFE_UPDATES = 1; -- 안전 업데이트 모드 활성화

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
 order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 member_id BIGINT NOT NULL,
 order_status VARCHAR(20) NOT NULL,
 total_amount INT NOT NULL,
 created_at DATETIME NOT NULL
);

INSERT INTO orders (member_id, order_status, total_amount, created_at) VALUES
(1, 'ORDER', 50000, '2026-01-15 10:30:00'),
(2, 'PAID', 75000, '2026-01-15 11:00:00'),
(3, 'SHIPPING', 30000, '2026-01-15 12:00:00'),
(1, 'DELIVERED', 120000, '2026-01-14 09:00:00'),
(4, 'CANCEL', 45000, '2026-01-13 15:00:00');

SELECT * FROM orders;