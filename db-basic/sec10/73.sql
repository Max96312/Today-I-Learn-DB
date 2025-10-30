-- 실습을 위해 기존 테이블들을 삭제한다.
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

-- CHECK 제약 조건을 추가하여 products 테이블 재생성
CREATE TABLE products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price INT NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    discount_rate DECIMAL(5, 2) DEFAULT 0.00 CHECK (discount_rate BETWEEN 0.00 AND 100.00)
);

insert into products (name, category, price, stock_quantity)
values ('오류상품','전자기기', -5000, 10);

insert into products (name, category, price, stock_quantity, discount_rate)
values ('오류상품','전자기기', 50000, 10, 120.00);