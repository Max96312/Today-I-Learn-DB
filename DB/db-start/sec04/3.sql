INSERT INTO customers VALUES (NULL, '강감찬', 'kang@example.com', 'hashed_password_123',
'서울시 관악구', '2025-06-11 10:30:00');
INSERT INTO customers VALUES (NULL, '이순신', 'lee@example.com', 'hashed_password_123',
'서울시 관악구', '2025-06-12 10:30:00');

SELECT * FROM customers;

INSERT INTO customers (name, email, password, address)
VALUES ('세종대왕', 'sejong@example.com', 'hashed_password_123', '서울시 종로구');

SELECT * FROM customers;

INSERT INTO products (name, price, stock_quantity)
VALUES ('베이직 긴팔 티셔츠', 19900, 200);
INSERT INTO products (name, price, stock_quantity)
VALUES ('초록색 긴팔 티셔츠', 30000, 50);

SELECT * FROM products;

INSERT INTO products (name, price, stock_quantity) VALUES
('검정 양말', 5000, 100),
('갈색 양말', 5000, 150),
('흰색 양말', 5000, 200);

SELECT * FROM products;