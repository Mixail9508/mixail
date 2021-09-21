
-- создал представления таблицы catalogs
CREATE VIEW works AS SELECT * FROM catalogs;

-- создал представления таблицы products
CREATE VIEW works_prod AS SELECT * FROM products;

-- сделал объединение таблиц
SELECT 
	w.name,
	wp.name,
	wp.catalog_id
FROM works w 
JOIN
works_prod wp
ON w.id = wp.catalog_id;
	
