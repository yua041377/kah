NULL ó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2 ....

SELECT NVL(empno,0), ename, NVL(sal,0), NVL(comm, 0)
FROM emp;

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����
          ���� ����;

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ����( ex : sal 100-> 105)

�ش� ������ job�� MANAGER �̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                                �׿��� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����

�ش� ������ job�� PRESIDENT �� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal ��ŭ�� ����

SELECT empno, ename, job, sal, 
    DECODE(job,
    'SALESMAN',sal * 1.05,
    'MANAGER',DECODE(
    deptno,10,sal * 1.30,sal * 1.10),
    'PRESIDENT',sal * 1.20,sal) bouns
FROM emp;


DECODE�� ��� (case �� ��� ����)

if(���ǽ�) {
    if(���ǽ�) {
    }
}


SELECT *
FROM emp
ORDER BY deptno;



���� A = {10,15,18,23,24,25,29,30,35,37}
�Ҽ� : �ڽŰ� 1�� ����� �ϴ� ��
�Ҽ� : {23,29.37} : COUNT-3, MAX-37, MIN-23, AVG-29.66, SYN-89
��Ҽ� : {10,15,18,24,25,30,35}

GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10,20,30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
    
    
    
    
SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�;
[ORDER BY ];

SELECT deptno, MIN(ename), MAX(sal)
FROM emp
GROUP BY deptno;

SELECT
    MAX(sal), -- �μ����� ���� ���� �޿� �� 
    MIN(sal), -- �μ����� ���� ���� �޿� ��
    ROUND(AVG(sal),2), -- �μ��� �޿� ���
    SUM(sal), -- �μ��� �޿� ��
    COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
    COUNT(*), -- �μ��� ���� ��
    COUNT(mgr)
FROM emp
GROUP BY deptno;

�׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
--> ���� WINDOW FUNCTION�� ���� �ذ� ����


emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
SELECT  MAX(sal), -- ��ü ���� �� ���� ���� �޿� �� 
        MIN(sal), -- ��ü ���� �� ���� ���� �޿� ��
        ROUND(AVG(sal),2), -- ��ü ������ �޿� ���
        SUM(sal), -- ��ü ������ �޿� ��
        COUNT(sal), -- ��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*), -- ��ü ���� ��
        COUNT(mgr) -- mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ �������!

GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ����!
 
�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�. (���� �ƴ�);   
SELECT deptno, 'TEST' , 1,
    MAX(sal), -- �μ����� ���� ���� �޿� �� 
    MIN(sal), -- �μ����� ���� ���� �޿� ��
    ROUND(AVG(sal),2), -- �μ��� �޿� ���
    SUM(sal), -- �μ��� �޿� ��
    COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
    COUNT(*), -- �μ��� ���� ��
    COUNT(mgr)
FROM emp
GROUP BY deptno;
    
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10,20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULL ó��
Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm,0) : COMM �÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm,0)) : ��� COM�÷��� NVL �Լ��� ������ ��(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷� �Լ� ����

SELECT deptno, NVL(SUM(comm),0),SUM(NVL(comm,0))
FROM emp
GROUP BY deptno;

SELECT *
FROM emp

signle row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��� ����
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

SELECT 
    MAX(sal) MAX_SAL,
    MIN(sal) MIN_SAL,
    ROUND(AVG(sal),2) AVG_SAL,
    SUM(sal) SUM_SAL,
    COUNT(sal) COUNT_SAL,
    COUNT(mgr) COUNT_MGR,
    COUNT(*) COUNT_ALL
FROM emp
    WHERE
     sal IS NOT NULL
     OR mgr IS NOT NULL;


SELECT deptno,
    MAX(sal) MAX_SAL,
    MIN(sal) MIN_SAL,
    ROUND(AVG(sal),2) AVG_SAL,
    SUM(sal) SUM_SAL,
    COUNT(sal) COUNT_SAL,
    COUNT(mgr) COUNT_MGR,
    COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno
HAVING count(sal) IS NOT NULL
OR count(mgr) IS NOT NULL;

SELECT 
     DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT') dname,
    MAX(sal) MAX_SAL,
    MIN(sal) MIN_SAL,
    ROUND(AVG(sal),2) AVG_SAL,
    SUM(sal) SUM_SAL,
    COUNT(sal) COUNT_SAL,
    COUNT(mgr) COUNT_MGR,
    COUNT(*) COUNT_ALL
FROM emp
GROUP BY DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT')
HAVING count(sal) IS NOT NULL
OR count(mgr) IS NOT NULL;

SELECT 
    TO_CHAR(hiredate,'YYYYMM') HIRE_YYYYMM,
    COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');

SELECT 
    TO_CHAR(hiredate,'YYYY') HIRE_YYYYMM,
    COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');

SELECT 
    COUNT(*) cnt
FROM dept;


SELECT  
    COUNT(COUNT(deptno))CNT 
FROM emp
GROUP BY deptno;


