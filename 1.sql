
-- Пусть задан некоторый пользователь. Из всех пользователей соц. 
-- сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений)
SELECT 
	from_user_id, to_user_id, COUNT(*) as quantity 
FROM 
	messages 
WHERE 
	to_user_id = 2 
GROUP BY 
	from_user_id 
ORDER BY 
	quantity DESC LIMIT 1;
	