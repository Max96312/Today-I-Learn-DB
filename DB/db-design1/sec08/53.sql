-- ## 식별 관계 vs 비식별 관계 - 다대다(M:N) 1

DROP TABLE IF EXISTS order_item_identifying;
DROP TABLE IF EXISTS product_identifying;
DROP TABLE IF EXISTS orders_identifying;

-- 상품 테이블 생성
CREATE TABLE product_identifying (
    product_id  BIGINT          NOT NULL, -- 상품id 직접 입력
    name        VARCHAR(100)    NOT NULL,
    price       INT             NOT NULL,
    PRIMARY KEY (product_id)
);

-- 주문 테이블 생성
CREATE TABLE orders_identifying (
    order_id    BIGINT NOT NULL, -- 주문id 직접 입력
    order_date  DATE,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_item_identifying (
    order_id   BIGINT NOT NULL, -- PK의 일부 + FK
    product_id BIGINT NOT NULL, -- PK의 일부 + FK
    order_price INT    NOT NULL,
    order_quantity       INT    NOT NULL,
    PRIMARY KEY (order_id, product_id), -- 복합 기본 키
    CONSTRAINT fk_oi_iden_orders FOREIGN KEY (order_id) REFERENCES orders_identifying (order_id),
    CONSTRAINT fk_oi_iden_product FOREIGN KEY (product_id) REFERENCES product_identifying (product_id)
);

-- 상품 데이터 삽입
INSERT INTO product_identifying(product_id, name, price) VALUES(1, '청바지', 50000);
INSERT INTO product_identifying(product_id, name, price) VALUES(2, '티셔츠', 25000);

-- 주문 100 생성
INSERT INTO orders_identifying(order_id, order_date) VALUES(100, '2025-09-01');

-- 100번 주문에 1번 상품(청바지) 추가
INSERT INTO order_item_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 1);

-- 100번 주문에 2번 상품(티셔츠) 추가
INSERT INTO order_item_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 2, 15000, 2);

select * from order_item_identifying;

-- 100번 주문에 1번 상품(청바지)을 중복 추가 시도
INSERT INTO order_item_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 5); -- 수량을 5개로 다시 주문 시도

DROP TABLE IF EXISTS order_item_non_identifying;
DROP TABLE IF EXISTS product_non_identifying;
DROP TABLE IF EXISTS orders_non_identifying;

-- 상품 테이블 생성
CREATE TABLE product_non_identifying (
    product_id  BIGINT          NOT NULL, -- 상품id 직접 입력
    name        VARCHAR(100)    NOT NULL,
    price       INT             NOT NULL,
    PRIMARY KEY (product_id)
);

-- 주문 테이블 생성
CREATE TABLE orders_non_identifying (
    order_id    BIGINT NOT NULL, -- 주문id 직접 입력
    order_date  DATE,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_item_non_identifying (
    order_item_id BIGINT NOT NULL AUTO_INCREMENT, -- 독립적인 PK
    order_id BIGINT NOT NULL, -- 일반 컬럼 + FK
    product_id BIGINT NOT NULL, -- 일반 컬럼 + FK
    order_price INT NOT NULL,
    order_quantity INT NOT NULL,
    PRIMARY KEY (order_item_id),
    CONSTRAINT fk_oi_non_orders FOREIGN KEY (order_id) 
        REFERENCES orders_non_identifying(order_id),
    CONSTRAINT fk_oi_non_product FOREIGN KEY (product_id)
        REFERENCES product_non_identifying(product_id)
);


-- 상품 데이터 삽입
INSERT INTO product_non_identifying(product_id, name, price) VALUES(1, '청바지', 50000);
INSERT INTO product_non_identifying(product_id, name, price) VALUES(2, '티셔츠', 25000);

-- 주문 100 생성
INSERT INTO orders_non_identifying(order_id, order_date) VALUES(100, '2025-09-01');

-- 100번 주문에 1번 상품(청바지) 추가
INSERT INTO order_item_non_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 1);

-- 실수로 동일한 상품을 한 번 더 추가
INSERT INTO order_item_non_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 1);

select * from order_item_non_identifying;

DROP TABLE IF EXISTS order_item_non_identifying;

CREATE TABLE order_item_non_identifying (
    order_item_id BIGINT NOT NULL AUTO_INCREMENT, -- 독립적인 PK
    order_id BIGINT NOT NULL, -- 일반 컬럼 + FK
    product_id BIGINT NOT NULL, -- 일반 컬럼 + FK
    order_price INT NOT NULL,
    order_quantity INT NOT NULL,
    PRIMARY KEY (order_item_id),
    UNIQUE KEY uq_order_item (order_id, product_id), -- 이 조합은 유일해야 한다.
    CONSTRAINT fk_oi_non_orders FOREIGN KEY (order_id) 
        REFERENCES orders_non_identifying(order_id),
    CONSTRAINT fk_oi_non_product FOREIGN KEY (product_id)
        REFERENCES product_non_identifying(product_id)
);

-- 100번 주문에 1번 상품(청바지) 추가
INSERT INTO order_item_non_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 1);


-- 100번 주문에 1번 상품(청바지)을 중복 추가 시도
INSERT INTO order_item_non_identifying(order_id, product_id, order_price, order_quantity)
VALUES (100, 1, 30000, 1);