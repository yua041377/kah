

SELECT TO_DATE(:yyyymm,'YYYYMM'),
    LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),
    TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD')
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------


 
   1 - filter(TO_CHAR("EMPNO")='7369')

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
   
SELECT *
FROM dept;

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp; 

NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE;

왜 null 처리를 해야 할까?
NULL에 대한 연산의 결과는 NULL이다.

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
다음과 같이 SQL 을 작성.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

SELECT empno, ename, sal, comm, sal, + NVL(comm, 0) sal_plus_comm
FROM emp;

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt, TO_CHAR(NVL(reg_dt,LAST_DAY(SYSDATE)),'DD') reg_dt_lastday
FROM users;
