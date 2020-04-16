SELECT 에서 연산 : 
날짜 연산(+, -) : 날짜 + 정수, -정수 : 날짜에서 + - 정수를 한 과거 혹은 미래일자의 데이트 타입 변환
정수 연산(.....) : 수업시간에 다루진 않음....
문자열 연산
    리터럴 : 표기방법
            숫자 리터럴 : 숫자로 표현
            문자 리터럴 : java : "문자열" / sql : 'sql'
                        SELECT SELECT * FROM || table_name
                        SELECT 'SELECT * FROM' || table_name
            문자열 결합연산 : +가 아니라 || (java 에서는 +)
            날짜?? : TO_DATE("날짜문자열", "날짜 문자열에 대한 포맷(YYYYMMDD)")
                    TO_DATE('20200417','YYYYMMDD')
WHERE : 기술한 조건에 만족하는 행만 조회 되도록 제한

SELECT *
FROM users
WHERE userid = 'brown';

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
 AND  sal <= 2000;
 
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN(10,30);

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 30;

SELECT userid 아이디,usernm 이름,alias 별명
FROM users
WHERE userid IN('brown','cony','sally');

SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id,mem_name
FROM member
WHERE mem_name Like '%이%';

SELECT *
FROM emp
WHERE mgr is not null;

SELECT *
FROM emp
WHERE comm is not null;

SELECT *
FROM emp
WHERE mgr = 7698
  OR SAL > 1000;

SELECT *
FROM emp
WHERE mgr IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr in null;

==> WHERE mgr != 7698 AND mgr != 7839
  
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD')
AND sal > 1300;

SELECT *
FROM emp
WHERE deptno IN (20,30) 
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= to_date('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno = 78
OR empno >= 780 AND empno < 790
OR empno >= 7800 AND empno < 7900;
  
SELECT *
FROM emp
WHERE (job = 'SALESMAN'
   OR empno Like '78%') 
   AND hiredate >= TO_DATE('19810601','YYYYMMDD');
   
SELECT *
FROM emp
ORDER BY ename asc;

SELECT *
FROM emp
ORDER BY ename desc;
 
 -- job을 기준으로 오름차순하고, job이 같을경우 입사일자로 내림차순 정렬
SELECT *
FROM emp
ORDER BY job asc, hiredate desc;
  