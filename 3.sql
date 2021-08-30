
-- Добовляем колонку активности
ALTER TABLE profiles ADD COLUMN is_active VARCHAR(1);

-- Подтверждаем активность всех пользователей
UPDATE profiles 
SET 
	is_active = TRUE;

-- убираем разрешение на активные действия лиц не достигших 18 лет
UPDATE profiles 
SET 
	is_active = FALSE WHERE TIMESTAMPDIFF(YEAR,birthday,CURDATE()) < 18;

