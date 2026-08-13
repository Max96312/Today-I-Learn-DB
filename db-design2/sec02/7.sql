DROP TABLE IF EXISTS common_code;

CREATE TABLE common_code (
 code VARCHAR(50) PRIMARY KEY,
 name VARCHAR(100) NOT NULL
);

INSERT INTO common_code (code, name) VALUES
('ORDER', '주문접수'),
('PAID', '결제완료'),
('SHIPPING', '배송중'),
('DELIVERED', '배송완료'),
('CANCEL', '주문취소');
SELECT * FROM common_code;

SELECT
 o.order_id,
 o.order_status,
 c.name AS order_status_name,
 o.total_amount
FROM orders o
JOIN common_code c ON o.order_status = c.code;

INSERT INTO common_code (code, name) VALUES
('NORMAL', '일반회원'),
('VIP', 'VIP회원'),
('VVIP', 'VVIP회원');
SELECT * FROM common_code;

-- INSERT INTO common_code (code, name) VALUES
-- ('CANCEL', '결제취소'); -- 주문취소와 코드가 중복!