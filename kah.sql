SELECT * 
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM emp
ORDER BY prod_lgu desc, prod_cost asc) a)
WHERE rn BETWEEN 11 AND 20;