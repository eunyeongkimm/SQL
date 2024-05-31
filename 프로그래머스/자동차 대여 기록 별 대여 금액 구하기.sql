-- 관리 효율성을 위해 7일/30일/90일을 변수로 두고 join

WITH TRUCK_RENT AS (
    SELECT *, REGEXP_REPLACE(duration_type, '[^0-9]+', '') AS t_numbers
    FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN DP
    WHERE car_type = '트럭'
)

SELECT 
    history_id AS HISTORY_ID, 
    ROUND((100 - IFNULL(aa.discount_rate, 0)) / 100 * daily_fee * days, 0) AS FEE
FROM (
    SELECT 
        history_id, 
        daily_fee, 
        DATEDIFF(end_date, start_date) + 1 AS days, 
        MAX(discount_rate) AS discount_rate
    FROM 
        CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    LEFT JOIN 
        CAR_RENTAL_COMPANY_CAR C ON H.CAR_ID = C.CAR_ID
    LEFT JOIN 
        TRUCK_RENT TR ON DATEDIFF(end_date, start_date) + 1 >= TR.t_numbers
    WHERE 
        C.CAR_TYPE = '트럭'
    GROUP BY 
        history_id, daily_fee, days
) aa
ORDER BY 
    FEE DESC, 
    HISTORY_ID DESC;


-- 변수처리 하기 전 쿼리
/*

WITH TRUCK_RENT AS (
 SELECT *, REGEXP_REPLACE(duration_type, '[^0-9]+', '') AS t_numbers
 FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN DP
 WHERE car_type = '트럭'
)

SELECT  history_id AS HISTORY_ID, ROUND((100-IFNULL(discount_rate,0)) / 100 * daily_fee * days, 0) AS FEE
FROM
(
 SELECT history_id, daily_fee, DATEDIFF(end_date, start_date) +1 AS days,
 CASE WHEN DATEDIFF(end_date, start_date) +1 >= 7 AND DATEDIFF(end_date, start_date) +1 < 30 THEN 7
   WHEN DATEDIFF(end_date, start_date) +1 >= 30 AND DATEDIFF(end_date, start_date) +1 < 90 THEN 30
   WHEN DATEDIFF(end_date, start_date) +1 >= 90 THEN 90
 ELSE 0 END AS days_category
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
LEFT JOIN CAR_RENTAL_COMPANY_CAR C
ON H.CAR_ID = C.CAR_ID
WHERE CAR_TYPE = '트럭'
) aa
LEFT JOIN TRUCK_RENT TR
ON TR.t_numbers = aa.days_category
ORDER BY FEE DESC, HISTORY_ID DESC

*/
