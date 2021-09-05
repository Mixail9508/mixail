
-- пишем дни недели дней рождений
SELECT concat_ws(birthday, NOW()), DAYNAME(birthday) as weekday FROM users;

