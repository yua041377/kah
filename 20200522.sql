DECLARE
 TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
 v_dept dept_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;
    
    /*java : for
    int[] arr = new int[20]();
    for(int i = 0; i< array.length; i++){
        System.out.println(arr[i]);    
    }*/
    FOR i IN 1..v_dept.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno || ' / ' || v_dept(i).dname || ' / ' || v_dept(i).loc);
    END LOOP;
END;
/
SET SERVEROUTPUT ON;

조건제어
IF 구문
IF conditio THEN 
    statement;
ELSIF
    statement;
ELSE
    statement;
END IF;

NUMBER 타입의 P 변수를 선언하고 2를 대입
IF 구문을 통해 P값을 체크하여 출력하는 예제

DECLARE
    p NUMBER := 2;
BEGIN
   /* p가 1이면 1을 출력
    p가 2이면 2를 출력
    그밖의 값일 때는 else를 출력 */
    
    IF p = 1 THEN 
        DBMS_OUTPUT.PUT_LINE('1');
    ELSIF P = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('else');
    END IF;
END;
/

CASE 구문
검색 케이스(java switch)
문법
    CASE 표현식
        WHEN VALUE THEN
            statement;
        WHEN VALUE2 THEN
            statement;
        ELSE
            statement;
        END CASE;
일반 케이스 : 일반언어의 IF 구문, SQL에서 배웠던 CASE 구문 과 동일, CASE - END CASE;
    CASE
        WHEN expression THEN
            statement;
        WHEN expression2 THEN
            statement;
케이스 표현식
    CASE
        WHEN expression THEN
            반환할값;
        WHEN expression2 THEN
            반환할값;
        ELSE
            반환할값;
    END IF;
END;
/
검색 케이스
DECLARE
    p NUMBER := 2;
BEGIN
    CASE p
    WHEN 1 THEN 
        DBMS_OUTPUT.PUT_LINE('1');
    WHEN 2 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('else');
    END CASE;
END;
/

일반 케이스
DECLARE
    p NUMBER := 2;
    ret NUMBER := 0;
BEGIN
    ret := CASE 
    WHEN p = 1 THEN 
        4
    WHEN p = 2 THEN
        5
    ELSE
        6
    END;
    DBMS_OUTPUT.PUT_LINE(ret);
END;
/

반복문
인덱스변수는 개발자가 별도로 선언하지 않는다.
REVERSE 옵션을 사용하면 종료값부터 값을 1씩 줄여 나가며 인덱스변수가 시작값이 될때까지 실행
for(int =10; i > 0; i--)

FOR 인덱스변수 IN [REVERSE] 시작값.. 종료값 LOOP
END LOOP;

케이스 표현식
DECLARE
BEGIN
    FOR i IN [REVERSE] 1..5 LOOP
END LOOP;
    DBMS_OUTPUT.PUT_LINE(i);
END;
/

2~9단 구구단 출력하기
DECLARE
BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' ||  (i*j));
        END LOOP;
    END LOOP;
END;
/

java 반복문 종료 : for(향상된 for), while, do-while

LOOP
java : while(true){
            if(condition{
            break;
            }
        }
LOOP
    statement;
    EXIT WHEN condition;
    statement;
EXIT LOOP;

LOOP
java : while(true){
            if(condition{
            break;
            }
        }
DECLARE
    p NUMBER := 1;
BEGIN
    LOOP
    EXIT WHEN i > 5
    DBMS_OUTPUT.PUT_LINE(i);
   i := i + 1;
   END LOOP;
END;
/

CURSOR : SELECT문에 의해 추출된 데이터를 가리키는 포인터(메모리)
SQL을 사용자가 DBMS로 요청을 보냈을 때 처리 순서
1. 동일한 SQL이 실행된 적이 있는지 확인(실행계획을 공유하기 위해서)
2. 바인드 변수 적용(바인드 변수가 사용되었을 경우)
3. 실행(execution)
4. 인출(fetch)

cursor를 사용하게 되면 인출단계를 제어가능
==> SELECT 쿼리의 결과를 변수에 담지 않고 CURSOR를 통해 직접 메모리에 접근할 수 있다.

PL/SQL의 대부분의 로직은 SELECT 결과에 특정 로직을 적용하여 처리하는 것이기 때문에
해당 변수에 SELECT 결과를 담는 것이 비합리적일 수 있다.

CURSOR 사용단계
1. 선언
2. 열기
3. 인출
4. 닫기

문법
1. 선언(DECLARE 절)
    CURSOR 커서이름 IS
    QUERY;
2. 열기(BEGIN)
    OPEN 커서이름;
3. 인출(FETCH)
    FETCH 커서이름 INTO variable;
4. 닫기(BEGIN)
    CLOSE 커서이름;

dept 테이블의 모든 행을 조회하고, deptno, dname 컬럼만 커서를 통해서
스칼라 변수(v_deptno , v_dname)

여러행을 조회하는 SELECT 쿼리의 결과값을 저장하기 위해서 TABLE TYPE을 사용

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    OPEN deptcursor;
    LOOP
        FETCH deptcursor INTO v_deptno, v_dname;
        
        EXIT WHEN deptcursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' / ' || v_dname);
    END LOOP;
    CLOSE deptcursor;
END;
/

명시적 커서와 FOR LOOP 결합 ==> 보다 사용하기 쉬운 형태
OPEN, CLOSE, FETCH 하는 과정을 FOR LOOP 에서 자동적으로 실행해준다.
개발자는 커서 선언과 FOR LOOP에 커서명을 넣어주는 것로 과정을 단순화

문법
FOR 레코드이름(행 정보를 저장) IN 커서이름 LOOP
    레코드이름.컬럼명
END FOR;

DECLARE
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    FOR rec IN deptcursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/

파라미터가 있는 명시적 커서
부서번호를 입력받아 where절에서 사용하는 커서를 선언

DECLARE
    CURSOR deptcursor(p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
BEGIN
    FOR rec IN deptcursor(30) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/

FOR LOOP와 인라인(직접기술) 커서
DECLARE절에 커서를 명시적으로 선언하지 않고
FOR LOOP에서 SQL를 직접 기술.

DECLARE
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' / ' || rec.dname);
    END LOOP;
    
END;
/

CREATE TABLE dt2 AS
SELECT 40 n FROM dual UNION ALL
SELECT 35 n FROM dual UNION ALL
SELECT 30 n FROM dual UNION ALL
SELECT 25 n FROM dual UNION ALL
SELECT 20 n FROM dual UNION ALL
SELECT 15 n FROM dual UNION ALL
SELECT 10 n FROM dual UNION ALL
SELECT 5 n FROM dual;

SELECT *
FROM dt2;

DECLARE
     p NUMBER := 40,35,30,25,20,15,10,5;
BEGIN
    FOR dt IN (SELECT n FROM dt2) LOOP
        DBMS_OUTPUT.PUT_LINE(SUM(n)/(COUNT(*)-1));
    END LOOP;
    
END;
/

int[] arr = new int[]{40,35,30,25,20,15,10,5};
      int sum =0;
      
      for(int i = 0; i< arr.length-1; i++){
         int diff = arr[i] - arr[i+1];
         sum = sum + diff;
      }
         System.out.println(sum/(arr.length-1));   
   }