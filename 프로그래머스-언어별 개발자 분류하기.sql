SELECT GRADE, ID, EMAIL
FROM(
SELECT 
    CASE 
        WHEN (FIND_IN_SET('Python', skills) > 0 AND FIND_IN_SET('Front End', skills) > 0) THEN 'A'
        WHEN (FIND_IN_SET('C#', skills) > 0) THEN 'B'
        WHEN (FIND_IN_SET('Front End', skills) > 0) THEN 'C'
    END AS GRADE,
    ID,
    EMAIL
FROM (
SELECT 
    d.ID,
    d.EMAIL,
    GROUP_CONCAT(s.NAME,',',s.CATEGORY) AS skills
FROM 
    DEVELOPERS d
JOIN 
   SKILLCODES s 
ON 
    (d.SKILL_CODE & s.CODE) = s.CODE
GROUP BY 
    d.ID,
    d.EMAIL
) AS dev_skills
) AS grade_dev
WHERE GRADE IS NOT NULL
ORDER BY 
    GRADE, ID;
