--SELECT id FROM users WHERE id IN (SELECT to_user_id FROM messages WHERE from_user_id = (SELECT id FROM users WHERE username = 'creativewisdom377') )
SELECT users.id FROM users
JOIN messages on messages.to_user_id = users.id
WHERE from_user_id = (SELECT id FROM users WHERE username = 'creativewisdom377') GROUP BY to_user_id ORDER BY COUNT(to_user_id) DESC LIMIT 3;
