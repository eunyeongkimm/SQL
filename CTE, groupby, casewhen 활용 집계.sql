WITH SectInfo AS (
  SELECT
    gs.skey as skey,
    SUM(CASE WHEN appt_sect = 'S' THEN 1 ELSE 0 END) AS S_Count,
    SUM(CASE WHEN appt_sect = 'P' THEN 1 ELSE 0 END) AS P_Count,
    (COUNT(*) - COUNT(appt_sect)) AS Null_Count  --((전체 행 수) - (APPT_SECT채워진 행 수) == (NULL인 행 수))
  FROM [USdb].[sch_Basic].[B_appt] appt
   INNER JOIN [USdb].[sch_Addition].[A_key_grp] gs
   ON appt.gkey = gs.gkey  GROUP BY gs.skey
)

SELECT
  S_P_NULL,
  COUNT(*) AS skey_count
FROM (
  SELECT
    skey,
    CASE
      WHEN P_Count > 0 AND S_Count > 0 AND Null_Count > 0 THEN '111'
      WHEN P_Count > 0 AND S_Count = 0 AND Null_Count = 0 THEN '100'
      WHEN P_Count = 0 AND S_Count > 0 AND Null_Count = 0 THEN '010'
      WHEN P_Count = 0 AND S_count = 0 AND Null_Count > 0 THEN '001'
      WHEN P_Count > 0 AND S_Count > 0 AND Null_Count = 0 THEN '110'
      WHEN P_Count > 0 AND S_Count = 0 AND Null_Count > 0 THEN '101'
      WHEN P_Count > 0 AND S_Count = 0 AND Null_Count > 0 THEN '011'
      ELSE '000'
    END AS S_P_NULL
  FROM SectInfo
) SectResult
GROUP BY S_P_NULL
ORDER BY 2 DESC;