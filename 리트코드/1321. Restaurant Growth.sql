-- 이동평균 구하기

-- visited_on 으로 group by 하여 월별 합계를 먼저 구한 후, 총합계 및 이동평균 집계

SELECT visited_on 
 , SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount
 , ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount
FROM 
(
 SELECT visited_on, sum(amount) as amount
 FROM Customer
 GROUP BY visited_on
) t
LIMIT 10000 OFFSET 6  -- 7번째 행부터 출력하기 위해 OFFSET 6 사용
