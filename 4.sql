-- Удаляем сообщение свыше 1 дня
DELETE FROM messages WHERE ADDDATE(NOW(),INTERVAL 1 DAY) > created_at;

