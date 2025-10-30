INSERT INTO sample (product_id, name, price, stock_quantity, release_date)
VALUES (1, '프리미엄 청바지', 59900, 100, '2025-06-11');

SELECT * FROM sample;

UPDATE sample
SET price = 40000
WHERE product_id = 1;

DELETE FROM sample
WHERE product_id = 1;