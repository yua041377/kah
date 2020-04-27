SELECT COUNT(*)
FROM
(SELECT COUNT(*) cnt
FROM
(SELECT deptno  
FROM emp
GROUP BY deptno));

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �Ҽ� �ִ� �÷��� ������ ��������.(���� Ȯ��)



NATURAL JOIN : 
    �����Ϸ��� �� ���̺��� ����� �÷��� �̸��� ���� ���
    emp, dept ���̺��� deptno��� ����� (������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    
    �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ� ���� ���̺��� �÷����� �������� ������ 
    ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.

- emp ���̺� : 14��
- dept ���̺� : 4��


���� �Ϸ����ϴ� �÷��� ���� ������� ����.    
SELECT *
FROM emp NATURAL JOIN dept;

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ���� ����.
����Ŭ ���� ����

1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
2. ����� ������ WHERE ���� ����ϸ� �ȴ�.(WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 dept ���̺�� ���� �Ͽ� ��ȸ
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND emp.deptno = 10;

ANSI-SQL : JOIN with USING
join �Ϸ��� ���̺� �� �̸��� ���� �÷��� 2�� �̻��� ��
�����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷��� ���

SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
ON���� ����� ������ ���;

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ORALECE �������� �� SQL �ۼ�

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� �� 
emp ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����
�ش� ������ �������� �̸��� �˰���� �� 

ANSI-SQL�� SQL ���� : 
�����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������ ����)
    ����� �÷� : ����.MGR = ������.EMPNO
    -> ���� �÷� �̸��� �ٸ���.(MGR, EMPNO)
    -> NATURAL JOIN, JOIN WITH USING�� ����� �Ұ����� ����
    -> JOIN with ON

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ANSI-SQL�� �ۼ�
SELECT *
FROM emp e JOIN emp m ON (e.mgr = m.empno);

NONEUQI JOIN : ����� ������ =�� �ƴҶ�

�׵��� WHERE ������ ����� ������ : =, !=, <>, <=, <, >, >=
                                AND, OR, NOT
                                LIKE %, _
                                OR - IN
                                BETWEEN AND ==> >=, <=
                            
SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

���� ������ ORACLE ���� �������� ����
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno = dept.deptno;

-- JOIN ON ���
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND emp.deptno IN(10,30));

-- ����Ŭ ���� ���
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND emp.deptno IN(10,30);

-- JOIN ON ���  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500);

-- ����Ŭ ���� ���
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500;
   
-- JOIN ON ���  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500 AND empno >7600);

-- ����Ŭ ���� ���
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500
   AND empno >7600;
   
-- JOIN ON ���  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND sal > 2500 AND empno >7600 AND dname ='RESEARCH');

-- ����Ŭ ���� ���
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
   AND sal > 2500
   AND empno >7600;
   AND dname ='RESEARCH'

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

SELECT member.mem_id, member.member_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM JOIN(member JOIN prod CROSS JOIN cart ON(member.mem_id = cart.cart_prod AND cart.cart_prod = prod.prod_id);

SELECT member.mem_id, member.member_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member,cart,prod
WHERE member.mem_id = cart.cart_prod AND cart.cart_prod = prod.prod_id;
