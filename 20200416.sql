SELECT *  --��� �÷������� ��ȸ
FROM prod;  --�����͸� ��ȸ�� ���̺� ��� 

-- Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2.....
prod_id, prod_name �÷��� prod ���̺��� ��ȸ;

SELECT prod_id, prod_name
FROM prod;

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_nmae
FROM member;

SELECT *
FROM USERS;

SELECT userid, reg_dt + 5 after_5days, reg_dt - 5
FROM users;

SELECT userid as id, userid id2, userid ���̵�
FROM users;


SELECT prod_id as id, prod_name as name
FROM prod;

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸� 
FROM buyer;

���ڿ� ����(���տ���) : || (���ڿ� ������ + �����ڰ� �ƴϴ�)
string str = "hello";
str = str + ", world"; //str : hello,world
SELECT /*userid 'test'*/userid ||'text', reg_dt + 5, 'test',15
FROM users;

SELECT '��' || userid || ' ��'
FROM users;

SELECT userid || usernm as id_name
FROM users;

SELECT userid || usernm as id_name,
    CONCAT(userid,usernm) as concat_id_name
FROM users;

user_tables : oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) -> data dictionary

SELECT 'SELECT * FROM ' || table_name || ';' as QUERY
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺�

2. SELECT *
   FROM ���̺�
   �ϴ� ��ü ��ȸ -> ��� �÷��� ǥ��

3. DESC ���̺��

4. data dictionary : user_tab_columns

SELECT *
FROM user_tab_columns;


java�� �� ���� : a������ b������ ���� ������ �� ==
sql �� ���� : = 
int a = 5;
int b = 2;
if(a == b) {
}

SELECT *
FROM users
WHERE userid = 'cony';

SELECT *
FROM users

DESC emp;
SELECT *
FROM emp;

emp : employee
empno : �����ȣ
ename : ����̸�
job : ������(��å)
mgr : �����(������)
hiredate : �Ի�����
sal : �޿�
comm : ������
deptno : �μ���ȣ

SELECT *
FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���ų� ū(>) �μ��� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno >= 30;

!= �ٸ���
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT *
FROM users
WHERE userid != 'brown';

 SQL ���ͷ�
 ���� :  .... 20, 30.5
 ���� : �̱� �����̼� : 'hello world'
 ��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����');
 
 1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
 ������ �Ի����� : hiredate �÷�
 SELECT *
 FROM emp
 WHERE hiredate < TO_DATE('19820101','YYYYMMDD');
 
