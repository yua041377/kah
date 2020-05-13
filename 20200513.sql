CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM DEPT
WHERE 1 = 1;

SELECT *
FROM DEPT_TEST2;

CREATE UNIQUE INDEX idx_DEPT_TEST1 ON dept_test2(deptno);
CREATE INDEX idx_DEPT_TEST4 ON dept_test2(dname);
CREATE INDEX idx_DEXT_TEST5 ON dept_test2(deptno,dname);

DROP INDEX idx_DEPT_TEST1;
DROP INDEX idx_DEPT_TEST4;
DROP INDEX idx_DEXT_TEST5;

SELECT *
FROM emp;

CREATE INDEX idx_emp ON emp(empno);
CREATE INDEX idx_emp1 ON emp(ename);
CREATE INDEX idx_emp2 ON emp(empno,deptno);
CREATE INDEX idx_emp3 ON emp(sal,deptno);
CREATE INDEX idx_emp4 ON emp(mgr,deptno);
CREATE INDEX idx_emp5 ON emp(deptno,hiredate);

�����ȹ

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������! ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
            ���� ������ ��� ����� ���� ������ �Ǵ� ���� ���
self join : ���� ���̺� ���� ���� �ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺��� ������ ���� ����, 3���� ����� ���� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop join
2. Sort Merge join
3. Bash join

OLTP(OnLine Transaction Processing) : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OLAP(OnLine Analysis Processing) : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿� �� ���(���� ���� ���, ������ �ѹ��� ���)

