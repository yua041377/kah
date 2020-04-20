table���� ��ȸ/���� ������ ����.
ORDER BY �÷��� ���Ĺ��,.....

ORDER BY �÷����� ��ȣ

SELECT�� 3��° �÷��� �������� ����
SELECT *
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

SELECT *
FROM dept
ORDER BY dname asc;

SELECT *
FROM dept
ORDER BY loc desc;

SELECT * 
FROM emp
WHERE comm != 0
ORDER BY comm desc, empno asc; 

SELECT *
FROM emp
WHERE mgr is not null
ORDER BY job asc, empno desc;

SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30)
AND sal > 1500
ORDER BY ename desc;

SELECT ROWNUM, empno, ename 
FROM emp;

SELECT���� *ǥ���ϰ� �޸��� ���� �ٸ� ǥ��(ex ROWNUM)�� ����� ���
* �տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ� �Ѵ�.
SELECT ROWNUM, e.*
FROM emp e;

����¡ ó���� �ϱ� ���� �ʿ��� ����
1. ������ ������(10)
2. ������ ���� ����

1-page : 1~10
2-page : 11~20 (���� ������ : 11~14)

1. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡
1. ORACLE���� ����
    - �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ����(LIMIT)
2. 1������ ���������� �д°�츸 ����
    ROWNUM BETWEEN 1 AND 10 --> 1 ~ 10
    ROWNUM BETWEEN 11 AND 20 --> 1 ~10 SKIP �ϰ� 11~ 20�� �������� �õ�
    
    WHERE ���� ROWNUM�� ����� ��� ���� ����
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= N (1 ~ N)
    
ROWNUM�� ORDER BY 
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY empno;
    
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY ename;
    
SELECT -> ROWNUM -> ORDER BY

ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW�� ����ؾ� �Ѵ�.
** IN-LINE : ���� ����� �ߴ�.

SELECT a.*
FROM 
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename) a ) a
WHERE rn BETWEEN 1 + (:page -  1) * :pageSize AND :page * : pageSize;

WHERE rn BETWEEN 1 AND 10; 1 PAGE
WHERE rn BETWEEN 11 AND 20; 1 PAGE
WHERE rn BETWEEN 21 AND 30; 1 PAGE

WHERE rn BETWEEN 1+(n-1)*10 AND PageSize * n ; n PAGE

INLINE-VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ���´�)
VIEW - ����

DML - SELECT, INSERT, UPDATE, DELETE
DDL - CREATE, DROP, MODIFY, RENAME

CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
    
SELECT *
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);
    
VIEW�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view�� ����� ������ ����� ��� ������ ������?

���� �ۼ��� ������ ã�ư���
java : �����
sql : ����� ���� ����

����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM ���� ������ �Ͽ� ���ڰ� ���̴� ������ �߻� ==> INLINE-VIEW
    ���Ŀ� ���� INLINE-VIEW
    ROWNUM�� ���� INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn, b.*
FROM
 (SELECT empno, ename
 FROM emp
 ORDER BY ename) b )
 WHERE rn BETWEEN 11 AND 20;

SELECT *
FROM
(SELECT ROWNUM rn, c.*
FROM
(SELECT empno, ename
FROM emp 
ORDER BY ename) c )
WHERE rn BETWEEN 11 AND 20;

// PROD ���̺��� prod_LGU (��������), PROD_COST (���� ����)���� �����Ͽ� 
����¡ ó�� ������ �ۼ� �ϼ���.�� ������ ������ : 5, ���ε� ������ ����� ��
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod
ORDER BY prod_lgu desc, prod_cost asc) a )
WHERE rn BETWEEN 1 + (:page -  1) * :pageSize AND :page * : pageSize;

