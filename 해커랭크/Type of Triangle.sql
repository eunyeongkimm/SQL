-- triangle 만족 / 만족X로 나눈 후, 만족하는 case를 다시 3가지로 나눔

SELECT 
    CASE 
        WHEN ((a + b > c) AND (a + c > b) AND (b + c > a)) THEN
            CASE
                WHEN a = b AND b = c THEN 'Equilateral'
                WHEN a = b OR b = c OR a = c THEN 'Isosceles'
                ELSE 'Scalene'
            END
        ELSE 'Not A Triangle'
    END 
FROM TRIANGLES;
