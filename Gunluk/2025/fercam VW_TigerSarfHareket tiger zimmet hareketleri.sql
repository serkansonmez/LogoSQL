 

SELECT STL.DATE_ AS TARIH,STF.FICHENO AS SARFFISINO, CODE AS URUNKODU,NAME AS URUNADI,STL.SPECODE AS ZIMMETVERILEN,STL.SPECODE2,SPECODE3,NAME3,NAME4
,AMOUNT AS SARFZIMMETADET FROM TIGER..LG_025_01_STLINE STL
LEFT JOIN TIGER..LG_025_ITEMS ITM ON ITM.LOGICALREF = STL.STOCKREF
LEFT JOIN TIGER..LG_025_01_STFICHE STF ON STF.LOGICALREF = STL.STFICHEREF
WHERE ITM.SPECODE3 LIKE 'PERSONEL%'
 



 SELECT  DISTINCT ITM.SPECODE3  FROM TIGER..LG_025_01_STLINE STL
LEFT JOIN TIGER..LG_025_ITEMS ITM ON ITM.LOGICALREF = STL.STOCKREF
LEFT JOIN TIGER..LG_025_01_STFICHE STF ON STF.LOGICALREF = STL.STFICHEREF
--WHERE ITM.SPECODE3 LIKE 'GENEL%'
 

 SELECT SPECODE, * FROM  TIGER..LG_025_01_STLINE WHERE SPECODE LIKE 'ABDU%'

 SELECT * FROM VW_TigerSarfHareket WHERE DEPARTMAN = 'PERSONEL' AND TcKimlikNo = '74635096066'

 SELECT * FROM TIGER..LG_025_SPECODES WHERE DEFINITION_ LIKE 'ABD%'