DROP DATABASE IF EXISTS vk;

CREATE DATABASE IF NOT EXISTS vk;

-- используем БД vk
USE vk;

CREATE TABLE users(
	id 	BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX (phone),
	INDEX (email)
);

-- Заполним таблицу, добавим Петю и Васю
INSERT INTO users VALUES (DEFAULT, 'Petya', 'Petukhov', 'petya@mail.com', '89212223334', DEFAULT, DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Vasya', 'Vasilkow', 'vasya@mail.com', '89212023334', DEFAULT, DEFAULT);

-- посмотрим на содержимое таблицы

SELECT * FROM users;

-- 1:1 связь
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY(user_id) REFERENCES users(id) -- ON DELETE CASCADE ON UPDATE CASCADE -- https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html 
);

-- Заполним таблицу, добавим профили для уже созданных Пети и Васи
INSERT INTO profiles VALUES (1, 'm', '1997-12-01', NULL, 'Moscow', 'Russia'); -- профиль Пети
INSERT INTO profiles VALUES (2, 'm', '1988-11-02', NULL, 'Moscow', 'Russia'); -- профиль Васи

-- INT
-- -2147483648 до 2147483648
-- от 0 до 4 294 967 295

-- BIGINT -9 223 372 036 854 775 808 до 9 223 372 036 854 775 807
-- 0 до 18 446 744 073 709 551 615

-- автор сообщения : сообщение
-- 1 : М
-- 1 : 1

CREATE TABLE messages(
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED AUTO_INCREMENT NOT NULL
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	is_delivered BOOLEAN DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX messages_from_user_id_idx (from_user_id),
	INDEX messages_to_user_id_idx (to_user_id),
	CONSTRAINT fk_messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 1
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2

SELECT * FROM messages;

DESCRIBE messages;

-- Создадим таблицу в друзья
CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOLEAN DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	KEY (from_user_id),
	KEY (to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);

-- Добавим запрос на дружбу от Пети к Васе
INSERT INTO friend_requests VALUES (1, 2, 1);

SELECT * FROM friend_requests;

CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR(255),
	admin_id BIGINT UNSIGNED NOT NULL,
	KEY(admin_id),
	FOREIGN KEY (admin_id) REFERENCES users(id)
);

-- Добавим сообщество с создателем Петей
INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);
INSERT INTO communities VALUES (DEFAULT, 'Number2', 'I am number two', 1);

SELECT * FROM communities;

-- Таблица связи пользователей и сообществ

-- пользователи : сообщества
-- М : 1
-- 1 : М

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(community_id, user_id),
	KEY (community_id),
	KEY (user_id),
	FOREIGN KEY (community_id) REFERENCES communities(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Добавим запись вида Вася участник сообщества Number 1
INSERT INTO communities_users VALUES (1, 2, DEFAULT);

SELECT * FROM communities_users;

-- Создадим таблицу для хранения типов медиа файлов, каталог типов медифайлов.
 
 CREATE TABLE media_types(
 	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 	name VARCHAR(50) NOT NULL UNIQUE
 );

-- Добавим типы в каталог
INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

SELECT * FROM media_types;

CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (media_types_id),
	KEY (user_id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Добавим два изображения, которые добавил Петя
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im1.png', 78, DEFAULT);
-- Добавим документ, который добавил Вася
INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.docx', 1024, DEFAULT);

SELECT * FROM media;

-- 1) приложение
CREATE TABLE applications(
	applications_from_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	name_applications VARCHAR(150) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(user_id, applications_from_id),
	KEY(applications_from_id),
	KEY(user_id),
	FOREIGN KEY (applications_from_id) REFERENCES users(id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	INDEX(name_applications)
);

/* Вася поделился приложением с Петей
   А Петя поделился своим приложением 
   которое нужно было Пете */

INSERT INTO applications VALUES (1, 2, 'alarm clock', DEFAULT);
INSERT INTO applications VALUES (2, 1, 'notepad', DEFAULT);

SELECT * FROM applications;

-- 2) лайки
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	KEY (from_user_id),
	KEY (to_user_id),
	KEY (media_types_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id)
);

-- Вася поставил лайки под добавленным изображением Пети
INSERT INTO likes VALUES (DEFAULT, 2, 1, 1);
INSERT INTO likes VALUES (DEFAULT, 2, 1, 1);

SELECT * FROM likes;

-- 3) запись на стену
CREATE TABLE record_wall(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NULL,
	txt TEXT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (to_user_id),
	KEY (from_user_id),
	KEY (media_types_id),
	INDEX (from_user_id),
	FOREIGN KEY (to_user_id) REFERENCES users(id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id)
);

INSERT INTO record_wall VALUES (DEFAULT, 1, 2, 1, 'I suggest you go to football on 25.08.2021 at 19 00', DEFAULT);
INSERT INTO record_wall VALUES (DEFAULT, 1, 1, 1, 'классно съездил в отпуск в Болгарию', DEFAULT);

SELECT * FROM record_wall;