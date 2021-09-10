
-- подсчитал количество лайков пользователей меньше 10 лет
SELECT 
  COUNT(*) AS count_likes
FROM likes 
JOIN 
  profiles
  ON likes.to_user_id = profiles.user_id 
WHERE (YEAR(NOW())-YEAR(birthday)) < 10;