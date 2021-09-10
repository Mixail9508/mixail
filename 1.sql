
-- выявил человека который больше всех писал данному пользователю
SELECT users.first_name, users.last_name, messages.from_user_id,COUNT(*) AS counts
FROM users 
INNER JOIN messages
	ON users.id=messages.from_user_id
	WHERE to_user_id = 2 
	GROUP BY from_user_id
	ORDER BY from_user_id DESC LIMIT 1;