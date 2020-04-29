8)
SELECT regions.region_id, regions.region_name, countries.country_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id AND regions.region_name = 'Europe');
9)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id
     AND regions.region_name = 'Europe');
10)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city, departments.department_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id  AND regions.region_name = 'Europe');
11)   
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city,departments.department_name,
      (employees.FIRST_NAME||employees.LAST_NAME) NAME 
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id)
     JOIN employees ON( departments.department_id = employees.department_id AND regions.region_name = 'Europe');
12)
SELECT employees.employee_id,(employees.FIRST_NAME||employees.LAST_NAME) NAME, jobs.job_id, jobs.job_title
FROM employees JOIN jobs ON(employees.job_id = jobs.job_id);
13)
SELECT e.manager_id mr_id, e.employee_id, m.first_name || m.last_name mgr_name
            , e.first_name || e.last_name, e.job_id, jobs.job_title name
FROM employees e, jobs, employees m
WHERE e.job_id =jobs.job_id
      AND e.manager_id = m.employee_id
      AND e.manager_id =100;

SELECT *
FROM employees;
SELECT *
FROM jobs;


조인을 성공해야지만 데이터가 조회된다.
==> KING의 상급자 정보(mgr)는 NULL이기 때문에 조인에 실패하고,
KING의 정보는 나오지 않는다. (emp 테이블 건수 14건 -> 조인결과 13건)

INNER 조인 복습
상급자 사번, 상급자 이름, 직원 사번, 직원 이름
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);



위의 쿼리를 OUTER 조인으로 변경
==> (KING 직원이 조인에 실패해도 본인 정보에 대해서는 나오도록,
하지만 상급자 정보는 없기 때문에 나오지 않는다.)

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);
     
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

ORACLE-SQL : OUTER 
oracle join
1. FROM절에 조인할 테이블 기술(콤마로 구분)
2. WHERE 절에 조인 조건을 기술
3. 조인 컬럼(연결고리) 중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여 준다.
==> 마스터 테이블 반대편쪽 테이블의 컬럼

SELECT m.empno,m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

OUTER 조인의 조건 기술 위치에 따른 결과 변화

직원의 상급자 이름, 아이디를 포함해서 조회
단, 직원의 소속부서가 10번에 속하는 직원들만 한정해서;

조건을 ON절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

조건을 WHERE절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno = 10;

OUTER 조인을 하고 싶은 것이라면 조건을 ON절에 기술하는게 맞다.

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e,emp m
WHERE e.mgr = m.empno(+) AND e.deptno = 10;

SELECT *
FROM buyprod;
WHERE buy_date = TO_DATE('2005/01/25','yyyy/mm/dd');

SELECT *
FROM prod;

SELECT b.BUY_DATE, b.BUY_PROD, c.prod_id, c.prod_name, b.BUY_QTY 
FROM buyprod b, prod c
WHERE c.prod_id = b.buy_prod(+) AND buy_date(+) = TO_DATE('2005/01/25','yyyy/mm/dd');

SELECT NVL(b.BUY_DATE,'2005/01/25') buy_date, b.BUY_PROD, c.prod_id, c.prod_name, b.BUY_QTY 
FROM prod c LEFT OUTER JOIN buyprod b ON(c.prod_id = b.buy_prod AND buy_date = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT TO_DATE('2015/01/25','YYYY/MM/DD') buy_date, b.BUY_PROD, c.prod_id, c.prod_name, NVL(b.BUY_QTY,0) BUY_QTY 
FROM prod c LEFT OUTER JOIN buyprod b ON(c.prod_id = b.buy_prod AND buy_date = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM customer;

SELECT p.pid, p.pnm, 1 cid, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM product p LEFT OUTER JOIN cycle c ON(p.pid = c.pid AND c.cid = 1);



SELECT p.pid, p.pnm, 1 cid, NVL(c.day,0) day,NVL(a.cnm,0) cnm, NVL(c.cnt,0) cnt
FROM product p JOIN cycle c ON(p.pid = c.pid AND c.cid = 1)
    JOIN customer a ON(a.cid = c.cid AND a.cnm ='brown')
ORDER BY pid DESC;

CROSS JOIN
조인 조건을 기술하지 않은 경우
모든 가능한 행의 조합으로 결과가 조회된다.

emp 14 * dept 4 = 56 건
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (조인 테이블만 기술하고 WHERE 절에 조건을 기술하지 않는다.)
SELECT *
FROM emp, dept;

SELECT *
FROM customer CROSS JOIN product;

SELECT *
FROM customer, product;

서브쿼리 
WHERE : 조건을 만족하는 행만 조회하도록 제한
SELECT *
FROM emp
WHERE 1 = 1
OR 1! = 1;

1 = 1 OR 1 != 1
true or false ==> true

서브 <==> 메인
서브쿼리는 다른 쿼리 안에서 작성된 쿼리
서브쿼리 가능한 위치
1. SELECT
    SCALAR SUB QUERY 
    * 스칼라 서브쿼리는 조회되는 행이 한개이고, 컬럼이 한개이어야 함.
    EX) DUAL 테이블
2. FROM
    INLINE-VIEW
    SELECT 쿼리를 괄호로 묶은 것
3. WHERE
    SUB QUERY
    WHERE 절에 사용된 쿼리
    
SMITH가 속한 부서에 속한 직원들은 누가 있을까?
1.SMITH가 속한 부서가 몇번이지??
2. 1번에서 알아낸 부서번호에 속하는 직원을 조회

==> 독립적인 2개의 쿼리를 각각 실행
    두번째 쿼리는 첫번째 쿼리의 결과에 따라 값을 다르게 가져와야 한다.
    (SMITH)(20) => WARD(30) == 두번째 쿼리 작성시 20번에서 30번으로 조건을 변경)
    ==> 유지보수 측면에서 좋지 않음
    
첫번째 쿼리
    SELECT deptno 
    FROM emp
    WHERE ename = 'SMITH';
두번째 쿼리
    SELECT *
    FROM emp;
    WHERE deptno = 20;
    
서브쿼리를 통한 쿼리 통합

SELECT *
    FROM emp
    WHERE deptno = (SELECT deptno 
                    FROM emp
                    WHERE ename = 'SMITH');


SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);


