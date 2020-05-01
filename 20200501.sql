WHERE���� ��밡���� ������
WHERE deptno = 10
==>

�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN(10,30)
WHERE deptno = 10 or deptno = 30;

������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN(�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH - 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLERN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ��� ==> ������������ ��밡���� ������ IN(���̾� �߿�), (ANY, ALL, �󵵰� ����)
SELECT *
FROM emp
WHERE ename IN('SMITH','ALLEN');


IN : ���������� ����� �� ������ ���� ���� ��
WHERE �÷� | ǥ���� IN(��������)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� true
    WHERE �÷�|ǥ���� ������ ANY(��������)
    
ALL : ���������� ��� ���� �����ڸ� ������ �� true
WHERE �÷�|ǥ���� ������ ALL(��������)

1.���������� ������� ���� ��� : �ι��� ������ ���
1-1) SMITH,ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
20,30
SELECT *
FROM emp
WHERE ename IN('SMITH','ALLEN');

1-2) 1-1)���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno IN(20,30);
==> ���������� �̿��ϸ� �ϳ��� sql���� ���డ��
SELECT *
FROM emp
WHERE deptno IN(SELECT deptno FROM emp WHERE ename IN('SMITH','ALLEN'));

SELECT *
FROM emp
WHERE ename IN('SMITH','WARD');

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno FROM emp WHERE ename IN('SMITH','WARD'));

ANY, ALL
SMITH(800)�� WARD(1250) �λ���� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal FROM emp WHERE ename IN('SMITH','WARD'));

SMITH(800)�� WARD(1250) �λ���� �޿� ���� ū �޿��� �޴� ���� ��ȸ
==> sal > 1250 
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE ename IN('SMITH','WARD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN(20,30)

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ������ �ʴ� ���
WHERE deptno NOT IN(20,30)
NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�
==> ���������� �������� ����.

NULL ���� ���� �� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr FROM emp WHERE mgr IS NOT NULL);

NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,-1) FROM emp);

���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT mgr,deptno
FROM emp
WHERE empno IN(7499,7782); WHERE empno = 7499;
7499,7782����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ���� ��ȸ
�Ŵ����� 7698�̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839�̸鼭 �ҼӺμ��� 10�� ���

mgr �÷��� deptno �÷��� �������� ����.
(mgr, deptno)
(7698,10)
(7698,30)
(7839,10)
(7839,30)
SELECT *
FROM emp
WHERE mgr IN(7698,7839)
AND deptno IN(10,30);

PAIRWISE ���� (���� �������� ����� �ΰ� �۴�)
SELECT *
FROM emp
WHERE (mgr,deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN(7499, 7782));
                        
�������� ����- ��� ��ġ�� ����
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���̴� ����)
    ���� �÷�

��Į�� ��������
SELECT ���� ǥ���Ǵ� ��������
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� ���� ó�� �ν�

SELECT 'X',(SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ �ؾ� �Ѵ�.
���� �ϳ����� �÷��� �ΰ����� ����
SELECT 'X',(SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� ��������
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

��Į�� ��������

SELECT dname
FROM dept
WHERE deptno = 10;

join���� ����
SELECT empno, ename, deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�� ������ ��Į�� ���������� ����

SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno = 10) --�μ��̸�
FROM emp;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
.���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�.

���ȣ ���� ��������(non corelated sub query)
main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
sub ������ ���̺��� ���� ��ȸ �� �� �� �ִ�.

��� ������ �޿���� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ�(���� ���� �̿�)

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?

������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL

SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

SELECT *
FROM emp e
WHERE e.sal > (SELECT AVG(sal)
FROM emp
WHERE deptno = 20);

�ƿ��� ���� --> ������ ���еǴ��� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���� ���
table LEFT OUTER JOIN table2
==> table1�� �÷��� ���ο� ����

���� ��ȸ�� �ȴ�.

SELECT *
FROM emp;

INSERT INTO dept VALUES (99,'ddit','daejeon');
emp ���̺� ��ϵ� �������� 10,20,30�� �μ����� �Ҽ��� �Ǿ�����
���� �Ҽӵ��� ���� �μ� : 40,50

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno FROM emp);

���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
���� ������ �־ ��� ����(����)

������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� ���� �ҷ��� �׷� ������ �� ��� (���� �´�)
SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno,COUNT(*), FROM emp GROUP BY deptno);

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM Product
WHERE pid NOT IN(SELECT pid FROM cycle WHERE cid = 1); 

SELECT cid,(SELECT cnm FROM customer WHERE cid = cycle.cid) cnm, pid,
        (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,day,cnt
FROM cycle 
WHERE cid = 1 AND pid IN(SELECT pid FROM cycle WHERE cid = 2);
  
SELECT *
FROM customer;

SELECT a.cid, a.cnm, c.pid, c.pnm, b.day, b.cnt
FROM customer a JOIN cycle b ON(a.cid = b.cid AND a.cid = 1) 
                JOIN product c ON(c.pid = b.pid)
AND c.pid IN(SELECT pid FROM cycle WHERE cid = 2);

