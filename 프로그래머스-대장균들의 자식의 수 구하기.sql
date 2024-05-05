--left join 활용

SELECT p.id, COUNT(c.parent_id) AS child_count
FROM ecoli_data p
LEFT JOIN ecoli_data c
ON p.id = c.parent_id
GROUP BY id

