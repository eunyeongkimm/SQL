SELECT 
    ROUND(SUM(CASE WHEN a2.event_date IS NOT NULL THEN 1 ELSE 0 END) / COUNT(DISTINCT a1.player_id), 2) AS fraction
FROM 
    activity a1
LEFT JOIN 
    activity a2 
ON 
    a1.player_id = a2.player_id 
    AND a2.event_date = a1.event_date + INTERVAL 1 DAY
WHERE 
    (a1.player_id, a1.event_date) IN (
        SELECT player_id, MIN(event_date)
        FROM activity
        GROUP BY player_id
    );
