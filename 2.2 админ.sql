
-- создал таблицу
CREATE TABLE accounts(
	id SERIAL,
	name VARCHAR(200) NOT NULL,
	password_r CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id,name)
);

-- заполнил
INSERT INTO accounts (name, password_r) VALUES
('Kiril', 'pass'),
('Mixail', '2502'),
('Dima', '1233'),
('Tolik', '6666666'),
('Olya', '0000'),
('Oleg', 'inshskkq223sssd');

-- создал пользователя
mysql> CREATE USER 'user_read'@'localhost';
Query OK, 0 rows affected (0.07 sec)

-- сделал представление 
CREATE VIEW username AS SELECT id,name FROM accounts;

-- сделал разрешение для пользователя через предстовление
mysql> GRANT USAGE ON shop.username TO 'user_read'@'localhost';
Query OK, 0 rows affected (0.04 sec)

