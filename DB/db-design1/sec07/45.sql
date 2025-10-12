-- ## 다대다(M:N) 관계 - 속성

DROP TABLE IF EXISTS order_item;

CREATE TABLE order_item (
    order_item_id  BIGINT   NOT NULL AUTO_INCREMENT, -- 주문 상품 ID (PK)
    order_id       BIGINT   NOT NULL,        -- 주문 ID (FK from orders)
    product_id     BIGINT   NOT NULL,        -- 상품 ID (FK from product)
    order_price    INT      NOT NULL,        -- 주문 당시 가격 (관계 속성)
    order_quantity INT      NOT NULL,        -- 주문 수량 (관계 속성)

    PRIMARY KEY (order_item_id),

    -- 한 주문에 동일한 상품이 중복으로 들어가는 것을 방지
    CONSTRAINT uq_order_item UNIQUE (order_id, product_id),
    CONSTRAINT fk_order_item_orders FOREIGN KEY (order_id)
      REFERENCES orders (order_id),
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id)
      REFERENCES product (product_id)
);