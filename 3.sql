
-- подсчитал лайки
SELECT COUNT(*) AS likes,
	(SELECT 
		CASE(gender) 
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		WHEN 'x' THEN 'not defined'
	END AS gender 
	FROM 
		profiles 
	WHERE 
		profiles.user_id = likes.to_user_id) AS gender
	FROM 
		likes 
	GROUP BY
		gender
	ORDER BY 
		likes DESC;
