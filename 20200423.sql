NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1;
    
NVL2(expr1, expr2, expr3)
if expr1 != null
    return expr2
else
    return expr3;
    
SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
FROM emp;

NULLIF(expr1, expr2)
if expr1 == expr2
    return null
else
    return expr1;
    
sal �÷��� ���� 3000�̸� null�� ����
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
        �������ڵ��� Ÿ���� ���� �ؾ���

���ڵ��߿� ���� ���������� null�� �ƴ� ���� ���� ����
coalesce(expr1,expr2....)
if expr1 != null
    return expr1
else
    coalesce(expr2, expr3......)

mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm,sal)
FROM emp;

SELECT empno, ename, mgr, NVL(mgr, 9999) MGR_N,
      NVL2(mgr, mgr, 9999) MGR_N_1,
      coalesce(mgr,9999) MGR_N_2
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

condition
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch ���� ����
1. case ����
2. decode �Լ�

1.CASE
CASE 
    WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ �� ELSE (�Ǻ����� ���� WHEN ���� ������� ����)]
END

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100-> 105)
�ش� ������ job�� SALESMAN�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ���� 
�ش� ������ job�� SALESMAN�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�� �� �������� sal��ŭ�� ����

SELECT empno, ename, job, sal, 
    CASE
        WHEN job = 'SALESMAN' AND sal <  2000 THEN sal * 1.05
        WHEN job = 'SALESMAN' THEN sal * 1.10
        WHEN job = 'SALESMAN' THEN sal * 1.20
        ELSE sal * 1
    END as bouns
FROM emp;

2. DECODE(EXPR1, serch1, return1, search2, return2, search3, return3.....,[default])
   DECODE(EXPR1,
    search1, reurn1,
    search2, reurn2,
    search3, reurn3,
    search4, reurn4,
if EXPR1 == search1
    return return2
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
.....
else
    return default;
 
SELECT empno, ename, job, sal,
    DECODE(job, 'SALESMAN', sal * 1.05,
                'MANAGER', sal * 1.10,
                'PRESTIDENT', sal * 1.20,
                sal) bouns
FROM emp;

SELECT empno, ename,
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END dname
FROM emp;

SELECT empno, ename, hiredate,
    CASE
        WHEN  MOD(TO_CHAR(SYSDATE+365 ,'YYYY'),2) = AND MOD(TO_CHAR(hiredate ,'YYYY'),2) = 1 THEN '�ǰ����� �����'
        WHEN  MOD(TO_CHAR(SYSDATE+365 ,'YYYY'),2) = 0 AND MOD(TO_CHAR(hiredate ,'YYYY'),2) = 0 THEN '�ǰ����� �����'
        WHEN  MOD(TO_CHAR(SYSDATE+365 ,'YYYY'),2) = 1 AND MOD(TO_CHAR(hiredate ,'YYYY'),2) = 0 THEN '�ǰ����� ������'
        WHEN  MOD(TO_CHAR(SYSDATE+365 ,'YYYY'),2) = 0 AND MOD(TO_CHAR(hiredate ,'YYYY'),2) = 1 THEN '�ǰ����� ������'      
    END CONTACT_TO_DOCTOR    
FROM emp;

SELECT userid,usernm,alias,reg_dt, 
    CASE
        WHEN  MOD(TO_CHAR(SYSDATE,'YYYY'),2) = 1 AND MOD(TO_CHAR(reg_dt ,'YYYY'),2) = 1 THEN '�ǰ����� �����'
        WHEN  MOD(TO_CHAR(SYSDATE,'YYYY'),2) = 0 AND MOD(TO_CHAR(reg_dt ,'YYYY'),2) = 0 THEN '�ǰ����� �����'
        WHEN  MOD(TO_CHAR(SYSDATE,'YYYY'),2) = 1 AND MOD(TO_CHAR(reg_dt ,'YYYY'),2) = 0 THEN '�ǰ����� ������'
        WHEN  MOD(TO_CHAR(SYSDATE,'YYYY'),2) = 0 AND MOD(TO_CHAR(reg_dt ,'YYYY'),2) = 1 THEN '�ǰ����� ������'   
        ELSE '������'
    END CONTACT_TO_DOCTOR    
FROM users;


    
    
    
    
    
    
    
    
    
    
    
    
    
    
