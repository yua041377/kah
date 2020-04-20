table에는 조회/저장 순서가 없다.
ORDER BY 컬럼명 정렬방식,.....

ORDER BY 컬럼순서 번호

SELECT의 3번째 컬럼을 기준으로 정렬
SELECT *
FROM emp
ORDER BY 3;

별칭으로 정렬
컬럼에다가 연산을 통해 새로운 컬럼을 만드는 경우
SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

SELECT *
FROM dept
ORDER BY dname asc;

SELECT *
FROM dept
ORDER BY loc desc;

SELECT * 
FROM emp
WHERE comm != 0
ORDER BY comm desc, empno asc; 

SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job asc, empno desc;

SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30)
AND sal > 1500
ORDER BY ename desc;

SELECT ROWNUM, empno, ename 
FROM emp;

SELECT절에 *표기하고 콤마를 통해 다른 표현(ex ROWNUM)을 기술할 경우
* 앞에 어떤 테이블에 대한건지 테이블 명칭/별칭을 기술해야 한다.
SELECT ROWNUM, e.*
FROM emp e;

페이징 처리를 하기 위해 필요한 사항
1. 페이지 사이즈(10)
2. 데이터 정렬 기준

1-page : 1~10
2-page : 11~20 (실제 데이터 : 11~14)

1. 페이지 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2. 페이지 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM의 특징
1. ORACLE에만 존재
    - 다른 DBMS의 경우 페이징 처리를 위한 별도의 키워드가 제공(LIMIT)
2. 1번부터 순차적으로 읽는경우만 가능
    ROWNUM BETWEEN 1 AND 10 --> 1 ~ 10
    ROWNUM BETWEEN 11 AND 20 --> 1 ~10 SKIP 하고 11~ 20을 읽으려고 시도
    
    WHERE 절에 ROWNUM을 사용할 경우 다음 형태
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= N (1 ~ N)
    
ROWNUM과 ORDER BY 
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY empno;
    
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY ename;
    
SELECT -> ROWNUM -> ORDER BY

ROWNUM의 실행순서에 의해 정렬의 된상태로 ROWNUM을 부여하려면 IN-LINE VIEW를 사용해야 한다.
** IN-LINE : 직접 기술을 했다.

SELECT a.*
FROM 
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename) a ) a
WHERE rn BETWEEN 1 + (:page -  1) * :pageSize AND :page * : pageSize;

WHERE rn BETWEEN 1 AND 10; 1 PAGE
WHERE rn BETWEEN 11 AND 20; 1 PAGE
WHERE rn BETWEEN 21 AND 30; 1 PAGE

WHERE rn BETWEEN 1+(n-1)*10 AND PageSize * n ; n PAGE

INLINE-VIEW와 비교를 위해 VIEW를 직접 생성(선행학습, 나중에 나온다)
VIEW - 쿼리

DML - SELECT, INSERT, UPDATE, DELETE
DDL - CREATE, DROP, MODIFY, RENAME

CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
    
SELECT *
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);
    
VIEW로 작성한 쿼리
SELECT *
FROM emp_ord_by_ename;

emp 테이블에 데이터를 추가하면
in-line view, view를 사용한 쿼리의 결과는 어떻게 영향을 받을까?

쿼리 작성시 문제점 찾아가기
java : 디버깅
sql : 디버깅 툴이 없어

페이징 처리 ==> 정렬, ROWNUM
정렬, ROWNUM을 하나의 쿼리에서 실행할 경우 ROWNUM 이후 정렬을 하여 숫자가 섞이는 현상이 발생 ==> INLINE-VIEW
    정렬에 대한 INLINE-VIEW
    ROWNUM에 대한 INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn, b.*
FROM
 (SELECT empno, ename
 FROM emp
 ORDER BY ename) b )
 WHERE rn BETWEEN 11 AND 20;

SELECT *
FROM
(SELECT ROWNUM rn, c.*
FROM
(SELECT empno, ename
FROM emp 
ORDER BY ename) c )
WHERE rn BETWEEN 11 AND 20;

// PROD 테이블을 prod_LGU (내림차순), PROD_COST (오름 차순)으로 정렬하여 
페이징 처리 쿼리를 작성 하세요.단 페이지 사이즈 : 5, 바인드 변수를 사용할 것
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod
ORDER BY prod_lgu desc, prod_cost asc) a )
WHERE rn BETWEEN 1 + (:page -  1) * :pageSize AND :page * : pageSize;

