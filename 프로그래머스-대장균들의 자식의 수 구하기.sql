--left join + null값은 0으로 채우기

SELECT p.id, IFNULL(COUNT(c.parent_id),0) AS child_count
FROM ecoli_data p
LEFT JOIN ecoli_data c
ON p.id = c.parent_id
GROUP BY id

