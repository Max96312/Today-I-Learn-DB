-- ## 다대다(M:N) 관계 - 연결 테이블

DROP TABLE IF EXISTS order_item; -- 다른 예제 충돌 예방
DROP TABLE IF EXISTS order_product;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS orders;

-- 상품 테이블 생성
CREATE TABLE product (
    product_id  BIGINT          NOT NULL, -- 상품id 직접 입력
    name        VARCHAR(100)    NOT NULL,
    price       INT             NOT NULL,
    PRIMARY KEY (product_id)
);

-- 주문 테이블 생성
CREATE TABLE orders (
    order_id    BIGINT NOT NULL, -- 주문id 직접 입력
    order_date  DATE,
    PRIMARY KEY (order_id)
);

-- 연결 테이블(주문-상품) 생성
CREATE TABLE order_product (
    order_product_id    BIGINT  NOT NULL AUTO_INCREMENT,
    order_id            BIGINT  NOT NULL, -- orders 테이블의 FK
    product_id          BIGINT  NOT NULL, -- product 테이블의 FK

    PRIMARY KEY (order_product_id),

    -- 한 주문에 동일한 상품이 중복으로 들어가는 것을 방지
    CONSTRAINT uq_order_product UNIQUE (order_id, product_id),
    CONSTRAINT fk_order_product_orders FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_order_product_product FOREIGN KEY (product_id)
        REFERENCES product (product_id)
);

-- 상품 데이터 삽입
INSERT INTO product(product_id, name, price) VALUES(1, '청바지', 50000);
INSERT INTO product(product_id, name, price) VALUES(2, '티셔츠', 25000);

-- 주문 100 생성
INSERT INTO orders(order_id, order_date) VALUES(100, '2025-09-01');

-- 연결 테이블 데이터 삽입
-- 주문 100에 대한 상품 정보
INSERT INTO order_product(order_id, product_id) VALUES(100, 1); -- 주문 100번, 청바지
INSERT INTO order_product(order_id, product_id) VALUES(100, 2); -- 주문 100번, 티셔츠

-- 주문 101 생성
INSERT INTO orders(order_id, order_date) VALUES(101, '2025-09-02');
-- 주문 101에 대한 상품 정보
INSERT INTO order_product(order_id, product_id) VALUES(101, 1); -- 주문 101번, 청바지 1개

select * from product;
select * from orders;
select * from order_product;

SELECT
    o.order_id,
    p.name,
    p.price
FROM orders o
JOIN order_product op ON o.order_id = op.order_id
JOIN product p ON op.product_id = p.product_id
WHERE o.order_id = 100;


SELECT
    p.name,
    o.order_id,
    o.order_date
FROM product p
JOIN order_product op ON p.product_id = op.product_id
JOIN orders o ON op.order_id = o.order_id
WHERE p.product_id = 1;