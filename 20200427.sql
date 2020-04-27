SELECT COUNT(*)
FROM
(SELECT COUNT(*) cnt
FROM
(SELECT deptno  
FROM emp
GROUP BY deptno));

JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE)

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 떄문에
SELECT 할수 있는 컬럼의 개수가 많아진다.(가로 확장)



NATURAL JOIN : 
    조인하려는 두 테이블의 연결고리 컬럼의 이름이 같을 경우
    emp, dept 테이블에는 deptno라는 공통된 (동일한 이름의, 타입도 동일) 연결고리 컬럼이 존재
    
    다른 ANSI-SQL 문법을 통해서 대체가 가능하고 조인 테이블의 컬럼명이 동일하지 않으면 
    사용이 불가능하기 때문에 사용빈도는 다소 낮다.

- emp 테이블 : 14건
- dept 테이블 : 4건


조인 하려고하는 컬럼을 별도 기술하지 않음.    
SELECT *
FROM emp NATURAL JOIN dept;

ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않지 않음.
오라클 조인 문법

1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 콜론(,)
2. 연결고리 조건을 WHERE 절에 기술하면 된다.(WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno가 10번인 직원들만 dept 테이블과 조인 하여 조회
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND emp.deptno = 10;

ANSI-SQL : JOIN with USING
join 하려는 테이블 간 이름이 같은 컬럼이 2개 이상일 때
개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명 기술

SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
조인 하려는 두 테이블간 컬럼명이 다를 때
ON절에 연결고리 조건을 기술;

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ORALECE 문법으로 위 SQL 작성

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때 
emp 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리
해당 직원의 관리자의 이름을 알고싶을 때 

ANSI-SQL로 SQL 조인 : 
조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자 정보)
    연결고리 컬럼 : 직원.MGR = 관리자.EMPNO
    -> 조인 컬럼 이름이 다르다.(MGR, EMPNO)
    -> NATURAL JOIN, JOIN WITH USING은 사용이 불가능한 형태
    -> JOIN with ON

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ANSI-SQL로 작성
SELECT *
FROM emp e JOIN emp m ON (e.mgr = m.empno);

NONEUQI JOIN : 연결고리 조건이 =이 아닐때

그동안 WHERE 절에서 사용한 연산자 : =, !=, <>, <=, <, >, >=
                                AND, OR, NOT
                                LIKE %, _
                                OR - IN
                                BETWEEN AND ==> >=, <=
                            
SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

위의 문장을 ORACLE 조인 문법으로 변경
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno = dept.deptno;

-- JOIN ON 사용
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND emp.deptno IN(10,30));

-- 오라클 문법 사용
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND emp.deptno IN(10,30);

-- JOIN ON 사용  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500);

-- 오라클 문법 사용
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500;
   
-- JOIN ON 사용  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500 AND empno >7600);

-- 오라클 문법 사용
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500
   AND empno >7600;
   
-- JOIN ON 사용  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500 AND empno >7600 AND dname ='RESEARCH');

-- 오라클 문법 사용
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500
   AND empno >7600;
   AND dname ='RESEARCH'

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

SELECT member.mem_id, member.member_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM JOIN(member JOIN prod CROSS JOIN cart ON(member.mem_id = cart.cart_prod AND cart.cart_prod = prod.prod_id);

SELECT member.mem_id, member.member_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member,cart,prod
WHERE member.mem_id = cart.cart_prod AND cart.cart_prod = prod.prod_id;
