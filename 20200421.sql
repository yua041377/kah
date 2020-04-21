����¡ ó��
- ROWNUM
- INLINE-VIEW(����Ŭ ����)
- ����¡ ����
- ���ε� ����

���α׷��� ���, �ĺ��̸� �ο�

DUAL TABLE
SYS ������ ���� �ִ� ���̺�
����Ŭ�� ��� ����ڰ� �������� ����� �� �ִ� ���̺�

�Ѱ��� ��, �ϳ��� �÷�(dummy) - ���� 'X';

SELECT *
FROM dual;

��� �뵵
1. �Լ��� �׽�Ʈ�� ����
2. merge ����
3. ������ ����

����Ŭ ���� �Լ� �׽�Ʈ(��ҹ��� ����)
LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�.
SELECT *
FROM dual;

SELECT LOWER('Hello, World')
FROM dual;

SELECT UPPER('Hello, World')
FROM dual;

SELECT INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM emp;

SELECT empno, 5, 'test', LOWER('Hello, World')
FROM emp;

emp ���̺��� SMITH ����� �̸��� �빮�ڷ� �����Ǿ� ����

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; -- �̷������� �ۼ��ϸ� �ȵȴ�.
WHERE ename = UPPER('smith'); -- �ΰ��� ��� �߿��� �������ٴ� �Ʒ������ �ùٸ� ����̴�.
--> WHERE ename = 'smith';
WHERE ename = 'smith'; --���̺��� ������ ���� �빮�ڷ� ����Ǿ� �����Ƿ� ��ȸ�Ǽ� 0
WHERE ename = 'SMITH'; -- ���� ����

���ڿ� ���� �Լ�
CONCAT : 2���� ���ڿ��� �Է����� �޾�, ���D�� ���ڿ��� ��ȯ�Ѵ�.


SELECT CONCAT('start', 'end')
FROM dual;

SELECT  
   table_name, tablespace_name, CONCAT('start', 'end'),
    CONCAT(table_name, tablespace_name),
    CONCAT('SELECT * FROM', CONCAT(table_name, ';'))
FROM user_tables;

SELECT 
    CONCAT('SELECT * FROM', CONCAT(table_name, ';'))
FROM user_tables;

SUBSTR(���ڿ�, �����ε���, ���� �ε���) : ���ڿ��� �����ε��� ���� .... ���� �ε��� ������ �κ� ���ڿ�
�����ε����� 1���� (*java�� ���� 0����)
SELECT SUBSTR('Hello, World',1,5) sub
FROM dual;

LENGTH(���ڿ�) : ���ڿ��� ���̸� ��ȯ
SELECT SUBSTR('Hello, World',1,5) sub,
        LENGTH('Hello, World')len
FROM dual;

INSTR(���ڿ�, ã�� ���ڿ�) : ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ��� ã�� ���ڿ��� �ε���(��ġ) ��ȯ
SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins
FROM dual;

SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2,
    INSTR('Hello, World','o', INSER('Hello, World','o') + 1) ins3
FROM dual;

LPAD, PRAD ( ���ڿ�, ���߰� ���� ��ü ���ڿ� ����, �е� ���ڿ� - �⺻ ���� ����)
REPLACE (���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�) : ���ڿ����� �˻��� ���ڿ� ã�� ������ ���ڿ� ����� ����
SELECT SUBSTR('Hello, World',1,5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World','o') ins,
    INSTR('Hello, World','o',6) ins2,
    INSTR('Hello, World','o', INSTR('Hello, World','o') + 1) ins3,
    LPAD('Hello', 15, '*') lp,
    RPAD('Hello',15,'*') rp,
    REPLACE('Hello, World','ll','LL') rep,
    TRIM('     Hello    ')tr,
    TRIM('H' FROM 'Hello') tr2
FROM dual;

NUMBER ���� �Լ�
ROUND(����, �ݿø� ��ġ) : �ݿø�
    ROUND(105.54, 1) : �Ҽ��� ù��°�ڸ����� ����� ���� ==> �Ҽ��� �ι�° �ڸ����� �ݿø�
    : 105.5
TRUNC(����, ���� ��ġ) : ����
MOD(������, ����) ������ ����

SELECT ROUND(105.54,1) round,
       ROUND(105.55,1) round2,
       ROUND(105.55,1) round3,
       ROUND(105.55,-1) round4
FROM dual;

SELECT TRUNC(105.54,1) trunc,
       TRUNC(105.55,1) trunc2,
       TRUNC(105.55,1) trunc3,
       TRUNC(105.55,-1) trunc4
FROM dual;

SELECT MOD(10,3),sal, MOD(sal,1000)
FROM emp;

��¥ ���� �Լ�
SYSDATE : ������� ����Ŭ �����ͺ��̽� ������ ���� �ð�, ��¥�� ��ȯ�Ѵ�.
        �Լ������� ���ڰ� ���� �Լ�
        (���ڰ� ���� ��� JAVA : �޼ҵ�()
                        SQL : �Լ���

SELECT SYSDATE
FROM dual;

���� 1 = �Ϸ� ��� �ǹ�
1/24 = �ѽð�
1/24/60 = �Ϻ�
SELECT SYSDATE, SYSDATE + 5
FROM dual;

���ͷ�
���� : ....
���� : ''
��¥ : TO_DATE('��¥ ���ڿ�','����')

SELECT TO_DATE('20191231','YYYYMMDD') LASTDAY,
      TO_DATE('20191231','YYYYMMDD') - 5 LASTDAY_BEFORES,
      SYSDATE NOW,
      SYSDATE - 3 NOW_BEFORE3
FROM dual;

TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
TO_CHAR(��¥, ����) : ��¥Ÿ���� ���˿� �°� ���ڿ��� ��ȯ
YYYY : �⵵
MM : ��
DD : ����
D : �ְ�����(1~7, 1- �Ͽ���, 2- ������... 7- �����)
IW : ���� (52~53)
HH : �ð�(12�ð�)
HH24 : 24�ð� ǥ��
MI : ��
SS : ��
����ð�(SYSDATE) �ú��� �������� ǥ�� -> TO_CHAR�� �̿��Ͽ� ����ȯ

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
       TO_CHAR(SYSDATE, 'D') d,
       TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
       TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual; 

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
      TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) : DATE1�� DATE2 ������ �������� ��ȯ
4���� ��¥ �����Լ� �߿� ��� �󵵰� ����
SELECT MONTHS_BETWEEN (TO_DATE('2020/04/21' ,'YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD')),
       MONTHS_BETWEEN (TO_DATE('2020/04/22' ,'YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, ������ ������) : DATE1�� ���� �ι�° �Էµ� ������ ��ŭ ������ DATE
���� ��¥�κ��� 6���� �� ��¥

SELECT ADD_MONTHS(SYSDATE, 5) dtl,
       ADD_MONTHS(SYSDATE, - 5) dt2
FROM dual;

NEXT_DAY(date1, �ְ�����) date ���� �����ϴ� ù��° �ְ������� ��¥�� ��ȯ
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(DATE1) DATE1�� ���� ���� ������ ���ڸ� ��¥�� ��ȯ
SYSDATE : 2020/04/21 --> 2020/04/30
SELECT LAST_DAY(SYSDATE)
FROM dual;

��¥�� ���� ���� ù��° ��¥ ���ϱ�(1��)
SYSDATE : 2020/04/21 -> 2020/04/01;
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1,
        ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1)
FROM dual;

SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1,
        ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01')
FROM dual;