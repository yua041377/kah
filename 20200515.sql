ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;

GROUP_AD2]

SELECT NVL(job,'�Ѱ�'), deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP(job, deptno); 

SELECT CASE 
       WHEN GROUPING(job) = 1 THEN '�Ѱ�'
       ELSE job
       END
       ,deptno,GROUPING(job),GROUPING(deptno),SUM(sal)
FROM emp
GROUP BY ROLLUP(job, deptno); 



SELECT CASE 
       WHEN GROUPING(job) = 1 THEN '��'
       ELSE job
END job,
       CASE
       WHEN GROUPING(job) = 1 THEN '��'
       WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
       ELSE TO_CHAR(deptno)
       END deptno
      ,SUM(sal) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);

SELECT deptno,job,SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno, job);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��.
(****** ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����)
GROUP BY ROLLUP(deptno, job);
GROUP BY ROLLUP(job, deptno);

SELECT NVL(d.dname,'�Ѱ�'),e.job,SUM(sal)
FROM emp e,dept d
WHERE e.deptno = d.deptno
GROUP BY ROLLUP(d.dname, e.job);

2. GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�.
              ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
             ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
             
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���, ROLLUP���� �ٸ��� ���⼺�� ����.
���� : GROUP BY GROUPING SETS(coll,col2)
GROUP BY coll
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS(coll,col2)
GROUP BY GROUPING SETS(col2,coll)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY deptno;

�׷������
1. job, deptno
2. mgr

GROUP BY GROUPING SETS((job, deptno), mgr)

SELECT job, deptno,mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((job,deptno),mgr);

3. CUBE
���� : GROUP BY CUBE
����� �÷��� ������ ��� ����(������ ��Ų��.)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);

�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2     3
job  deptno  mgr ==> GROUP BY job, deptno, mgr
job  x       mgr ==> GROUP BY job, mgr
job  deptno  x   ==> GROUP BY job, deptno
job  x       x   ==> GROUP BY job

SELECT job,deptno,mgr, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);

1        2         3
job  job,deptno   mgr => GROUP BY job,job,deptno,mgr => GROUP BY job, deptno, mgr;
job  job          mgr => GROUP BY job, job, mgr => GROUP BY job, mgr
job  x            mgr => GROUP BY job,x,mgr => GROUP BY job,mgr
job  job,deptno   x   => GROUP BY job,job,deptno => GROUP BY job, deptno
job  job          x   => GROUP BY job,job,x => GROUP BY job
job  x            x   => GROUP BY job,x => GROUP BY job

��ȣ���� �������� ������Ʈ
1. emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
==> ������ ������ emp_test ���̺� ���� ���� ���� 
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

2. emp_test ���̺� dname �÷� �߰�(dept ���̺� ����)
DESC dept;
ALTER TABLE emp_test ADD(dname VARCHAR2(14));
DESC emp_test;

3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test ���̺��� deptno ���� Ȯ���ؼ� dept ���̺��� deptno ���̶� ��ġ�ϴ� dname �÷����� ������ update

SELECT *
FROM emp_test;

emp_test ���̺��� dname �÷��� dept ���̺� �̿��ؼ� dname �� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����
��� ������ ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname 
                             FROM dept 
                             WHERE emp_test.deptno = dept.deptno);

SELECT *
FROM emp;

SELECT *
FROM dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD(empcnt NUMBER(2));

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp 
                               WHERE dept_test.deptno = emp.deptno);

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1 = 2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����.

SELECT COUNT(*)
FROM emp
WHERE 1 = 2
GROUP BY deptno;








