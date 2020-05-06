SELECT ROWNUM rn,a.sido,a.sigungu,a.city_idx,b.sido,b.sigungu,b.cnt
FROM
(SELECT ROWNUM rn, sido, sigungu, city_idx
FROM (SELECT ROWNUM rn, bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
                ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx
FROM
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = 'KFC'
 GROUP BY sido, sigungu)kfc,
                        
(SELECT SIDO, SIGUNGU, count(*) cnt
 FROM fastfood
 WHERE gb = '맥도날드'
 GROUP BY sido, sigungu) mac,
                                                 
(SELECT SIDO, SIGUNGU, count(*) cnt
FROM fastfood
 WHERE gb = '롯데리아'
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