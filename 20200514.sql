�����ȹ : SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
    ����ϴµ� ��� ���� ����� �ʿ�(�ð�) 
    
2���� ���̺��� �����ϴ� SQL
2���� ���̺��� ���� �ε����� 5���� �ִٸ�
������ �����ȹ ���� �?? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ�.(������ ���� �ؾ��ϹǷ�)

���� ������ SQL�� ����� ��� �ۼ��� �����ȹ�� ������ ���
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ�.(���ҽ� ����)

���̺� ���� ��� : ���̺� ��ü(1), ������ �ε���(5)
a => b
b => a
����� �� : 36�� & 2�� = 72��

������ SQL �̶� : SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
�Ʒ� �ΰ��� sql�� ���� �ٸ� SQL�� �ν��Ѵ�.
SELECT * FROM emp;
select * FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ�
select /*202004_B*/ * 
FROM emp
WHERE empno = :empno;

SELECT *
FROM user_tables;

Data Dictionary : �ý��� ������ �� �� �ִ� view, ����Ŭ�� ��ü������ ����
catagory (���ξ�)
USER : �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
ALL : �ش� ����� ���� + ������ �ο����� ��ü ���
DBA : ��� ��ü���
V$ : ����, �ý��� ����

SELECT *
FROM user_tables;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM dictionary;

Multiple insert : �������� �����͸� ���ÿ� �Է��ϴ� insert�� Ȯ�� ����
 1. unconditional insert : ������ ���� ���� ���̺��� �Է��ϴ� ���
 ���� : 
    INSERT ALL
        INTO ���̺���
        [,INTO ���̺��� ]
    VALUES(...) | SELECT QUERY;

SELECT *
FROM emp_test;

emp_test ���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1 = 2;

EMPNO, ENAME, DEPTNO

emp_test, emp_test2 ���̺��� ���ÿ� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
    
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test

2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����

SELECT ����� ���� ���� EMPNO = 9998�̸� EMP_TEST���� �����͸� �Է�
                    �׿ܿ��� EMP_TEST2�� �����͸� �Է�

INSERT ALL 
    WHEN ���� ... THEN
        INTO �Է� ���̺� VALUES
    WHEN ���� ... THEN
        INTO �Է� ���̺�2 VALUES
    ELSE 
        INTO �Է� ���̺�3 VALUES
INSERT ALL
    WHEN empno = 9998 THEN
        INTO emp_test VALUES(empno, ename, deptno)
    ELSE
        INTO emp_test2(empno, deptno) VALUES(empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

conditional insert (all) ==> first : ������ �����ϴ� ù ��° WHEN ���� ����
INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES(empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES(empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual; 

SELECT *
FROM emp_test2;

SELECT *
FROM emp_test;

MERGE : �ϳ��� ������ ���� �ٸ� ���̺��� �����͸� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
���� :
MERGE INTO ���� ���(emp_test)
USING (�ٸ� ���̺� | VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN 
    INSERT (COll, col2...) VALUES(value1, value2...)
WHEN MATCHED THEN
    UPDATE SET coll= value1, col2 = value2

1. �ٸ� �����ͷ� ���� Ư�� ���̺��� �����͸� ���� �ϴ� ���

2. KEY�� ���� ��� INSERT 
   KEY�� ���� �� UPDATE 

emp���̺��� �����͸� emp_test ���̺��� ����
emp���̺����� �����ϰ� emp_test ���̺����� �������� �ʴ� ������ �ű� �Է�
emp���̺����� �����ϰ� emp_test ���̺����� �������� �ʴ� ������ ����

INSERT INTO emp_test VALUES(7369,'cony',88);
SELECT *
FROM emp_test;

emp���̺��� 14�� �����͸� emp_test ���̺��� ������ empno�� �����ϴ��� �˻��ؼ�
������ empno�� ������ insert-empno, ename, ������ empno�� ������ update-ename
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT(empno, ename) VALUES(emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;

SELECT *
FROM emp_test;


9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ� ���� ��
(����ڰ� 9999��, james ����� ����ϰų�, ������Ʈ �ϰ� ���� ��)
���� ���� ���̺� ==> �ٸ� ���̺��� ����
�̹��� �ϴ� �ó����� : �����͸� ==> Ư�� ���̺��� ����
(9999,james)

MERGE ������ ������� ������

������ ���� ������ ���� SELECT ����
SELECT *
FROM emp_test
WHERE empno = 9999;

�����Ͱ� ������ ==> UPDATE, �����Ͱ� ������ ==> INSERT

MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm FROM dual) a
    ON(emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999,'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

SELECT *
FROM emp_test;

SELECT deptno,SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT NULL,SUM(sal)
FROM emp;

REPORT GROUP FUNCTION
emp���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿� �հ�, ��ü������ �޿����� ��ȸ�ϱ� ����
GROUP BY�� ����ϴ� �ΰ��� SQL�� ������ �ϳ��� ��ġ�� (UNION) �۾��� ����

Ȯ��� GROUP BY 3����
1. GROUP BY ROLLUP
���� : GROUP BY ROLLUP(�÷�1, �÷�2 .....)
���� : ����׷��� ������ִ� �뵵
����׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ��� ���� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ����׷��� UNION�� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(job,deptno);

����׷� : 1. GROUP BY job, deptno
            UNION
        2. GROUP BY job
            UNION
         3. ��ü�� GROUP BY

==> GROUP BY ROLLUP ���� ����
SELECT deptno,SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

����׷��� ������ : ROLLUP ���� ����� �÷� ���� + 1;



