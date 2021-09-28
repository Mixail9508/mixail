

-- создал таблицу
DROP TABLE IF EXISTS users; 
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- создал процедуру на миллион записей
DROP PROCEDURE IF EXISTS insert_into_users;

DELIMITER //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 1000000;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //

DELIMITER ;

-- проверил
CALL insert_into_users();
SELECT * FROM users;
SELECT * FROM users LIMIT 3;