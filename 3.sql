

-- создал удаление процедуры
DROP PROCEDURE IF EXISTS hello;

-- поменял закрытие для правильной работы процедуры
DELIMITER //

-- создал процедуру
CREATE PROCEDURE hello()
BEGIN
	IF (CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN -- с 6 утра и до 12 дня будет выводить доброе утро
		SELECT 'Доброе утро';
	ELSEIF (CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN -- с 12 дня и до 18 вечера будет выводить Добрый день
		SELECT 'Добрый день';
	ELSEIF (CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN -- с 18 вечера и до 00 ночи будет выводить добрый вечер
		SELECT 'Добрый вечер';
	ELSE 
		SELECT 'Доброй ночи'; -- с 00 ночи и до 6 утра будет выводить доброй ночи
	END IF; -- закрыл условие
END//

-- вернул закрытие 
DELIMITER ;

-- заупскаем процедуру
CALL hello();