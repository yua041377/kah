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

��������
IF ����
IF conditio THEN 
    statement;
ELSIF
    statement;
ELSE
    statement;
END IF;

NUMBER Ÿ���� P ������ �����ϰ� 2�� ����
IF ������ ���� P���� üũ�Ͽ� ����ϴ� ����

DECLARE
    p NUMBER := 2;
BEGIN
   /* p�� 1�̸� 1�� ���
    p�� 2�̸� 2�� ���
    �׹��� ���� ���� else�� ��� */
    
    IF p = 1 THEN 
        DBMS_OUTPUT.PUT_LINE('1');
    ELSIF P = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('else');
    END IF;
END;
/

CASE ����
�˻� ���̽�(java switch)
����
    CASE ǥ����
        WHEN VALUE THEN
            statement;
        WHEN VALUE2 THEN
            statement;
        ELSE
            statement;
        END CASE;
�Ϲ� ���̽� : �Ϲݾ���� IF ����, SQL���� ����� CASE ���� �� ����, CASE - END CASE;
    CASE
        WHEN expression THEN
            statement;
        WHEN expression2 THEN
            statement;
���̽� ǥ����
    CASE
        WHEN expression THEN
            ��ȯ�Ұ�;
        WHEN expression2 THEN
            ��ȯ�Ұ�;
        ELSE
            ��ȯ�Ұ�;
    END IF;
END;
/
�˻� ���̽�
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

�Ϲ� ���̽�
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

�ݺ���
�ε��������� �����ڰ� ������ �������� �ʴ´�.
REVERSE �ɼ��� ����ϸ� ���ᰪ���� ���� 1�� �ٿ� ������ �ε��������� ���۰��� �ɶ����� ����
for(int =10; i > 0; i--)

FOR �ε������� IN [REVERSE] ���۰�.. ���ᰪ LOOP
END LOOP;

���̽� ǥ����
DECLARE
BEGIN
    FOR i IN [REVERSE] 1..5 LOOP
END LOOP;
    DBMS_OUTPUT.PUT_LINE(i);
END;
/

2~9�� ������ ����ϱ�
DECLARE
BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' ||  (i*j));
        END LOOP;
    END LOOP;
END;
/

java �ݺ��� ���� : for(���� for), while, do-while

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

CURSOR : SELECT���� ���� ����� �����͸� ����Ű�� ������(�޸�)
SQL�� ����ڰ� DBMS�� ��û�� ������ �� ó�� ����
1. ������ SQL�� ����� ���� �ִ��� Ȯ��(�����ȹ�� �����ϱ� ���ؼ�)
2. ���ε� ���� ����(���ε� ������ ���Ǿ��� ���)
3. ����(execution)
4. ����(fetch)

cursor�� ����ϰ� �Ǹ� ����ܰ踦 �����
==> SELECT ������ ����� ������ ���� �ʰ� CURSOR�� ���� ���� �޸𸮿� ������ �� �ִ�.

PL/SQL�� ��κ��� ������ SELECT ����� Ư�� ������ �����Ͽ� ó���ϴ� ���̱� ������
�ش� ������ SELECT ����� ��� ���� ���ո����� �� �ִ�.

CURSOR ���ܰ�
1. ����
2. ����
3. ����
4. �ݱ�

����
1. ����(DECLARE ��)
    CURSOR Ŀ���̸� IS
    QUERY;
2. ����(BEGIN)
    OPEN Ŀ���̸�;
3. ����(FETCH)
    FETCH Ŀ���̸� INTO variable;
4. �ݱ�(BEGIN)
    CLOSE Ŀ���̸�;

dept ���̺��� ��� ���� ��ȸ�ϰ�, deptno, dname �÷��� Ŀ���� ���ؼ�
��Į�� ����(v_deptno , v_dname)

�������� ��ȸ�ϴ� SELECT ������ ������� �����ϱ� ���ؼ� TABLE TYPE�� ���

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

����� Ŀ���� FOR LOOP ���� ==> ���� ����ϱ� ���� ����
OPEN, CLOSE, FETCH �ϴ� ������ FOR LOOP ���� �ڵ������� �������ش�.
�����ڴ� Ŀ�� ����� FOR LOOP�� Ŀ������ �־��ִ� �ͷ� ������ �ܼ�ȭ

����
FOR ���ڵ��̸�(�� ������ ����) IN Ŀ���̸� LOOP
    ���ڵ��̸�.�÷���
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

�Ķ���Ͱ� �ִ� ����� Ŀ��
�μ���ȣ�� �Է¹޾� where������ ����ϴ� Ŀ���� ����

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

FOR LOOP�� �ζ���(�������) Ŀ��
DECLARE���� Ŀ���� ��������� �������� �ʰ�
FOR LOOP���� SQL�� ���� ���.

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