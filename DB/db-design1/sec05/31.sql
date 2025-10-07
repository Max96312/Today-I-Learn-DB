-- 테이블 초기화
DROP TABLE IF EXISTS order_item_s;
DROP TABLE IF EXISTS orders_s;
DROP TABLE IF EXISTS product_s;

-- 상품 테이블 생성
CREATE TABLE product_s (
    product_id   BIGINT       NOT NULL AUTO_INCREMENT,
    name         VARCHAR(100) NOT NULL,
    price        INT          NOT NULL,
    PRIMARY KEY (product_id)
);

-- 주문 테이블 생성
CREATE TABLE orders_s (
    order_id   BIGINT   NOT NULL AUTO_INCREMENT,
    ordered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id)
);

-- 주문 항목 테이블 생성 (대리 키 + UNIQUE 제약조건 사용)
CREATE TABLE order_item_s (
    order_item_id BIGINT NOT NULL AUTO_INCREMENT, -- 주문 상품 ID (PK)
    order_id      BIGINT NOT NULL,                -- 주문 ID (FK)
    product_id    BIGINT NOT NULL,                -- 상품 ID (FK)
    order_price   INT    NOT NULL,                -- 주문 당시 가격
    count         INT    NOT NULL,                -- 주문 수량
    PRIMARY KEY (order_item_id),
    CONSTRAINT fk_order_item_s_orders FOREIGN KEY (order_id)
        REFERENCES orders_s (order_id),
    CONSTRAINT fk_order_item_s_product FOREIGN KEY (product_id)
        REFERENCES product_s (product_id),
    UNIQUE KEY uq_order_product (order_id, product_id) -- 복합 UNIQUE 제약
);

-- 샘플 데이터 삽입 (예시를 위해 ID 직접 지정)
INSERT INTO product_s (product_id, name, price) VALUES (101, '노트북', 1500000);
INSERT INTO product_s (product_id, name, price) VALUES (102, '마우스', 20000);
INSERT INTO orders_s (order_id) VALUES (1);

-- 1번 주문에 101번 상품 2개 추가
INSERT INTO order_item_s (order_id, product_id, order_price, count)
VALUES (1, 101, 1500000, 2);

-- 1번 주문에 102번 상품 1개 추가
INSERT INTO order_item_s (order_id, product_id, order_price, count)
VALUES (1, 102, 20000, 1);

-- (실패) 1번 주문에 101번 상품을 중복 추가 시도
-- INSERT INTO order_item_s (order_id, product_id, order_price, count)
-- VALUES (1, 101, 1500000, 3);