SELECT * FROM products
WHERE product_id = 1;

UPDATE products
SET price = 9800, stock_quantity = 580
WHERE product_id = 1;

SELECT @@SQL_SAFE_UPDATES;

SET SQL_SAFE_UPDATES = 0; -- 안전 모드 제거

UPDATE products
SET price = 990;

SET SQL_SAFE_UPDATES = 1; -- 안전 모드 활성화