������

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ? 1==1 ? true�϶� ���� : false �� �� ����

IN : �÷� ! ǥ���� IN (����)
deptno IN (10,30) ==> IN(10,30), deptno (10,30)

EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISITS(��������)

SELECT *
FROM emp
WHERE EXISTS(SELECT 'X' FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ����� ������ �����ϴ� ���� : 14-KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

 -> IS NOT NULL�� ���ؼ��� ������ ����� ����� �� �� �ִ�.
SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X' 
              FROM emp m
              WHERE e.mgr = m.empno);

SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;


SELECT *
FROM emp
WHERE EXISTS(SELECT 'X' FROM dept);

SELECT *
FROM product p
WHERE EXISTS(SELECT pid FROM cycle c WHERE p.pid = c.pid AND cid = 1);

SELECT *
FROM product;

1�� �� �Դ� ��ǰ����
SELECT *
FROM cycle
WHERE cid = 1;

SELECT *
FROM product p
WHERE NOT EXISTS(SELECT pid FROM cycle c WHERE p.pid = c.pid AND cid = 1);

���տ���
������
{1,5,3) U {2,3} = {1,2,3,5}
SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�.)
{1,5,3} U {2,3} = {1,5,3,2,3}
������
{1,5,3) ������ {2,3} = {3}
������
{1,5,3} - {2,3} = {1,5}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ��(��, �Ʒ��� ���� �ȴ�)

UNION ������ : �ߺ�����(������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)




UNION ALL ������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369);

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698);




INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)




MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����
SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566,7698)

SQL ���տ������� Ư¡

���� �̸� : ù��° SQL �÷��� ���󰣴�.

ù��° ������ �÷��� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698);

2. ������ �ϰ���� ��� �������� ���� ����
���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY �� ������� ������ ����)

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�.(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
 ==> ����ڿ��� ����� �����ִ� �������� ������.
    ==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ�.

4. �˰���(���� - ���� ����, ���� ����, ....., 
        �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                heap 
                stack, queue
                list
                ���տ��꿡�� �߿��� ���� : �ߺ� ����

���տ��꿡�� �߿��� ���� : �ߺ�����
���� ����
for(int = 0; ...){
    for(int j = 1;....){
    }
}               

SELECT *
FROM FASTFOOD;

SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM
(SELECT ROWNUM, bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
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
 ORDER BY city_idx DESC)a;

SELECT *
FROM tax;

���� 1 fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� sql �ۼ�
1. ���ù��������� ���ϰ�(������ ���� ���ð� ������ ����.)
2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�

����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

���� 2 �ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ�(fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fastfood ���̺��� 1���� ���)
CASE, DECODE �̿��ϸ� ����)

���� 3
�ܹ������� SQL�� �ٸ����·� �����ϱ�

���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT),
            �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�, ���̺�), ROUND, JOIN










