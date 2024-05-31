/*
CREATE TABLE customer_order_summary AS
SELECT customer_id
  , count(distinct id) as order_cnt
  , min(created_at) as first_order_date
  , max(created_at) as last_order_date
  , sum(sale_price) as sum_sales
FROM final_pjt_fastcampus.order
GROUP BY customer_id
*/

WITH ord_record as (
SELECT o.customer_id
  , o.id
  , DATE_FORMAT(o.created_at, '%Y%m') AS order_month
  , DATE_FORMAT(cs.first_order_date, '%Y%m') AS first_order_month
    , DATE_FORMAT(cs.last_order_date, '%Y%m') AS last_order_month
FROM final_pjt_fastcampus.order o
INNER JOIN final_pjt_fastcampus.customer_order_summary cs 
ON o.customer_id = cs.customer_id
)
  
SELECT first_order_month AS cohort
  , COUNT(DISTINCT customer_id) AS cohort_size
  , COUNT(DISTINCT customer_id) / COUNT(DISTINCT customer_id) AS month0 -- 해당 월 첫구매
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 1 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month1
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 2 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month2
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 3 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month3
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 4 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month4
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 5 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month5
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 6 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month6
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 7 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month7
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 8 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month8
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 9 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month9
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 10 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month10
  , COUNT(DISTINCT CASE WHEN PERIOD_DIFF(last_order_month, first_order_month) >= 11 THEN customer_id END) / COUNT(DISTINCT customer_id) AS month11
FROM ord_record
GROUP BY first_order_month
ORDER BY first_order_month;



