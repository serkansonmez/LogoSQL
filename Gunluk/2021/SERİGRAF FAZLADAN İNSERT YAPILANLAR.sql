--SELECT *FROM LG_XT050_020 WHERE LOGREF = 6571
SELECT    XT50.LOGREF, ITEMS.LOGICALREF,
 (CASE ITEMS.CARDTYPE
        WHEN 1 THEN '(TM) Ticari Mal'
        WHEN 2 THEN '(KK) Karma Koli'
        WHEN 3 THEN '(DM) Depozitolu Mal'
        WHEN 4 THEN '(SK) Sabit K�ymet'
        WHEN 10 THEN '(HM) Hammadde'
        WHEN 11 THEN '(YM) Yar� Mamul'
        WHEN 12 THEN '(MM) Mamul'
        WHEN 13 THEN '(TK) T�ketim Mal�'
        WHEN 20 THEN '(MS) Genel Malzeme S�n�f�'
        WHEN 21 THEN '(MT) Tablolu Malzeme S�n�f�' ELSE '' END) AS ITEMS_CARDTYPE_TIPI,
		CASE WHEN ITM_DELIK.ITEMREF IS NOT NULL THEN 'VAR' ELSE 'YOK' END AS DELIK,
		CASE WHEN XT50.SERIGRAF = 'VAR' THEN 'VAR' ELSE 'YOK' END AS SERIGRAF,
        CASE WHEN XT50.TAMPERLI_LAMINE = 'LAM�NE' THEN 'VAR' ELSE 'YOK' END AS OTOKLAV,
        CASE WHEN XT50.OYUKLU_OYUKSUZ = 'OYUKLU' THEN 'VAR' ELSE 'YOK' END AS SUJETI,
ITEMS.CARDTYPE,ITEMS.CODE,ITEMS.NAME  
,TBL_FIRIN.LOGICALREF AS FIRINREF
,TBL_KESIM.LOGICALREF AS KESIMREF
,TBL_PAKETLEME.LOGICALREF AS PAKETLEMEREF
,TBL_RODAJ.LOGICALREF AS RODAJREF
,TBL_SERIGRAF.LOGICALREF AS SERIGRAFREF
,TBL_DELIK.LOGICALREF AS DELIKREF
,TBL_OTOKLAV.LOGICALREF AS OTOKLAVREF
,TBL_SUJETI.LOGICALREF AS SUJETIREF

 FROM LG_020_ITEMS ITEMS

LEFT JOIN (SELECT ITEMREF FROM LG_XT052 WHERE TIP = 'Delik' GROUP BY ITEMREF) ITM_DELIK   ON ITEMS.LOGICALREF = ITM_DELIK.ITEMREF 
LEFT JOIN LG_XT050_020 XT50 ON XT50.PARLOGREF= ITEMS.LOGICALREF 
LEFT JOIN LG_020_ITEMS TBL_DELIK ON TBL_DELIK.CARDTYPE=11 AND TBL_DELIK.ACTIVE = 0 AND TBL_DELIK.CODE = ITEMS.CODE + ' DEL�K'  
LEFT JOIN LG_020_ITEMS TBL_FIRIN ON TBL_FIRIN.CARDTYPE=11 AND TBL_FIRIN.ACTIVE = 0 AND TBL_FIRIN.CODE = ITEMS.CODE + ' FIRIN'  
LEFT JOIN LG_020_ITEMS TBL_KESIM ON TBL_KESIM.CARDTYPE=11 AND TBL_KESIM.ACTIVE = 0 AND TBL_KESIM.CODE = ITEMS.CODE + ' KES�M'  
LEFT JOIN LG_020_ITEMS TBL_PAKETLEME ON TBL_PAKETLEME.CARDTYPE=11 AND TBL_PAKETLEME.ACTIVE = 0 AND TBL_PAKETLEME.CODE = ITEMS.CODE + ' PAKETLEME'  
LEFT JOIN LG_020_ITEMS TBL_RODAJ ON TBL_RODAJ.CARDTYPE=11 AND TBL_RODAJ.ACTIVE = 0 AND TBL_RODAJ.CODE = ITEMS.CODE + ' RODAJ'  
LEFT JOIN LG_020_ITEMS TBL_SERIGRAF ON TBL_SERIGRAF.CARDTYPE=11 AND TBL_SERIGRAF.ACTIVE = 0 AND TBL_SERIGRAF.CODE = ITEMS.CODE + ' SER�GRAF'  
LEFT JOIN LG_020_ITEMS TBL_OTOKLAV ON TBL_OTOKLAV.CARDTYPE=11 AND TBL_OTOKLAV.ACTIVE = 0 AND TBL_OTOKLAV.CODE = ITEMS.CODE + ' OTOKLAV'   
LEFT JOIN LG_020_ITEMS TBL_SUJETI ON TBL_SUJETI.CARDTYPE=11 AND TBL_SUJETI.ACTIVE = 0 AND TBL_SUJETI.CODE = ITEMS.CODE + ' SU JET�'  

WHERE  XT50.LOGREF IS NOT NULL AND  ITEMS.CARDTYPE = 12 AND ITEMS.ACTIVE = 0   AND (TBL_FIRIN.LOGICALREF IS  NULL OR (ITM_DELIK.ITEMREF IS NOT NULL  AND TBL_DELIK.LOGICALREF IS NULL) OR TBL_KESIM.LOGICALREF IS NULL OR TBL_PAKETLEME.LOGICALREF IS NULL OR 
TBL_RODAJ.LOGICALREF IS NULL OR (TBL_SERIGRAF.LOGICALREF IS NULL AND XT50.SERIGRAF = 'VAR') OR (TBL_OTOKLAV.LOGICALREF IS NULL AND XT50.TAMPERLI_LAMINE = 'LAM�NE') OR (TBL_SUJETI.LOGICALREF IS NULL AND XT50.OYUKLU_OYUKSUZ = 'OYUKLU')  ) 

 AND XT50.SERIGRAF = 'YOK' AND TBL_SERIGRAF.LOGICALREF IS NOT NULL