EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

2-1-0

ROWID : ���̺� ���� ����� �����ּ�
        (java - �ν��Ͻ� ����
            c - ������)
SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
SELECT *
FROM emp
WHERE ROWID = 'AAAE5xAAFAAAAEUAAA';

SELECT *
FROM TABLE(dbms_xplan.display);


INDEX �ǽ�
1. emp ���̺��� ���� ������ pk_emp PRIMARY KEY ���������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ

2. emp ���̺� empno �÷����� PRIMARY KEY �������� ���� �� ���
(empno �÷����� ����� unique �ε����� ����)
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

3. 2�� SQL�� ����(SELECT �÷��� ����)

2��
SELECT *
FROM emp
WHERE empno = 7782;

3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

4. empno �÷��� non-unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

5. emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ���� ��
�����ε���
idx_emp_01 : empno

SELECT *
FROM emp
WHERE job = 'MANAGER';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'; 

idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ�
sql������ ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������.

==> idx_emp_02 (job) ������ �� �� �����ȹ ��
CREATE INDEX idx_emp_02 ON emp(job);

6. emp ���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE 'C%';

7. emp ���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ
��, ���ο� �ε��� �߰� : idx_emp_03 : job, ename
CREATE INDEX idx_emp_03 ON emp(job, ename);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

8. emp ���̺��� job = 'MANAGER' �̸鼭 ename �� C�� ������ ����� ��ȸ(��ü�÷� ��ȸ)

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER' AND ename LIKE '%C';

9. ���� �÷� �ε����� �÷� ������ �߿伺
���� �ε��� ���� : idx_emp_03;
DROP INDEX idx_emp_03;

�ε��� ���� �÷� : (job, ename) vs (ename, job)
-> �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�.

���� sql : job = manager, ename�� C�� �����ϴ� ��� ������ ��ȸ(��ü �÷�)
�ε��� �ű� ����
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp(ename, job);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER' AND ename LIKE 'C%';

���ο����� �ε���
idx_emp_01 ����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;
emp ���̺� empno �÷��� PRIMARY KEY�� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

�ε��� ��Ȳ
pk_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno AND emp.empno = 7788;


