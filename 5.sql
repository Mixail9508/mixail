
-- создал таблицу
CREATE TABLE catalogs(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name_users VARCHAR(255) NOT NULL
);


-- Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- 'Отсортируйте записи в порядке, заданном в списке IN.'

-- Заполнил данные
INSERT INTO catalogs (name_users) VALUES
('Mixail'),
('Kiril'),
('Nastya'),
('Igor'),
('Antonina');

-- отсортировал в порядке как написано (5,1,2)
SELECT * FROM catalogs  WHERE id IN (5, 1, 2) order by field(id, 5, 1, 2);