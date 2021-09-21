-- удаление триггера
DROP TRIGGER IF EXISTS prod_trigger;

DELIMITER //

-- создание триггера
CREATE TRIGGER prod_trigger BEFORE INSERT ON products
FOR EACH ROW 
	BEGIN 
		IF(ISNULL(NEW.name)) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
		END IF;
		IF(ISNULL(NEW.description)) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
		END IF;
	END//
	
DELIMITER ;

-- работает
INSERT INTO products (name, description) VALUES
	('мясо', 'скелетная поперечно-полосатая мускулатура животного с прилегающими к ней жировой и соединительной тканями');

-- ошибка
INSERT INTO products (name, description) VALUES
	('яйца', NULL);

-- ошибка
INSERT INTO products (name, description) VALUES
	(NULL, NULL);