DROP TABLE IF EXISTS common_code;
DROP TABLE IF EXISTS common_code_detail;
DROP TABLE IF EXISTS common_code_group;

-- 그룹 코드 테이블
CREATE TABLE common_code_group (
 group_code VARCHAR(50) PRIMARY KEY,
 group_name VARCHAR(100) NOT NULL,
 description VARCHAR(500),
 use_yn CHAR(1) NOT NULL DEFAULT 'Y',
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 상세 코드 테이블
CREATE TABLE common_code_detail (
 group_code VARCHAR(50) NOT NULL,
 code VARCHAR(50) NOT NULL,
 name VARCHAR(100) NOT NULL,
 description VARCHAR(500),
 sort_order INT NOT NULL DEFAULT 0,
 use_yn CHAR(1) NOT NULL DEFAULT 'Y',
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (group_code, code),
 FOREIGN KEY (group_code) REFERENCES common_code_group(group_code)
);

-- 그룹 코드 입력
INSERT INTO common_code_group (group_code, group_name, description) VALUES
('ORDER_STATUS', '주문상태', '주문의 진행 상태를 나타내는 코드'),
('MEMBER_GRADE', '회원등급', '회원의 등급을 나타내는 코드'),
('PAYMENT_STATUS', '결제상태', '결제의 진행 상태를 나타내는 코드'),
('PAYMENT_METHOD', '결제수단', '결제 방법을 나타내는 코드');

-- 상세 코드 입력
INSERT INTO common_code_detail (group_code, code, name, sort_order) VALUES
-- 주문 상태
('ORDER_STATUS', 'ORDER', '주문접수', 1),
('ORDER_STATUS', 'PAID', '결제완료', 2),
('ORDER_STATUS', 'SHIPPING', '배송중', 3),
('ORDER_STATUS', 'DELIVERED', '배송완료', 4),
('ORDER_STATUS', 'CANCEL', '주문취소', 5),
-- 회원 등급
('MEMBER_GRADE', 'NORMAL', '일반회원', 1),
('MEMBER_GRADE', 'VIP', 'VIP회원', 2),
('MEMBER_GRADE', 'VVIP', 'VVIP회원', 3),
-- 결제 상태
('PAYMENT_STATUS', 'PENDING', '결제대기', 1),
('PAYMENT_STATUS', 'COMPLETE', '결제완료', 2),
('PAYMENT_STATUS', 'FAILED', '결제실패', 3),
('PAYMENT_STATUS', 'CANCEL', '결제취소', 4),
('PAYMENT_STATUS', 'REFUND', '환불완료', 5),
-- 결제 수단
('PAYMENT_METHOD', 'CARD', '신용카드', 1),
('PAYMENT_METHOD', 'BANK', '계좌이체', 2),
('PAYMENT_METHOD', 'VIRTUAL', '가상계좌', 3),
('PAYMENT_METHOD', 'MOBILE', '휴대폰결제', 4);

SELECT * FROM common_code_detail ORDER BY group_code, sort_order;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS members;

-- 회원 테이블
CREATE TABLE members (
 member_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(50) NOT NULL,
 email VARCHAR(100) NOT NULL,
 grade VARCHAR(20) NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 주문 테이블
CREATE TABLE orders (
 order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 member_id BIGINT NOT NULL,
 order_status VARCHAR(20) NOT NULL DEFAULT 'ORDER',
 total_amount INT NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- 결제 테이블
CREATE TABLE payments (
 payment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 order_id BIGINT NOT NULL,
 payment_method VARCHAR(20) NOT NULL,
 payment_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
 amount INT NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 회원 데이터
INSERT INTO members (name, email, grade) VALUES
('션', 'seon@example.com', 'NORMAL'),
('네이트', 'nate@example.com', 'VIP'),
('이순신', 'lee@example.com', 'VVIP');

-- 주문 데이터
INSERT INTO orders (member_id, order_status, total_amount) VALUES
(1, 'ORDER', 50000),
(1, 'PAID', 75000),
(2, 'SHIPPING', 120000),
(2, 'DELIVERED', 85000),
(3, 'CANCEL', 45000);

-- 결제 데이터
INSERT INTO payments (order_id, payment_method, payment_status, amount) VALUES
(1, 'CARD', 'PENDING', 50000),
(2, 'CARD', 'COMPLETE', 75000),
(3, 'BANK', 'COMPLETE', 120000),
(4, 'MOBILE', 'COMPLETE', 85000),
(5, 'CARD', 'CANCEL', 45000);

SELECT
 m.member_id,
 m.name,
 m.email,
 m.grade,
 c.name AS grade_name
FROM members m
JOIN common_code_detail c
 ON c.group_code = 'MEMBER_GRADE' AND m.grade = c.code
ORDER BY m.member_id;

SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 c.name AS status_name,
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
JOIN common_code_detail c
 ON c.group_code = 'ORDER_STATUS' AND o.order_status = c.code
ORDER BY o.order_id;

SELECT
 p.payment_id,
 o.order_id,
 p.payment_method,
 pm.name AS method_name,
 p.payment_status,
 ps.name AS status_name,
 p.amount
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN common_code_detail pm
 ON pm.group_code = 'PAYMENT_METHOD' AND p.payment_method = pm.code
JOIN common_code_detail ps
 ON ps.group_code = 'PAYMENT_STATUS' AND p.payment_status = ps.code
ORDER BY p.payment_id;

-- 주문 상태 목록 조회
SELECT code, name
FROM common_code_detail
WHERE group_code = 'ORDER_STATUS'
 AND use_yn = 'Y'
ORDER BY sort_order;

-- 결제 수단 목록 조회
SELECT code, name
FROM common_code_detail
WHERE group_code = 'PAYMENT_METHOD'
 AND use_yn = 'Y'
ORDER BY sort_order;

UPDATE common_code_detail
SET use_yn = 'N'
WHERE group_code = 'PAYMENT_METHOD' AND code = 'VIRTUAL';

-- 결제 수단 목록 다시 조회
SELECT code, name
FROM common_code_detail
WHERE group_code = 'PAYMENT_METHOD'
 AND use_yn = 'Y'
ORDER BY sort_order;