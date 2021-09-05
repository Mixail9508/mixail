/* Таблица users была неудачно спроектирована. 
 * 
   Записи created_at и updated_at были заданы 
   типом VARCHAR и в них долгое время помещались 
   значения в формате "20.10.2017 8:10". Необходимо 
   преобразовать поля к типу DATETIME, сохранив введеные 
   ранее значения. */

-- создал таблицу users с полями заполнеными руным типом 
-- VARCHAR created_at и updated_at 
CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	created_at VARCHAR(255) NOT NULL,
	updated_at VARCHAR(255) NOT NULL
);

INSERT INTO users VALUES (DEFAULT, '20.10.2017 8:10', '20.10.2017 8:10');

-- заменил дату и время под формат DATETIME
UPDATE users 
SET
	created_at = str_to_date(created_at, '%d.%m.%Y %h:%i'),
	updated_at = str_to_date(updated_at, '%d.%m.%Y %h:%i');

