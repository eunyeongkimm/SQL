-- 정규표현식
-- 동시에 가지는 경우 중복 출력되어 id에 distinct

SELECT DISTINCT(d.ID), d.EMAIL, d.FIRST_NAME, d.LAST_NAME
FROM DEVELOPERS d
INNER JOIN SKILLCODES s
ON (d.SKILL_CODE & s.CODE) = s.CODE
WHERE s.NAME IN ('C#', 'Python')
ORDER BY d.ID ASC
