
-- Создал таблицу с пользователями
CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX (phone),
	INDEX (email)
);

-- заполнил ее значениями
INSERT INTO users VALUES (DEFAULT, 'Petya', 'Petukhov', 'petya@mail.com', '89212223334', DEFAULT, DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Vasya', 'Vasilkow', 'vasya@mail.com', '89212023334', DEFAULT, DEFAULT);
INSERT INTO users (first_name, last_name,email, phone) VALUES
('Анна', 'Владимеровка', 'anna@mail.com', '89212453334'),
('Кирилл', 'Дягтерев', 'kirill@mail.com', '89211423334');

-- Создал таблицу с заказами
CREATE TABLE zakaz(
	name_zak VARCHAR(255) NOT NULL,
	number_user BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (number_user),
	KEY(number_user),
	FOREIGN KEY (number_user) REFERENCES users(id)
); 


-- добавил записи наименования заказа
INSERT INTO zakaz (number_user, name_zak) VALUES
('1', 'бытовая техника'),
('4', 'пк');

-- вывел тех кто купил хоть один товар
SELECT 
	u.first_name,
	u.last_name,
	z.name_zak
FROM 
	users AS u
INNER JOIN
	zakaz AS z
ON
  u.id = z.number_user;





