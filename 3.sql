
-- Подсчитал количество лайков мужского, женского пола и тех у кого пол не указан
SELECT 
	COUNT(*) AS count_likes,
	CASE(p.gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender
FROM profiles p
JOIN
	likes l
ON p.user_id = l.to_user_id
GROUP BY gender
ORDER BY count_likes DESC;