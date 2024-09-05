SELECT name, SUM(H) AS "total hits" FROM teams JOIN performances ON performances.team_id = teams.id WHERE performances.year = 2001 GROUP BY name ORDER BY "total hits" DESC LIMIT 5;
