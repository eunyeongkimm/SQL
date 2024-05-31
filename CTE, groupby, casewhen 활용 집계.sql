WITH SectInfo AS (
  SELECT
    gs.skey as skey,
    SUM(CASE WHEN appt_sect = 'S' THEN 1 ELSE 0 END) AS S_Count,
    SUM(CASE WHEN appt_sect = 'P' THEN 1 ELSE 0 END) AS P_Count,
    (COUNT(*) - COUNT(appt_sect)) AS Null_Count  --((전체 행 수) - (APPT_SECT채워진 행 수) == (NULL인 행 수))
  FROM [USdb].[sch_Basic].[B_appt] appt
  INNER JOIN [USdb].[sch_Addition].[A_key_grp] gs
  ON appt.gkey = gs.gkey 
  GROUP BY gs.skey
)
SELECT
  S_P_NULL,
  COUNT(*) AS skey_count
FROM (
  SELECT
    skey,
	case when p_count > 0 then '1' else '0' end
	+ case when s_count > 0 then '1' else '0' end
	+ case when null_count > 0 then '1' else '0' end AS S_P_NULL
  FROM SectInfo
) SectResult
GROUP BY S_P_NULL
ORDER BY skey_count DESC;
