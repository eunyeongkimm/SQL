SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    SUM(list_price) AS monthly_total,
    LAG(SUM(list_price)) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m')) AS previous_month_total,
    SUM(list_price) - LAG(SUM(list_price)) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m')) AS difference,
    ((SUM(list_price) - LAG(SUM(list_price)) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m'))) / LAG(SUM(list_price)) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m'))) * 100 AS percentage_change
FROM
    final_pjt_fastcampus.order
GROUP BY
    DATE_FORMAT(created_at, '%Y-%m')
ORDER BY
    month;

