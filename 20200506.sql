SQL 1)
SELECT job ,COUNT(*) cnt
FROM emp
GROUP BY job;

SQL 2)
SELECT mgr, COUNT(*) cnt
FROM emp
GROUP BY mgr;

1�� ����)
SELECT ROWNUM rn,a.sido,a.sigungu,a.city_idx,b.sido,b.sigungu,b.cnt
FROM
(SELECT ROWNUM rn, sido, sigungu, city_idx
FROM (SELECT ROWNUM rn, bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
                ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx
FROM
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu)kfc,
                        
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '�Ƶ�����'
 GROUP BY sido, sigungu) mac,
                                                 
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
 WHERE gb = '�Ե�����'
 GROUP BY sido, sigungu) lot
 
 WHERE bk.sido = kfc.sido
 AND bk.sigungu = kfc.sigungu
 AND bk.sido = mac.sido
 AND bk.sigungu = mac.sigungu
 AND bk.sido = lot.sido
 AND bk.sigungu = lot.sigungu
 ORDER BY city_idx DESC) a ) a, 
 (SELECT ROWNUM rn, b.*
  FROM
(SELECT sido, sigungu, ROUND(sal/people,2) cnt
FROM tax
ORDER BY cnt DESC) b ) b
WHERE a.rn = b.rn;

�ɼ�
����2]

fastfood ���̺� �ѹ��� �а� ���ù������� ���ϱ�;

���� �ܹ������� �ּ�(�����̽�, ������ġ ����) 
SELECT ROWNUM rank, sido, sigungu, city_idx
FROM
(SELECT sido, sigungu, Round((kfc + mac + bk)/lot,2) city_idx
FROM
(SELECT sido, sigungu,
    NVL(SUM( CASE WHEN gb = '�Ե�����' THEN 1 END ),1)lot,
    NVL(SUM( CASE WHEN gb = 'KFC' THEN 1 END ),0) kfc,
    NVL(SUM( CASE WHEN gb = '�Ƶ�����' THEN 1 END ),0) mac,
    NVL(SUM( CASE WHEN gb = '����ŷ' THEN 1 END ),0) bk    
FROM fastfood
WHERE gb IN('����ŷ','KFC','�Ƶ�����','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY city_idx desc);

DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELECT) �� �� ����ϴ� SQL

INSERT ���� 

INSERT INTO ���̺��[(���̺��� �÷���, ....)] VALUES (�Է��� ��, .....);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�.
   ��, �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�.
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2 ....);

2. �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
    ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���.
    �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�.
INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES(�Է��� ��, �Է��� ��2);

3. SELECT ����� INSERT
   SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
   ==> �������� �����͸� �ϳ��� ������ �Է� ���� ==> ���� ����
   
   INSERT INTO ���̺�� [(�÷���1, �÷���2....)]
   SELECT......
   FROM .........

dept ���̺� deptno = 99;, dname ddit, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�

SELECT *
FROM dept;

INSERT INTO dept VALUES(99,'ddit','daejeon');

INSERT INTO dept(deptno,dname,loc) VALUES(99,'ddit','daejeon');
������ �Է��� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �϶�� : rollback - Ʈ����� ���
rollback;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��� ����
EX : ���̺� �����Ͱ� �� ����� �Ͻ������� ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������ 8��, NOT NULL�� 1��(empno)
empno�� 9999�̰� ename�� �����̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�

INSERT INTO emp(empno,ename,hiredate) VALUES(9999,'KAH',SYSDATE);
INSERT ���� ������� ���� �÷����� ���� NULL�� �Էµȴ�.

9998�� ������� KAH ����� �Է�, �Ի����ڴ� 2020�� 4�� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp(empno,ename,hiredate) VALUES(9998,'KAH',TO_DATE('2020/04/13','YYYY/MM/DD'));

3. SELECT ����� ���̺� �Է��ϱ�(�뷮 �Է�)

DESC dept;

dept ���̺��� 4���� �����Ͱ� ����(10~40)
�Ʒ������� �����ϸ� ���� ���� 4�� + SELECT �� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�.
INSERT INTO dept 
SELECT *
FROM dept;

SELECT *
FROM dept;

ROLLBACK;

UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                   ������ �÷�1 = ������ ��1, ..... 
[WHERE condition-SELECT ������ ��� WHERE���� ����
    ������ ���� �ν��ϴ� ������ ���]

dept ���̺� 99,ddit,daejeon;

SELECT *
FROM dept;

INSERT INTO dept VALUES(99,'ddit','daejeon');

99�� �μ��� �μ����� ���IT��, ��ġ�� ���κ������� ����
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ����
==> ������ �ۼ��� ��� ����
 1. WHERE���� �������� �ʾҴ���
 2. UPDATE, DELETE ���� �����ϱ� ���� WHERE���� �����ؼ� SELECT�� �Ͽ�
    ������ ���� ���� ������ Ȯ��
    
���������� �̿��� ������ ����
INSERT INTO emp(empno, ename, job) VALUES(9999,'brown',NULL);

9999�� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH') ,
              job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ���� �� �� �ִ�.

DELETE : ���̺� �����ϴ� �����͸� ����
����
DELETE [FROM] ���̺�� 
[WHERE condition]

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
    DELETE ���� �� ��ü�� ����
2. UPDATE ���������� DELETE ������ �����ϱ� ���� SELETE�� ���� ���� ����̵Ǵ� ���� ��ȸ, Ȯ������.

���� �׽�Ʈ ������ �Է�
INSERT INTO emp(empno, ename, job) VALUES (9999,'brown',NULL);

����� 9999���� ���� ���� �ϴ� ���� �ۼ�
DELETE emp
WHERE empno = 9999;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� �� ����
DELETE emp;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� �� �ְ�
WHERE���� SELECT ������ ����� ������ ������ �� �ִ�.
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 7698�� �������� ��� �����ϰ� ���� ��

DELETE emp
WHERE empno IN
        (SELECT empno
        FROM emp
        WHERE mgr = 7698);


SELECT *
FROM emp
WHERE empno = 9999;

ROLLBACK;

SELECT *
FROM emp;

DML : SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE
3���� ������ �����͸� �ĺ��ϴ� WHERE ���� ��� �� �� �ִ�. 
�����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿� ��.
==> INDEX ��ü�� ���� �ӵ� ����� ����


INSERT : ������� �ű� �����͸� �Է� �ϴ� ��.
         ������� �ĺ��ϴ°� �߿�
         ==> Ʃ�� ����Ʈ�� ���� ����.

���̺��� �����͸� ����� ���(��� ������ �����)
1. DELETE : WHERE���� ������� ������ ��
2. TRUNCATE
     ���� : TRUNCATE TABLE ���̺��
     Ư¡ : 1) ���� �� �α׸� ������ ����
           ==> ������ �Ұ���
           2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������.
           ==> �ȯ�濡���� �� ������� ����(������ �ȵǱ� ������)
             �׽�Ʈ ȯ�濡�� �ַ� ���
 
���̺��� �����Ͽ� ���̺� ����(���� �غ���)

CREATE TABLE emp_copy AS 
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy ���̺��� TRUNCATE ����� ���� ��� �����͸� ����
TRUNCATE TABLE emp_copy;

ROLLBACK;

Ʈ�����)
��� ����ϴ� �Խ����� �����غ���.
�Խñ� �Է��� �� �Է� �ϴ� �� : ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ��ƼƼ(���̺�)�� �и��� �Ѵ�.
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ����� �Ѵ�.
INSERT INTO �Խñ� ���̺� (����, ����, �����, ����Ͻ�) VALUES (.............);
INSERT INTO �Խñ� ���̺� (÷�����ϸ�, ÷������ ������) VALUES (.............);

�ΰ��� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �ΰ��� INSERT ������ ���.

             