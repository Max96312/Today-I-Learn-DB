-- ## 제1 정규형

DROP TABLE IF EXISTS orders_1nf_violating;

-- 제1 정규형을 위반하는 테이블 생성
CREATE TABLE orders_1nf_violating (
    order_id INT NOT NULL,
    ordered_at DATETIME NOT NULL,
    member_id INT NOT NULL,
    member_name VARCHAR(50) NOT NULL,
    product_infos VARCHAR(255) NOT NULL -- 이 컬럼이 원자성을 위반한다.
);

-- 데이터 삽입
INSERT INTO orders_1nf_violating (order_id, ordered_at, member_id, member_name, product_infos) VALUES
(1001, '2025-08-20 10:00:00', 1, '션', '10:노트북:2:1500000,15:키보드:1:50000'),
(1002, '2025-08-21 11:00:00', 2, '네이트', '10:노트북:1:1500000'),
(1003, '2025-08-21 12:00:00', 1, '션', '20:마우스:1:30000');

SELECT * FROM orders_1nf_violating;

DROP TABLE IF EXISTS orders_1nf;

-- 제1 정규형을 만족하는 테이블 생성
CREATE TABLE orders_1nf (
    order_id       INT NOT NULL,
    member_id      INT NOT NULL,
    member_name    VARCHAR(50) NOT NULL,
    product_id     INT NOT NULL,
    product_name   VARCHAR(100) NOT NULL,
    product_price  INT NOT NULL,
    order_quantity INT NOT NULL,
    ordered_at     DATETIME NOT NULL,
    PRIMARY KEY (order_id, product_id) -- 기본 키를 (order_id, product_id) 복합키로 설정
);

-- 데이터 삽입
INSERT INTO orders_1nf (order_id, member_id, member_name, product_id, product_name, product_price, order_quantity, ordered_at) VALUES
(1001, 1, '션', 10, '노트북', 1500000, 2, '2025-08-20 10:00:00'),
(1001, 1, '션', 15, '키보드', 50000, 1, '2025-08-20 10:00:00'),
(1002, 2, '네이트', 10, '노트북', 1500000, 1, '2025-08-21 11:00:00'),
(1003, 1, '션', 20, '마우스', 30000, 1, '2025-08-21 12:00:00');


SELECT * FROM orders_1nf;