
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет
SELECT COUNT(*) as count_likes FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) < 10;