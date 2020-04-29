8)
SELECT regions.region_id, regions.region_name, countries.country_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id AND regions.region_name = 'Europe');
9)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id
     AND regions.region_name = 'Europe');
10)
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city, departments.department_name
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id  AND regions.region_name = 'Europe');
11)   
SELECT regions.region_id, regions.region_name, countries.country_name, locations.city,departments.department_name,
      (employees.FIRST_NAME||employees.LAST_NAME) NAME 
FROM countries JOIN regions ON(regions.region_id = countries.region_id) JOIN locations ON(locations.country_id = countries.country_id)
     JOIN departments ON( departments.location_id = locations.location_id)
     JOIN employees ON( departments.department_id = employees.department_id AND regions.region_name = 'Europe');
12)
SELECT employees.employee_id,(employees.FIRST_NAME||employees.LAST_NAME) NAME, jobs.job_id, jobs.job_title
FROM employees JOIN jobs ON(employees.job_id = jobs.job_id);
13)
SELECT e.manager_id mr_id, e.employee_id, m.first_name || m.last_name mgr_name
            , e.first_name || e.last_name, e.job_id, jobs.job_title name
FROM employees e, jobs, employees m
WHERE e.job_id =jobs.job_id
      AND e.manager_id = m.employee_id
      AND e.manager_id =100;

SELECT *
FROM employees;
SELECT *
FROM jobs;


������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�.
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�,
KING�� ������ ������ �ʴ´�. (emp ���̺� �Ǽ� 14�� -> ���ΰ�� 13��)

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);



���� ������ OUTER �������� ����
==> (KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������,
������ ����� ������ ���� ������ ������ �ʴ´�.)

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);
     
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

ORACLE-SQL : OUTER 
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE ���� ���� ������ ���
3. ���� �÷�(�����) �� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�.
==> ������ ���̺� �ݴ����� ���̺��� �÷�

SELECT m.empno,m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�.

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e,emp m
WHERE e.mgr = m.empno(+) AND e.deptno = 10;

SELECT *
FROM buyprod;
WHERE buy_date = TO_DATE('2005/01/25','yyyy/mm/dd');

SELECT *
FROM prod;

SELECT b.BUY_DATE, b.BUY_PROD, c.prod_id, c.prod_name, b.BUY_QTY 
FROM buyprod b, prod c
WHERE c.prod_id = b.buy_prod(+) AND buy_date(+) = TO_DATE('2005/01/25','yyyy/mm/dd');

SELECT NVL(b.BUY_DATE,'2005/01/25') buy_date, b.BUY_PROD, c.prod_id, c.prod_name, b.BUY_QTY 
FROM prod c LEFT OUTER JOIN buyprod b ON(c.prod_id = b.buy_prod AND buy_date = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT TO_DATE('2015/01/25','YYYY/MM/DD') buy_date, b.BUY_PROD, c.prod_id, c.prod_name, NVL(b.BUY_QTY,0) BUY_QTY 
FROM prod c LEFT OUTER JOIN buyprod b ON(c.prod_id = b.buy_prod AND buy_date = TO_DATE('2005/01/25','yyyy/mm/dd'));

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM customer;

SELECT p.pid, p.pnm, 1 cid, NVL(c.day,0) day, NVL(c.cnt,0) cnt
FROM product p LEFT OUTER JOIN cycle c ON(p.pid = c.pid AND c.cid = 1);



SELECT p.pid, p.pnm, 1 cid, NVL(c.day,0) day,NVL(a.cnm,0) cnm, NVL(c.cnt,0) cnt
FROM product p JOIN cycle c ON(p.pid = c.pid AND c.cid = 1)
    JOIN customer a ON(a.cid = c.cid AND a.cnm ='brown')
ORDER BY pid DESC;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

emp 14 * dept 4 = 56 ��
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp, dept;

SELECT *
FROM customer CROSS JOIN product;

SELECT *
FROM customer, product;

�������� 
WHERE : ������ �����ϴ� �ุ ��ȸ�ϵ��� ����
SELECT *
FROM emp
WHERE 1 = 1
OR 1! = 1;

1 = 1 OR 1 != 1
true or false ==> true

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY 
    * ��Į�� ���������� ��ȸ�Ǵ� ���� �Ѱ��̰�, �÷��� �Ѱ��̾�� ��.
    EX) DUAL ���̺�
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
SMITH�� ���� �μ��� ���� �������� ���� ������?
1.SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��° ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH)(20) => WARD(30) == �ι�° ���� �ۼ��� 20������ 30������ ������ ����)
    ==> �������� ���鿡�� ���� ����
    
ù��° ����
    SELECT deptno 
    FROM emp
    WHERE ename = 'SMITH';
�ι�° ����
    SELECT *
    FROM emp;
    WHERE deptno = 20;
    
���������� ���� ���� ����

SELECT *
    FROM emp
    WHERE deptno = (SELECT deptno 
                    FROM emp
                    WHERE ename = 'SMITH');


SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);


