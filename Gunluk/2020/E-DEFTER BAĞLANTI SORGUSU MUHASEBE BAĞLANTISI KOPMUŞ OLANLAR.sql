SELECT DISTINCT   LG_076_20_EBOOKDETAILDOC.LOGICALREF, LG_076_20_EMFLINE.TRCODE, LG_076_20_INVOICE.LOGICALREF, 
LG_076_20_INVOICE.FICHENO,
LG_076_20_EMFLINE.DATE_,
LG_076_20_EBOOKDETAILDOC.DOCUMENTNR 
--,LG_076_20_EBOOKDETAILDOC.*
--SELECT * FROM LG_076_20_EBOOKDETAILDOC
,'update LG_076_20_EBOOKDETAILDOC set UNDOCUMENTED=0, DOCUMENTTYPE=2, DOCUMENTNR=''' + LG_076_20_INVOICE.FICHENO + ''',DOCUMENTDATE=''' +

CAST(YEAR(LG_076_20_EMFLINE.DATE_) AS VARCHAR(4)) +
'0' + CAST(MONTH(LG_076_20_EMFLINE.DATE_) AS VARCHAR(2)) +
 REPLACE(STR( CAST(DAY(LG_076_20_EMFLINE.DATE_) AS VARCHAR(2)), 2), SPACE(1), '0') + ''',NOPAYMENT=1 WHERE LOGICALREF=' + CAST(LG_076_20_EBOOKDETAILDOC.LOGICALREF AS VARCHAR(20))
 
FROM LG_076_20_EMFLINE 
LEFT JOIN LG_076_20_EBOOKDETAILDOC ON LG_076_20_EBOOKDETAILDOC.EMFICHEREF = LG_076_20_EMFLINE.ACCFICHEREF
--left  JOIN LG_076_20_EMFLINE ON LG_076_20_EMFLINE.ACCFICHEREF = LG_076_20_EMFICHE.LOGICALREF --AND SIGN=1
--left  JOIN LG_076_20_EMFLINE ON LG_076_20_EMFLINE.LINEEXP = LG_076_20_EMFICHE.LOGICALREF --AND SIGN=1
--LEFT JOIN LG_076_20_CLFLINE ON LG_076_20_EMFLINE.SOURCEFREF = LG_076_20_CLFLINE.ACCFICHEREF
--LEFT JOIN LG_076_20_CLFLINE ON LG_076_20_EMFLINE.SOURCEFREF = LG_076_20_CLFLINE.ACCFICHEREF
LEFT JOIN LG_076_20_INVOICE ON SUBSTRING(LG_076_20_EMFLINE.LINEEXP,1,16) = LG_076_20_INVOICE.FICHENO 


WHERE --LG_076_20_EMFICHE.LOGICALREF = 4658 AND 
--LG_076_20_EMFICHE.TRCODE =4 AND 
 month(LG_076_20_EMFLINE.date_) >=4    AND  month(LG_076_20_EMFLINE.date_) <=6    
 --AND  LG_076_20_INVOICE.FICHENO LIKE '%GHZ2020000000004%'
 AND LG_076_20_EBOOKDETAILDOC.LOGICALREF IS NOT NULL
 AND  LG_076_20_INVOICE.FICHENO IS NOT NULL
 and LG_076_20_INVOICE.FICHENO <> LG_076_20_EBOOKDETAILDOC.DOCUMENTNR 