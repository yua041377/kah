SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

SELECT COUNT(*)
FROM
(SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer));

BUYER NAME �� �Ǽ� ��ȸ ���� �ۼ�
BUYER_NAME, �Ǽ�

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member,cart,prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;


SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member) JOIN prod ON(cart.cart_prod = prod.prod_id);


SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT *
FROM
    (SELECT deptno, COUNT(*)
    FROM emp
    GROUP BY deptno)
WHERE deptno = 30;

SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30
GROUP BY deptno;

SELECT *
FROM customer;

SELECT *
FROM product;

cycle : �����ֱ�
cid : �� id 
pid : ��ǰ id
day : ��������(�Ͽ���-1 ������-2 ȭ����...)
cnt : ����
SELECT *
FROM cycle

SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid AND customer.cnm != 'cony');

SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid 
      AND customer.cnm IN('brown','sally');


SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON(cycle.pid = product.pid AND customer.cnm != 'cony');

SELECT customer.cid, customer.cnm, cycle.pid, product.pnm,cycle.day,cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid 
      AND cycle.pid = product.pid
      AND customer.cnm IN('brown','sally');

SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt) cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) 
              JOIN product ON(cycle.pid = product.pid)
GROUP BY customer.cid, customer.cnm, cycle.pid,product.pnm;

SELECT cycle.pid, product.pnm, SUM(cycle.cnt) cnt
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, product.pnm;

SELECT region_id, region_name, country_name
FROM countries JOIN regions ON(

SELECT *
FROM regions;

