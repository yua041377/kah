EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

2-1-0

ROWID : 테이블 행이 저장된 물리주소
        (java - 인스턴스 변수
            c - 포인터)
SELECT ROWID, emp.*
FROM emp;

사용자에 의한 ROWID 사용
SELECT *
FROM emp
WHERE ROWID = 'AAAE5xAAFAAAAEUAAA';

SELECT *
FROM TABLE(dbms_xplan.display);


INDEX 실습
1. emp 테이블의 어제 생성한 pk_emp PRIMARY KEY 제약조건을 삭제
ALTER TABLE emp DROP CONSTRAINT pk_emp;

인덱스 없이 empno 값을 이용하여 데이터 조회

2. emp 테이블에 empno 컬럼으로 PRIMARY KEY 제약조건 생성 한 경우
(empno 컬럼으로 생산된 unique 인덱스가 존재)
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

3. 2번 SQL을 변형(SELECT 컬럼을 변형)

2번
SELECT *
FROM emp
WHERE empno = 7782;

3번
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

4. empno 컬럼에 non-unique 인덱스가 생성되어 있는 경우
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

5. emp 테이블의 job 값이 일치하는 데이터를 찾고 싶을 때
보유인덱스
idx_emp_01 : empno

SELECT *
FROM emp
WHERE job = 'MANAGER';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'; 

idx_emp_01의 경우 정렬이 empno컬럼 기준으로 되어 있기 때문에 job 컬럼을 제한하는
sql에서는 효과적으로 사용할 수가 없기 때문에 TABLE 전체 접근하는 형태의 실행계획이 세워짐.

==> idx_emp_02 (job) 생성을 한 후 실행계획 비교
CREATE INDEX idx_emp_02 ON emp(job);

6. emp 테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회
인덱스 현황
idx_emp_01 : empno
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'C%';

7. emp 테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회
단, 새로운 인덱스 추가 : idx_emp_03 : job, ename
CREATE INDEX idx_emp_03 ON emp(job, ename);

인덱스 현황
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

8. emp 테이블에서 job = 'MANAGER' 이면서 ename 이 C로 끝나는 사원만 조회(전체컬럼 조회)

인덱스 현황
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE '%C';

9. 복합 컬럼 인덱스의 컬럼 순서의 중요성
기존 인덱스 삭제 : idx_emp_03;
DROP INDEX idx_emp_03;

인덱스 구성 컬럼 : (job, ename) vs (ename, job)
-> 실행해야 하는 sql에 따라서 인덱스 컬럼 순서를 조정해야 한다.

실행 sql : job = manager, ename이 C로 시작하는 사원 정보를 조회(전체 컬럼)
인덱스 신규 생성
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp(ename, job);

인덱스 현황
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER' AND ename LIKE 'C%';

조인에서의 인덱스
idx_emp_01 삭제(pk_emp 인덱스와 중복)
DROP INDEX idx_emp_01;
emp 테이블에 empno 컬럼을 PRIMARY KEY로 제약조건 생성
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

인덱스 현황
pk_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno AND emp.empno = 7788;


