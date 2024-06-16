SELECT ID as id, COUNT(*) as num
FROM
(
SELECT requester_id as ID
FROM RequestAccepted

UNION ALL

SELECT accepter_id as ID
FROM RequestAccepted
) tot
GROUP BY ID
ORDER BY num DESC
LIMIT 1
