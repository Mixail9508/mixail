
-- Создал таблицу с наименованием подтоваров
CREATE TABLE products(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name_id VARCHAR(150) NOT NULL,
	catalogs_id  BIGINT UNSIGNED NOT NULL,
	KEY (catalogs_id),
	FOREIGN KEY (catalogs_id) REFERENCES catalogs(id)
);

-- заполнил
INSERT INTO products (name_id, catalogs_id) VALUES
('яблоки', '3'),
('колбаса', '2'),
('помидоры', '1'),
('окорок', '2'),
('морковь', '1'),
('ананас', '3'),
('бананы', '3');

-- сделал таблицу с каталогом товаров
CREATE TABLE catalogs(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

-- заполнил
INSERT INTO catalogs (name) VALUES
('овощи'),
('мясные'),
('фрукты');

-- первый вриант не очень удобный для соотношения товаров к каталогом
SELECT name_id, catalogs_id FROM products WHERE catalogs_id IN (1,2,3) ORDER BY catalogs_id;

-- второй вриант который намного лучше для соотношения товаров к каталогом
SELECT 
	name_id, catalogs_id
FROM 
	products
WHERE 
	catalogs_id IN (SELECT id FROM catalogs);





