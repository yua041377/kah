CREATE OR REPLACE PROCEDURE pro_3_dt2 IS

    TYPE dt2_table IS TABLE OF dt2%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt2_table dt2_table;

    sumValue NUMBER := 0;
        
BEGIN
    SELECT * BULK COLLECT INTO v_dt2_table
    FROM dt2
    ORDER BY n DESC;
    
    FOR i IN 1..v_dt2_table.COUNT-1 LOOP
        sumValue := sumValue + v_dt2_table(i).n - v_dt2_table(i+1).n;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(sumValue);
    DBMS_OUTPUT.PUT_LINE(sumValue / (v_dt2_table.COUNT - 1));
    
--    FOR dt2ROW IN dt2_cursor LOOP
--        IF countValue = 0 THEN
--            lastValue := dt2ROW.n;
--        ELSE
--            sumValue := sumValue + lastValue - dt2ROW.n;
--            lastValue := dt2ROW.n;
--        END IF;
--        
--        countValue := countValue + 1;
--    END LOOP;
--    DBMS_OUTPUT.PUT_LINE(sumValue);
--    DBMS_OUTPUT.PUT_LINE((countValue - 1));
--    DBMS_OUTPUT.PUT_LINE(sumValue / (countValue - 1));
END;
/

PL/SQL : ȣ��ȣ�� ���� ����, �и��� �ʿ��� ���� ����(������ �����ϰ� ��ټ��� �κ��� �����Ϳ� ���õǾ��� ��)

�׷��� ���� ���� ��κ� �䱸������ SQL�� �ذ��� ����

�� ���� ��� ȭ�鿡 ��Ÿ������ �ϴ°� ������ ��հ� : 5
PL/SQL, SQL�� ����ϵ� 5��� ���� ����� ���� ������ �޼�.

SELECT *
FROM dt2;

1] �м��Լ�
(SELECT n, LEAD(n) OVER (ORDER BY n DESC) diff
FROM dt2);

2] ����

SELECT a.n, b.n
FROM dt2 a, dt2 b
WHERE b.rn = a.rn + 1;

SELECT AVG(a.n - b.n)
FROM
(SELECT ROWNUM rn, n
FROM
    (SELECT n
    FROM dt2
    ORDER BY n DESC)) a,
(SELECT ROWNUM rn, n
FROM
    (SELECT n
    FROM dt2
    ORDER BY n DESC)) b
WHERE b.rn = a.rn + 1;

3] �����Լ�
SELECT ((MAX(n) - MIN(n)) / (COUNT(*) - 1)
FROM dt2;

4] cycle ���̺�(��������)�� �̿��Ͽ� daily ���̺� �����͸� ���� ���ִ� ���ν���
����� �Ѻ��� �����ϴ� �� 2~300��
���Ѹ�� ��ǰ�� 2~3�� ���� ����
�Ͻ��� (�Ѵ� 20���� ������) 40000~60000�� ������ ������

cycle ���̺�
cid, pid,    day,    cnt
1    100  2020/05/04  1 : 1�� ���� 100�� ��ǰ�� 2020/05/04 �����ϳ� 1�� �Դ´�
1    100  2020/05/11  1 : 1�� ���� 100�� ��ǰ�� 2020/05/11 �����ϳ� 1�� �Դ´�
1    100  2020/05/18  1 : 1�� ���� 100�� ��ǰ�� 2020/05/18 �����ϳ� 1�� �Դ´�
1    100  2020/05/25  1 : 1�� ���� 100�� ��ǰ�� 2020/05/25 �����ϳ� 1�� �Դ´�

sales ���̺�
cid, pid, dt, cnt

SELECT *
FROM cycle;

select *
from daily;

2020�� 5���� ���� ��¥, ���� ������ ���� ���̺� ����

'202005' ==> :yyyymm
SELECT TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1),'YYYYMMDD') DT,
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')+ (LEVEL - 1)),'D') d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD');

CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN VARCHAR2) IS
--    �����ֱ� Ŀ��
    CURSOR cycle_cur IS
        SELECT *
        FROM cycle;
--    �޷� ���̺��� ���� ����(�������� ��, ���� Ư�� ���̺� ���ϴ� ��찡 �ƴ�.)
    TYPE cal_rec_type IS RECORD (
        dt VARCHAR2(8),
        d VARCHAR2(1)
    );
    
    TYPE cal_rec_tab_type IS TABLE OF cal_rec_type INDEX BY BINARY_INTEGER;
    cal_rec_tab cal_rec_tab_type;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
           BULK COLLECT INTO cal_rec_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')), 'DD');
    
--    Ŀ���� ������ ���鼭(outer loop)
--    �ش� ���� �������������� ��ġ�ϴ� �޷����̺��� ���ڸ� ã�Ƽ�
--    ��ġ�� ��� SALES ���̺� ����
    
    FOR cycle_row IN cycle_cur LOOP
        FOR i IN 1..cal_rec_tab.COUNT LOOP
--            �������� �����ֱ� ���ϰ� �޷��� ������ ���� ��
            IF cycle_row.day = cal_rec_tab(i).d THEN
                 INSERT INTO daily VALUES ( cycle_row.cid,
                                            cycle_row.pid,
                                            cal_rec_tab(i).dt,
                                            cycle_row.cnt);
            END IF;
        END LOOP;
    END LOOP;
END;
/


SET SERVEROUTPUT ON;
EXEC create_daily_sales('202005');

SELECT *
FROM daily;

SELECT *
FROM cycle;
WHERE cid = 1
AND pid = 100;


EXEC pro_3_dt2;
SELECT *
FROM dt2
ORDER BY DESC;

TRUNCATE TABLE DAILY;

SELECT *
FROM daily;

INSERT INTO daily
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
       TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.d;

TRUNCATE TABLE DAILY;

SELECT *
FROM daily;

INSERT INTO daily
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1) dt,
       TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.d;

CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN VARCHAR2) IS
--    �����ֱ� Ŀ��
    CURSOR cycle_cur IS
        SELECT *
        FROM cycle;
--    �޷� ���̺��� ���� ����(�������� ��, ���� Ư�� ���̺� ���ϴ� ��찡 �ƴ�.)
    TYPE cal_rec_type IS RECORD (
        dt VARCHAR2(8),
        d VARCHAR2(1)
    );
    
    TYPE cal_rec_tab_type IS TABLE OF cal_rec_type INDEX BY BINARY_INTEGER;
    cal_rec_tab cal_rec_tab_type;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL - 1), 'D') d
           BULK COLLECT INTO cal_rec_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')), 'DD');
    
--    ���� ���࿡ ���ؼ� ������ �����ʹ� �����Ѵ�
    DELETE daily
    WHERE dt BETWEEN TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM'), 'YYYYMMDD') AND
                     TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')), 'YYYYMMDD');
    
--    Ŀ���� ������ ���鼭(outer loop)
--    �ش� ���� �������������� ��ġ�ϴ� �޷����̺��� ���ڸ� ã�Ƽ�
--    ��ġ�� ��� SALES ���̺� ����
    
    FOR cycle_row IN cycle_cur LOOP
        FOR i IN 1..cal_rec_tab.COUNT LOOP
--            �������� �����ֱ� ���ϰ� �޷��� ������ ���� ��
            IF cycle_row.day = cal_rec_tab(i).d THEN
                 INSERT INTO daily VALUES ( cycle_row.cid,
                                            cycle_row.pid,
                                            cal_rec_tab(i).dt,
                                            cycle_row.cnt);
            END IF;
        END LOOP;
    END LOOP;
END;
/

INSERT INTO daily VALUES (1, 100, '20200801', 5);

EXEC create_daily_sales('202005');

SELECT *
FROM daily;

EXCEPTION

DECLARE
    v_ename emp.ename%TYPE;
BEGIN 
--    ���� ����� �������ε� ������ ��Į�� ���� ==> ���̺� Ÿ���� ������ �����ؾ� �Ѵ�.
    SELECT ename INTO v_ename
    FROM emp;
END;
/
SELECT ename INTO
FROM emp;

����� ���� ���� : ����Ŭ���� ������ ���ܰ� �ƴ϶� �����ڰ� ���� ������ ����
java������ �ݵ�� ó���� �ؾ��ϴ� ���ܸ� ��Ƽ� �ش� ȸ�糪 �����ڰ� ������ ���ܷ� �ٲپ ó���� �� �ִ�.
mybatic�� ���� ORM(Object Realtion mapping) �����ӿ�ũ ������ jdbc ���α׷��ֿ��� �ݵ�� ���� �ϴ�
SQLException(checked exception)�� ���� ���Ǹ� ���� �����ӿ�ũ���� ������ ���ܷ� ġȯ�Ͽ� ����Ѵ�.

SELECT ����� ���� �� ==> NO_DATA_FOUND

�Ʒ� ������ Ư�� ������ ��ȸ�ϱ� ���� ����
���࿡ �ش��ϴ� �����Ͱ� ���� �� NO_DATA_FOUND
==> NO_EMP ������ ���� ���ܷ� ġȯ�Ͽ� �ǹ̻����� ���� ��Ȯ�ϰ� ǥ��

SELECT *
FROM emp
WHERE empno = :empno;

DECLARE
    ����� ���� ����
    NO_EMP EXCEPTION;
    v_ename emp.ename%TYPE
BEGIN
    BEGIN ename INTO v_ename
    FROM emp
    WHERE empno = 9999;
    EXCEPTION
        WHEN NO_DATA_FOUND
        NO_EMP ���ܷ� ġȯ�Ͽ� ���ܸ� ������
        RAISE NO_EMP; 
    END;
EXCEPTION
    WHEN NO_EMP THEN
        DBMS_OUTPUT.PUT_LINE('NO_EMP');
END;
/

function : ���ϰ��� �ִ� pl/sql ��
�����ȣ�� �Է¹޾� �ش����� �̸��� �����ϴ� function : getEmpName ����

create or replace function getEmpName(p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
END;
/

SELECT getEmpName(7369)
FROM dual;



select *
from emp;

CREATE OR REPLACE FUNCTION getdeptname(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;
END;
/

function2] �Լ��� ���鶧 � ���ڰ� �ʿ�����,
���������� ���踦 ���� �� � ������ �߻��ϴ���
select deptcd, lpad(' ',(LEVEL - 1) * 4, ' ') || deptno deptnm
SELECT deptcd, indent() || deptnm deptnm
from dept_h
start with p_deptcd is null
connect by prior deptcd = p_deptcd;

SELECT deptcd, LPAD(' ',(LEVEL - 1) * 4, ' ') || deptnm deptnm
SELECT deptcd, INDENT(LEVEL,' ') || deptnm deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;

CREATE OR REPLACE FUNCTION INDENT (lv NUMBER, padString VARCHAR2) RETURN VARCHAR2 IS
    indent_string VARCHAR2(50) := '';
BEGIN
    SELECT LPAD(' ',(lv - 1) * 4, padString) INTO indent_string
    FROM dual;
    
    RETURN indent_string;
END;
/

SELECT getdeptname(40)
FROM dual;

select *
from dept;