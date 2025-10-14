-- ## 제2 정규형

DROP TABLE IF EXISTS order_item_2nf;
DROP TABLE IF EXISTS orders_2nf;
DROP TABLE IF EXISTS product_2nf;

-- 1. orders 테이블 생성 (주문 정보)
CREATE TABLE orders_2nf (
    order_id   INT NOT NULL,
    member_id  INT NOT NULL,
    member_name VARCHAR(50) NOT NULL, -- 아직 3NF 위반 요소를 남겨둔다.
    ordered_at DATETIME NOT NULL,
    PRIMARY KEY (order_id)
);

-- 2. product 테이블 생성 (상품 정보)
CREATE TABLE product_2nf (
    product_id   INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_price        INT NOT NULL,
    PRIMARY KEY (product_id)
);

-- 3. order_item 테이블 생성 (주문-상품 연결 정보)
CREATE TABLE order_item_2nf (
    order_id     INT NOT NULL,
    product_id   INT NOT NULL,
    order_price  INT NOT NULL,
    order_quantity        INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders_2nf (order_id),
    FOREIGN KEY (product_id) REFERENCES product_2nf (product_id)
);

-- product_2nf 데이터 삽입
INSERT INTO product_2nf (product_id, product_name, product_price) VALUES
(10, '노트북', 1500000),
(15, '키보드', 50000),
(20, '마우스', 30000);

-- orders_2nf 데이터 삽입
INSERT INTO orders_2nf (order_id, member_id, member_name, ordered_at) VALUES
(1001, 1, '션', '2025-08-20 10:00:00'),
(1002, 2, '네이트', '2025-08-21 11:00:00'),
(1003, 1, '션', '2025-08-21 12:00:00');

-- order_item_2nf 데이터 삽입
INSERT INTO order_item_2nf (order_id, product_id, order_price, order_quantity) VALUES
(1001, 10, 1500000, 2),
(1001, 15, 50000, 1),
(1002, 10, 1500000, 1),
(1003, 20, 30000, 1);


SELECT * FROM orders_2nf;

SELECT * FROM product_2nf;

SELECT * FROM order_item_2nf;