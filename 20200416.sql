SELECT *  --모든 컬럼정보를 조회
FROM prod;  --데이터를 조회할 테이블 기술 

-- 특정 컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2.....
prod_id, prod_name 컬럼만 prod 테이블에서 조회;

SELECT prod_id, prod_name
FROM prod;

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_nmae
FROM member;

SELECT *
FROM USERS;

SELECT userid, reg_dt + 5 after_5days, reg_dt - 5
FROM users;

SELECT userid as id, userid id2, userid 아이디
FROM users;


SELECT prod_id as id, prod_name as name
FROM prod;

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름 
FROM buyer;

문자열 연산(결합연산) : || (문자열 결합은 + 연산자가 아니다)
string str = "hello";
str = str + ", world"; //str : hello,world
SELECT /*userid 'test'*/userid ||'text', reg_dt + 5, 'test',15
FROM users;

SELECT '경' || userid || ' 축'
FROM users;

SELECT userid || usernm as id_name
FROM users;

SELECT userid || usernm as id_name,
    CONCAT(userid,usernm) as concat_id_name
FROM users;

user_tables : oracle 관리하는 테이블 정보를 담고 있는 테이블(view) -> data dictionary

SELECT 'SELECT * FROM ' || table_name || ';' as QUERY
FROM user_tables;

테이블의 구성 컬럼을 확인
1. tool(sql developer)을 통해 확인
    테이블 - 확인하고자 하는 테이블

2. SELECT *
   FROM 테이블
   일단 전체 조회 -> 모든 컬럼이 표시

3. DESC 테이블명

4. data dictionary : user_tab_columns

SELECT *
FROM user_tab_columns;


java의 비교 연산 : a변수와 b변수의 값이 같은지 비교 ==
sql 비교 연산 : = 
int a = 5;
int b = 2;
if(a == b) {
}

SELECT *
FROM users
WHERE userid = 'cony';

SELECT *
FROM users

DESC emp;
SELECT *
FROM emp;

emp : employee
empno : 사원번호
ename : 사원이름
job : 담당업무(직책)
mgr : 담당자(관리자)
hiredate : 입사일자
sal : 급여
comm : 성과금
deptno : 부서번호

SELECT *
FROM dept;

emp 테이블에서 직원이 속한 부서번호가 30과 같거나 큰(>) 부서에 속한 직원을 조회;
SELECT *
FROM emp
WHERE deptno >= 30;

!= 다를때
users 테이블에서 사용자 아이디가(userid)가 brown이 아닌 사용자를 조회
SELECT *
FROM users
WHERE userid != 'brown';

 SQL 리터럴
 숫자 :  .... 20, 30.5
 문자 : 싱글 쿼테이션 : 'hello world'
 날짜 : TO_DATE('날짜문자열', '날짜 문자열의 형식');
 
 1982년 1월 1일 이후에 입사한 직원만 조회
 직원의 입사일자 : hiredate 컬럼
 SELECT *
 FROM emp
 WHERE hiredate < TO_DATE('19820101','YYYYMMDD');
 
