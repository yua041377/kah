페이징 처리
- ROWNUM
- INLINE-VIEW(오라클 한정)
- 페이징 공식
- 바인드 변수

프로그래밍 언어, 식별이름 부여

DUAL TABLE
SYS 계정에 속해 있는 테이블
오라클의 모든 사용자가 공통으로 사용할 수 있는 테이블

한개의 행, 하나의 컬럼(dummy) - 같은 'X';

SELECT *
FROM dual;

사용 용도
1. 함수를 테스트할 목적
2. merge 구문
3. 데이터 복제

오라클 내장 함수 테스트(대소문자 관련)
LOWER, UPPER, INITCAP : 인자로 문자열 하나를 받는다.
SELECT *
FROM dual;

SELECT LOWER('Hello, World')
FROM dual;

SELECT UPPER('Hello, World')
FROM dual;

SELECT INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM emp;

SELECT empno, 5, 'test', LOWER('Hello, World')
FROM emp;

emp 테이블의 SMITH 사원의 이름은 대문자로 지정되어 있음

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; -- 이런식으로 작성하면 안된다.
WHERE ename = UPPER('smith'); -- 두가지 방식 중에는 위에보다는 아래방식이 올바른 방식이다.
--> WHERE ename = 'smith';
WHERE ename = 'smith'; --테이블에는 데이터 값이 대문자로 저장되어 있으므로 조회건수 0
WHERE ename = 'SMITH'; -- 정상 실행

문자열 연산 함수
CONCAT : 2개의 문자열을 입력으로 받아, 결핪한 문자열을 반환한다.


SELECT CONCAT('start', 'end')
FROM dual;

SELECT  
   table_name, tablespace_name, CONCAT('start', 'end'),
    CONCAT(table_name, tablespace_name),
    CONCAT('SELECT * FROM', CONCAT(table_name, ';'))
FROM user_tables;

SELECT 
    CONCAT('SELECT * FROM', CONCAT(table_name, ';'))
FROM user_tables;

SUBSTR(문자열, 시작인덱스, 종료 인덱스) : 문자열의 시작인데스 부터 .... 종료 인덱스 까지의 부분 문자열
시작인덱스는 1부터 (*java의 경우는 0부터)
SELECT SUBSTR('Hello, World',1,5) sub
FROM dual;

LENGTH(문자열) : 문자열의 길이를 반환
SELECT SUBSTR('Hello, World',1,5) sub,
        LENGTH('Hello, World')len
FROM dual;

INSTR(문자열, 찾을 문자열) : 문자열에서 찾을 문자열이 존재하는지, 존재할 경우 찾을 문자열의 인덱스(위치) 반환
SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins
FROM dual;

SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2,
    INSTR('Hello, World','o', INSER('Hello, World','o') + 1) ins3
FROM dual;

LPAD, PRAD ( 문자열, 맞추고 싶은 전체 문자열 길이, 패딩 문자열 - 기본 값은 공백)
REPLACE (문자열, 검색할 문자열, 변경할 문자열) : 문자열에서 검색할 문자열 찾아 변경할 문자열 변경로 변경
SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2,
    INSTR('Hello, World','o', INSTR('Hello, World','o') + 1) ins3,
    LPAD('Hello', 15, '*') lp,
    RPAD('Hello',15,'*') rp,
    REPLACE('Hello, World','ll','LL') rep,
    TRIM('     Hello    ')tr,
    TRIM('H' FROM 'Hello') tr2
FROM dual;

NUMBER 관련 함수
ROUND(숫자, 반올림 위치) : 반올림
    ROUND(105.54, 1) : 소수점 첫번째자리까지 결과를 생성 ==> 소수점 두번째 자리에서 반올림
    : 105.5
TRUNC(숫자, 내림 위치) : 내림
MOD(피제수, 제수) 나머지 연산

SELECT ROUND(105.54,1) round,
       ROUND(105.55,1) round2,
       ROUND(105.55,1) round3,
       ROUND(105.55,-1) round4
FROM dual;

SELECT TRUNC(105.54,1) trunc,
       TRUNC(105.55,1) trunc2,
       TRUNC(105.55,1) trunc3,
       TRUNC(105.55,-1) trunc4
FROM dual;

SELECT MOD(10,3),sal, MOD(sal,1000)
FROM emp;

날짜 관련 함수
SYSDATE : 사용중인 오라클 데이터베이스 서버의 현재 시간, 날짜를 변환한다.
        함수이지만 인자가 없는 함수
        (인자가 없을 경우 JAVA : 메소드()
                        SQL : 함수명

SELECT SYSDATE
FROM dual;

정수 1 = 하루 라는 의미
1/24 = 한시간
1/24/60 = 일분
SELECT SYSDATE, SYSDATE + 5
FROM dual;

리터럴
숫자 : ....
문자 : ''
날짜 : TO_DATE('날짜 문자열','포맷')

SELECT TO_DATE('20191231','YYYYMMDD') LASTDAY,
      TO_DATE('20191231','YYYYMMDD') - 5 LASTDAY_BEFORES,
      SYSDATE NOW,
      SYSDATE - 3 NOW_BEFORE3
FROM dual;

TO_DATE(문자열, 포맷) : 문자열을 포맷에 맞게 해석하여 날짜 타입으로 형변환
TO_CHAR(날짜, 포맷) : 날짜타입을 포맷에 맞게 문자열로 변환
YYYY : 년도
MM : 월
DD : 일자
D : 주간일자(1~7, 1- 일요일, 2- 월요일... 7- 토요일)
IW : 주차 (52~53)
HH : 시간(12시간)
HH24 : 24시간 표기
MI : 분
SS : 초
현재시간(SYSDATE) 시분초 단위까지 표현 -> TO_CHAR를 이용하여 형변환

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
       TO_CHAR(SYSDATE, 'D') d,
       TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
       TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual; 

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
      TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) : DATE1과 DATE2 사이의 개월수를 반환
4가지 날짜 관련함수 중에 사용 빈도가 낮음
SELECT MONTHS_BETWEEN (TO_DATE('2020/04/21' ,'YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD')),
       MONTHS_BETWEEN (TO_DATE('2020/04/22' ,'YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, 가감할 개월수) : DATE1로 부터 두번째 입력된 개월수 만큼 가감한 DATE
오늘 날짜로부터 6개월 뒤 날짜

SELECT ADD_MONTHS(SYSDATE, 5) dtl,
       ADD_MONTHS(SYSDATE, - 5) dt2
FROM dual;

NEXT_DAY(date1, 주간일자) date 이후 등장하는 첫번째 주간일자의 날짜를 반환
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(DATE1) DATE1이 속한 월의 마지막 일자를 날짜를 반환
SYSDATE : 2020/04/21 --> 2020/04/30
SELECT LAST_DAY(SYSDATE)
FROM dual;

날짜가 속한 월의 첫번째 날짜 구하기(1일)
SYSDATE : 2020/04/21 -> 2020/04/01;
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1,
        ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1)
FROM dual;

SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1,
        ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01')
FROM dual;