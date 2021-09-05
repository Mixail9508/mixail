
/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 Заполните их текущими датой и временем. */
INSERT INTO users (created_at, updated_at) VALUES
(NOW(), CURRENT_TIMESTAMP());
