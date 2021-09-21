
-- создал таблицу
CREATE TABLE shop(
	id SERIAL PRIMARY KEY,
	user_id INT,
	total DECIMAL (11,2),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- заполнил
INSERT INTO shop (user_id, total) VALUES
(2, 23000.00),
(4, 0.00),
(1, 1500.00),
(3, 110.00);

-- создал таблицу
CREATE TABLE sample(
	id SERIAL PRIMARY KEY,
	user_id INT,
	total DECIMAL (11,2),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- заполнил
INSERT INTO sample (user_id, total) VALUES
(1, 1200.00),
(3, 0.00),
(4, 0.00),
(2, 11.00);

-- открыл транзакцию
START TRANSACTION;

-- убедился о наличии средств на счете у выбранного пользователя
SELECT total FROM shop WHERE user_id = 1;

-- совершил перевод
UPDATE shop SET total = total - 1000 WHERE user_id = 1;

UPDATE sample SET total = total + 1000 WHERE user_id = 4;

-- завершил перевод без ошибок используя транзакции
COMMIT;








