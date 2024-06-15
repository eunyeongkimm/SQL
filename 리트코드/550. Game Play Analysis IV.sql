SELECT ROUND(SUM(CASE WHEN a2.event_date IS NOT NULL THEN 1 ELSE 0 END) / COUNT(DISTINCT a1.player_id), 2) AS fraction
FROM activity a1
LEFT JOIN activity a2 
ON 
    a1.player_id = a2.player_id 
    AND a2.event_date = a1.event_date + INTERVAL 1 DAY
WHERE 
    (a1.player_id, a1.event_date) IN (
        SELECT player_id, MIN(event_date)
        FROM activity
        GROUP BY player_id
    );


-- 다른풀이

SELECT ROUND(SUM(CASE WHEN DATEDIFF(aa.second_event, aa.first_event) = 1 THEN 1.0 ELSE 0.0 END) / count(aa.player_id),2) as fraction
FROM ( 
 SELECT player_id, first_event, all_event as second_event
 FROM (
    SELECT 
        player_id,
        MIN(event_date) OVER (PARTITION BY player_id) AS first_event,
        event_date AS all_event,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS event_rank
    FROM lt_game.activity
 ) event_all
 WHERE event_rank = 2
) aa
