
-- previous_date를 만들고, DATEDIFF를 통해 날짜 차이가 1인 것만 골라내야 어제(1일 전) 날짜의 온도와 비교 가능

SELECT id
FROM
(
SELECT *
   , LAG(temperature) OVER (ORDER BY recordDate) AS previous_temp
   , LAG(recordDate) OVER (ORDER BY recordDate) AS previous_date
FROM weather
) a
WHERE temperature > previous_temp
AND DATEDIFF(day, previous_date, recordDate) = 1
