DROP INDEX idx_items_item_name ON items;
DROP INDEX idx_items_price_name ON items;
DROP INDEX idx_items_price ON items;
DROP INDEX idx_items_price_category_temp ON items;
DROP INDEX idx_items_category_price ON items;

-- 문제: 인덱스들을 만들어서 다음 쿼리 선능을 개선해라.
explain SELECT * FROM items
WHERE category =
'전자기기' AND is_active = TRUE;

explain SELECT * FROM items
WHERE category = '전자기기'
AND is_active = true
ORDER BY stock_quantity DESC;

explain SELECT * FROM items
WHERE stock_quantity < 90
AND category = '전자기기'
AND is_active = TRUE;

explain SELECT * FROM items
WHERE stock_quantity < 90 AND category = '전자기기' AND is_active = TRUE
ORDER BY stock_quantity DESC;

-- 정답
create index idx_items_category_actvie_stock on items(category, is_active, stock_quantity desc);