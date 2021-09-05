--     В таблице складских запасов storehouses_products в поле value 
-- 	могут встречаться самые разные цифры: 0, если товар закончился 
-- 	и выше нуля, если на складе имеются запасы. Необходимо отсортировать 
-- 	записи таким образом, чтобы они выводились в порядке увеличения 
-- 	значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей. 

-- создал таблицу
CREATE TABLE storehouses_products(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	value VARCHAR(10)
);

-- внес данные 
INSERT INTO storehouses_products (value) VALUES
('0'),
('2500'),
('0'),
('30'),
('500'),
('1');

-- отсортировал по возрастанию, но с учетом нулевых значений
SELECT 
	* 
FROM 
	storehouses_products 
ORDER BY 
	IF(value > 0, 0, 1), value;






