-- 비트연산

SELECT E.ID, E.GENOTYPE, P.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA E
INNER JOIN ECOLI_DATA P
ON E.PARENT_ID = P.ID 
 AND (E.GENOTYPE & P.GENOTYPE) = P.GENOTYPE
ORDER BY E.ID ASC
