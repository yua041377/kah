연산자

사칙 연산자 : +, -, *, / : 이항 연산자
삼항 연산자 : ? 1==1 ? true일때 실행 : false 일 때 실행

IN : 컬럼 ! 표현식 IN (집합)
deptno IN (10,30) ==> IN(10,30), deptno (10,30)

EXISTS 연산자
사용방법 : EXISTS (서브쿼리)
서브쿼리의 조회결과가 한건이라도 있으면 TRUE
잘못된 사용방법 : WHERE deptno EXISITS(서브쿼리)

SELECT *
FROM emp
WHERE EXISTS(SELECT 'X' FROM dept);

매니저가 없는 직원 : KING
매니저가 정보가 존재하는 직원 : 14-KING = 13명의 직원
EXISTS 연산자를 활용하여 조회

 -> IS NOT NULL을 통해서도 동일한 결과를 만들어 낼 수 있다.
SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X' 
              FROM emp m
              WHERE e.mgr = m.empno);

SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;


SELECT *
FROM emp
WHERE EXISTS(SELECT 'X' FROM dept);

SELECT *
FROM product p
WHERE EXISTS(SELECT pid FROM cycle c WHERE p.pid = c.pid AND cid = 1);

SELECT *
FROM product;

1번 고객 먹는 제품정보
SELECT *
FROM cycle
WHERE cid = 1;

SELECT *
FROM product p
WHERE NOT EXISTS(SELECT pid FROM cycle c WHERE p.pid = c.pid AND cid = 1);

집합연산
합집합
{1,5,3) U {2,3} = {1,2,3,5}
SQL에만 존재하는 UNION ALL (중복 데이터를 제거 하지 않는다.)
{1,5,3} U {2,3} = {1,5,3,2,3}
교집합
{1,5,3) 교집합 {2,3} = {3}
차집합
{1,5,3} - {2,3} = {1,5}

SQL에서의 집합연산
연산자 : UNION, UNION ALL, INTERSECT, MINUS
두개의 SQL의 실행결과를 행을 확장(위, 아래로 결합 된다)

UNION 연산자 : 중복제거(수학적 개념의 집합과 동일)

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)




UNION ALL 연산자 : 중복허용

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369);

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);




INTERSECT 교집합 : 두집합간 중복되는 요소만 조회
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)




MINUS 연산자 : 위쪽 집합에서 아래쪽 집합 요소를 제거
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

SQL 집합연산자의 특징

열의 이름 : 첫번째 SQL 컬럼을 따라간다.

첫번째 쿼리의 컬럼명에 별칭 부여
SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. 정렬을 하고싶을 경우 마지막에 적용 가능
개별 SQL에는 ORDER BY 불가 (인라인 뷰를 사용하여 메인쿼리에서 ORDER BY 가 기술되지 않으면 가능)

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm;

3. SQL의 집합 연산자는 중복을 제거한다.(수학적 집합 개념과 동일), 단 UNION ALL은 중복 허용

4. 두개의 집합에서 중복을 제거하기 위해 각각의 집합을 정렬하는 작업이 필요
 ==> 사용자에게 결과를 보내주는 반응성이 느려짐.
    ==> UNION ALL을 사용할 수 있는 상황일 경우 UNION을 사용하지 않아야 속도적인 측면에서 유리하다.

4. 알고리즘(정렬 - 버블 정렬, 삽입 정렬, ....., 
        자료 구조 : 트리구조(이진 트리, 밸런스 트리)
                heap 
                stack, queue
                list
                집합연산에서 중요한 사항 : 중복 제거

집합연산에서 중요한 사항 : 중복제거
버블 정렬
for(int = 0; ...){
    for(int j = 1;....){
    }
}               

SELECT *
FROM FASTFOOD;

SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM
(SELECT ROWNUM, bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
                ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx
FROM
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu)kfc,
                        
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '맥도날드'
 GROUP BY sido, sigungu) mac,
                                                 
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
 WHERE gb = '롯데리아'
 GROUP BY sido, sigungu) lot
 
 WHERE bk.sido = kfc.sido
 AND bk.sigungu = kfc.sigungu
 AND bk.sido = mac.sido
 AND bk.sigungu = mac.sigungu
 AND bk.sido = lot.sido
 AND bk.sigungu = lot.sigungu
 ORDER BY city_idx DESC)a;

SELECT *
FROM tax;

과제 1 fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 sql 작성
1. 도시발전지수를 구하고(지수가 높은 도시가 순위가 높다.)
2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 SQL 작성

순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수, 국세청 시도, 국세청 시군구, 국세청 연말정산 금액1인당 신고액

과제 2 햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데(fastfood 테이블을 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선(fastfood 테이블을 1번만 사용)
CASE, DECODE 이용하면 가능)

과제 3
햄버거지수 SQL을 다른형태로 도전하기

사용된 SQL 문법 : WHERE, 그룹연산을 위한 GROUP BY, 복수행 함수(COUNT),
            인라인 뷰, ROWNUM, ORDER BY, 별칭(컬럼, 테이블), ROUND, JOIN










