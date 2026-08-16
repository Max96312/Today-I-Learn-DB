DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS common_code_attribute; -- 복습시 문제가 되는 테이블 제거
DROP TABLE IF EXISTS common_code_detail;
DROP TABLE IF EXISTS common_code_group;

-- 그룹 코드 테이블
CREATE TABLE common_code_group (  group_code VARCHAR(50) PRIMARY KEY,
 group_name VARCHAR(100) NOT NULL
);

-- 상세 코드 테이블
CREATE TABLE common_code_detail (
 group_code VARCHAR(50) NOT NULL,
 code VARCHAR(50) NOT NULL,
 name VARCHAR(100) NOT NULL,
 sort_order INT NOT NULL DEFAULT 0,
 use_yn CHAR(1) NOT NULL DEFAULT 'Y',
 PRIMARY KEY (group_code, code),
 FOREIGN KEY (group_code) REFERENCES common_code_group(group_code)
);

-- 회원 테이블
CREATE TABLE members (
 member_id BIGINT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(50) NOT NULL,
 email VARCHAR(100) NOT NULL,
 grade VARCHAR(20) NOT NULL DEFAULT 'NORMAL'
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
 FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 공통 코드 데이터
INSERT INTO common_code_group (group_code, group_name) VALUES
('ORDER_STATUS', '주문상태'),
('MEMBER_GRADE', '회원등급'),
('PAYMENT_STATUS', '결제상태'),
('PAYMENT_METHOD', '결제수단');

INSERT INTO common_code_detail (group_code, code, name, sort_order) VALUES
('ORDER_STATUS', 'ORDER', '주문접수', 1),
('ORDER_STATUS', 'PAID', '결제완료', 2),
('ORDER_STATUS', 'SHIPPING', '배송중', 3),
('ORDER_STATUS', 'DELIVERED', '배송완료', 4),
('ORDER_STATUS', 'CANCEL', '주문취소', 5),
('MEMBER_GRADE', 'NORMAL', '일반회원', 1),
('MEMBER_GRADE', 'VIP', 'VIP회원', 2),
('MEMBER_GRADE', 'VVIP', 'VVIP회원', 3),
('PAYMENT_STATUS', 'PENDING', '결제대기', 1),
('PAYMENT_STATUS', 'COMPLETE', '결제완료', 2),
('PAYMENT_STATUS', 'FAILED', '결제실패', 3),
('PAYMENT_STATUS', 'CANCEL', '결제취소', 4),
('PAYMENT_METHOD', 'CARD', '신용카드', 1),
('PAYMENT_METHOD', 'BANK', '계좌이체', 2),
('PAYMENT_METHOD', 'MOBILE', '휴대폰결제', 3);

-- 테스트 데이터
INSERT INTO members (name, email, grade) VALUES
('션', 'seon@example.com', 'NORMAL'),
('네이트', 'nate@example.com', 'VIP'),
('이순신', 'lee@example.com', 'VVIP');

INSERT INTO orders (member_id, order_status, total_amount, created_at) VALUES
(1, 'ORDER', 50000, '2026-01-15 10:00:00'),
(1, 'PAID', 75000, '2026-01-15 11:00:00'),
(2, 'SHIPPING', 120000, '2026-01-16 09:00:00'),
(2, 'DELIVERED', 85000, '2026-01-14 15:00:00'),
(3, 'CANCEL', 45000, '2026-01-13 14:00:00');

INSERT INTO payments (order_id, payment_method, payment_status, amount) VALUES
(1, 'CARD', 'PENDING', 50000),
(2, 'CARD', 'COMPLETE', 75000),
(3, 'BANK', 'COMPLETE', 120000),
(4, 'MOBILE', 'COMPLETE', 85000),
(5, 'CARD', 'CANCEL', 45000);

-- 공통 코드 없이 단순 조회
SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
ORDER BY o.order_id;

-- 공통 코드와 조인하여 조회
SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 os.name AS order_status_name,
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
ORDER BY o.order_id;

-- 회원 등급까지 조인
SELECT
 o.order_id,
 m.name AS member_name,
 m.grade,
 mg.name AS grade_name,
 o.order_status,
 os.name AS order_status_name,
 o.total_amount
FROM orders o
JOIN members m
 ON o.member_id = m.member_id
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
JOIN common_code_detail mg
 ON mg.group_code = 'MEMBER_GRADE' AND m.grade = mg.code
ORDER BY o.order_id;

-- 결제 정보까지 모두 조인
SELECT
 o.order_id,
 m.name AS member_name,
 m.grade,
 mg.name AS grade_name,
 o.order_status,
 os.name AS order_status_name,
 o.total_amount,
 p.payment_method,
 pm.name AS payment_method_name,
 p.payment_status,
 ps.name AS payment_status_name,
 p.amount AS payment_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
JOIN payments p ON o.order_id = p.order_id
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
JOIN common_code_detail mg
 ON mg.group_code = 'MEMBER_GRADE' AND m.grade = mg.code
JOIN common_code_detail pm
 ON pm.group_code = 'PAYMENT_METHOD' AND p.payment_method = pm.code
JOIN common_code_detail ps
 ON ps.group_code = 'PAYMENT_STATUS' AND p.payment_status = ps.code
ORDER BY o.order_id;

-- 관리자용 주문 목록 조회
SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 os.name AS order_status_name, -- 중복!
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
JOIN common_code_detail os 
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
ORDER BY o.created_at DESC;

-- 사용자 마이페이지용 주문 목록 조회
SELECT
 o.order_id,
 o.order_status,
 os.name AS order_status_name, -- 중복!
 o.total_amount
FROM orders o
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
WHERE o.member_id = 1
ORDER BY o.created_at DESC;

-- 배송중인 주문 목록 조회
SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 os.name AS order_status_name, -- 중복!
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
WHERE o.order_status = 'SHIPPING';

-- 코드값만 구하는 SQL
SELECT
 o.order_id,
 o.order_status
FROM orders o
WHERE o.order_status IN ('ORDER', 'PAID');

-- 코드값과 코드 이름을 모두 구하는 SQL
SELECT
 o.order_id,
 o.order_status,
 os.name AS order_status_name -- 상황에 따라 필요하지 않을 수 있음
FROM orders o
JOIN common_code_detail os
 ON os.group_code = 'ORDER_STATUS' AND o.order_status = os.code
WHERE o.order_status IN ('ORDER', 'PAID');

SELECT
 o.order_id,
 m.name AS member_name,
 o.order_status,
 (SELECT name FROM common_code_detail
 WHERE group_code = 'ORDER_STATUS' AND code = o.order_status) AS
order_status_name,
 m.grade,
 (SELECT name FROM common_code_detail
 WHERE group_code = 'MEMBER_GRADE' AND code = m.grade) AS grade_name,
 o.total_amount
FROM orders o
JOIN members m ON o.member_id = m.member_id
ORDER BY o.order_id;