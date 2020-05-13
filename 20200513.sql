CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM DEPT
WHERE 1 = 1;

SELECT *
FROM DEPT_TEST2;

CREATE UNIQUE INDEX idx_DEPT_TEST1 ON dept_test2(deptno);
CREATE INDEX idx_DEPT_TEST4 ON dept_test2(dname);
CREATE INDEX idx_DEXT_TEST5 ON dept_test2(deptno,dname);

DROP INDEX idx_DEPT_TEST1;
DROP INDEX idx_DEPT_TEST4;
DROP INDEX idx_DEXT_TEST5;

SELECT *
FROM emp;

CREATE INDEX idx_emp ON emp(empno);
CREATE INDEX idx_emp1 ON emp(ename);
CREATE INDEX idx_emp2 ON emp(empno,deptno);
CREATE INDEX idx_emp3 ON emp(sal,deptno);
CREATE INDEX idx_emp4 ON emp(mgr,deptno);
CREATE INDEX idx_emp5 ON emp(deptno,hiredate);

실행계획

수업시간에 배운 조인
==> 논리적 조인 형태를 이야기 함
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이되는 테이블의 컬럼정보를 조회하는 조인 기법
cross join : 묻지마! 조인(카티션 프러덕트), 조인 조건을 기술하지 않아서
            연결 가능한 모든 경우의 수로 조인이 되는 조인 기법
self join : 같은 테이블 끼리 조인 하는 형태

개발자가 DBMS에 SQL을 실행 요청 하면 DBMS는 SQL을 분석해서
어떻게 두 테이블을 연결할 지를 결정, 3가지 방식의 조인 방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop join
2. Sort Merge join
3. Bash join

OLTP(OnLine Transaction Processing) : 실시간 처리 ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
OLAP(OnLine Analysis Processing) : 일괄처리 ==> 전체 처리속도가 중요 한 경우(은행 이자 계산, 새벽에 한번에 계산)

