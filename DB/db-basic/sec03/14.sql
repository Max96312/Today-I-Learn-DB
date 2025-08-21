SELECT
	p.product_id,
	p.name,
	p.price,
	o.product_id,
	o.order_id
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id;

SELECT
	p.product_id,
	p.name,
	p.price,
	o.product_id,
	o.order_id
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

SELECT
	p.product_id,
	p.name,
	p.price,
	o.product_id,
	o.order_id
FROM orders AS o
RIGHT JOIN products AS p ON o.product_id = p.product_id;

SELECT
	p.product_id,
	p.name,
	p.price,
	o.product_id,
	o.order_id
FROM orders AS o
RIGHT JOIN products AS p ON o.product_id = p.product_id
WHERE o.order_id IS NULL;