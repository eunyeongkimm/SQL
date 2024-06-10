--MSSQL
--customer 기준, driver 기준으로 두 번 join

SELECT  request_at AS 'Day'
  , COALESCE(ROUND(SUM(CASE WHEN status LIKE 'cancel%' THEN 1.0 END) / COUNT(*), 2),0) AS 'Cancellation Rate'
FROM trips t
 INNER JOIN users c ON t.client_id = c.users_id AND c.banned = 'No'
 INNER JOIN users d ON t.driver_id = d.users_id AND d.banned = 'No'
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at
