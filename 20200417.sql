SELECT ���� ���� : 
��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� + - ������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
���� ����(.....) : �����ð��� �ٷ��� ����....
���ڿ� ����
    ���ͷ� : ǥ����
            ���� ���ͷ� : ���ڷ� ǥ��
            ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                        SELECT SELECT * FROM || table_name
                        SELECT 'SELECT * FROM' || table_name
            ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
            ��¥?? : TO_DATE("��¥���ڿ�", "��¥ ���ڿ��� ���� ����(YYYYMMDD)")
                    TO_DATE('20200417','YYYYMMDD')
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����

SELECT *
FROM users
WHERE userid = 'brown';

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
 AND  sal <= 2000;
 
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN(10,30);

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 30;

SELECT userid ���̵�,usernm �̸�,alias ����
FROM users
WHERE userid IN('brown','cony','sally');

SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

SELECT mem_id,mem_name
FROM member
WHERE mem_name Like '%��%';

SELECT *
FROM emp
WHERE mgr is not null;

SELECT *
FROM emp
WHERE comm is not null;

SELECT *
FROM emp
WHERE mgr = 7698
  OR SAL > 1000;

SELECT *
FROM emp
WHERE mgr IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr in null;

==> WHERE mgr != 7698 AND mgr != 7839
  
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD')
AND sal > 1300;

SELECT *
FROM emp
WHERE deptno IN (20,30) 
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= to_date('19810601','YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno = 78
OR empno >= 780 AND empno < 790
OR empno >= 7800 AND empno < 7900;
  
SELECT *
FROM emp
WHERE (job = 'SALESMAN'
   OR empno Like '78%') 
   AND hiredate >= TO_DATE('19810601','YYYYMMDD');
   
SELECT *
FROM emp
ORDER BY ename asc;

SELECT *
FROM emp
ORDER BY ename desc;
 
 -- job�� �������� ���������ϰ�, job�� ������� �Ի����ڷ� �������� ����
SELECT *
FROM emp
ORDER BY job asc, hiredate desc;
  