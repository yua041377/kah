SELECT deptno, job, sum(sal)
FROM emp
GROUP BY ROLLUP(deptno,job);

����׷� ���� ���
ROLLUP : �ڿ���(�����ʿ���) �ϳ��� �������鼭 ����׷� ����
        ==> (deptno, job), (deptno), (�� ��)
CUBE : ������ ��� ����
GROUPING SETS : �����ڰ� ����׷� �������� 

GROUP BY (deptno)

UNION ALL

GROUP BY (job)

DROP TABLE dept_test;

SELECT *
FROM dept;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

INSERT INTO dept_test values(99,'it1','daejeon');
INSERT INTO dept_test values(98,'it2','daejeon');

DELETE FROM dept_test
WHERE deptno NOT IN(SELECT deptno FROM emp);

SELECT * FROM dept_test
WHERE NOT EXISTS(SELECT 'X' FROM emp WHERE emp.deptno = dept_test.deptno);

SELECT *
FROM emp_test;

UPDATE emp_test SET sal = sal + 200 
WHERE sal < (SELECT AVG(sal) FROM emp_test b WHERE 20 = b.deptno GROUP BY deptno);
             
��ȣ���� �������� - update

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� ��������(EXISTS)
        ==> ���� ���� ���� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ

SELECT *
FROM emp 
WHERE mgr IN(SELECT empno FROM emp);

SELECT *
FROM emp 
WHERE mgr IN(7369,7499,7521......);

�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�

�μ��� ��� �޿�(�Ҽ��� ��° �ڸ����� ��� �����)
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno;

��ü �޿� ��� 
SELECT ROUND(AVG(sal),2)
FROM emp;

�Ϲ����� �������� ����
SELECT deptno, ROUND(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT ROUND(AVG(sal),2 FROM emp);

WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
        SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸�
        Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
        ��, �ϳ��� SQL���� �ݺ����� SQL ���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������
        �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ.
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal),2)
    FROM emp
)
SELECT deptno, ROUND(AVG(sal),2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT * FROM emp_avg_sal);

SELECT dual.*,LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

��������
CONNECT BY LEVEL : ���� �ݺ��Ͽ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;

1. �츮���� �־��� ���ڿ� ��� : 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����
    
�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����
SELECT TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt, 7�� �÷��� �߰��� ����
    �Ͽ����̸� dt �÷�, �������̸� dt �÷�, ȭ�����̸� dt �÷�....����� �̸� dt �÷�
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM')),'DD');

�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
SELECT TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt,
      DECODE( TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM') + (LEVEL - 1),'D',TO_DATE('202005','YYYYMM')+ (LEVEL - 1),'1'
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005'
       
SELECT dt ,dt�� �������̸� dt, dt�� ȭ�����̸� dt.....7���� �÷��߿� �� �ϳ��� �÷����� dt ���� ǥ���ȴ�.
FROM
    (SELECT TO_DATE('202005','YYYYMM') + (LEVEL - 1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','YYYYMM')),'DD'));

SELECT DECODE(d,1,iw+1,iw),
        MIN(DECODE(d,1,dt)) sun, MIN(DECODE(d,2,dt)) mon,
        MIN(DECODE(d,3,dt)) tue, 
        MIN(DECODE(d,4,dt)) wed, MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt)) fri, MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1) dt,
    TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1),'D')d,
    TO_DATE(:yyyymm,'yyyymm') + (LEVEL - 1) - TO_CHAR(
    TO_CHAR(TO_DATE(:yyyymm,'YYYYMM') + (LEVEL - 1),'iw') iw 
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')),'DD'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY DECODE(d,1,iw+1,iw);

SELECT TO_CHAR(dt,'mm'),
       CASE(WHEN TO_CHAR(dt,'mm') = 01 THEN 'JAN',
            WHEN TO_CHAR(dt,'mm') = 02 THEN 'FEB',
            WHEN TO_CHAR(dt,'mm') = 03 THEN 'MAR',
            WHEN TO_CHAR(dt,'mm') = 04 THEN 'APR',
            WHEN TO_CHAR(dt,'mm') = 05 THEN 'MAY',
            WHEN TO_CHAR(dt,'mm') = 06 THEN 'JUN')
        END 
FROM sales
GROUP BY TO_CHAR(dt,'mm');






