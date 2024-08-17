 
SELECT    ROUND(EN * BOY * AMOUNT / 1000000,2) AS M2,CL.SPECODE AS CARITUR,INV.FICHENO AS FISNO,STRNS.DATE_ AS TARIH, 0 AS DOVIZTUTAR,
MONTH(INV.DATE_) AS AY,YEAR(INV.DATE_) AS YIL,INV.TRRATE,   STRNS.SOURCEINDEX, STRNS.DISCPER, STRNS.VAT, STRNS.OUTPUTIDCODE, STRNS.AMOUNT,STRNS.TOTAL  ,STRNS.LINENET  
,CL.CODE as CARIKODU ,CL.DEFINITION_ AS CARIADI
FROM TIGER..LG_024_01_INVOICE INV WITH(NOLOCK)     
LEFT JOIN  TIGER..LG_024_CLCARD CL ON INV.CLIENTREF = CL.LOGICALREF   
LEFT JOIN TIGER..LG_024_01_STLINE STRNS WITH(NOLOCK) ON  INV.LOGICALREF = STRNS.INVOICEREF   
LEFT JOIN TIGER..LG_024_ITEMS ITM WITH(NOLOCK) ON  ITM.LOGICALREF = STRNS.STOCKREF   
LEFT OUTER JOIN TIGER..LG_024_EMUHACC GLACC WITH(NOLOCK) ON (STRNS.ACCOUNTREF  =  GLACC.LOGICALREF) 
LEFT OUTER JOIN "TIGER"..LG_SLSMAN SLSMC WITH(NOLOCK) ON (STRNS.SALESMANREF = SLSMC.LOGICALREF)    
LEFT JOIN TIGER..LG_XT050_024 WITH(NOLOCK) ON PARLOGREF=STOCKREF    WHERE     EN> 0 AND           INV.CANCELLED = 0       AND (STRNS.DETLINE = 0) AND 
(STRNS.SOURCEINDEX IN (0,1,3,7,8,10,11,12))         AND INV.TRCODE IN (8)    AND CL.SPECODE = '' 

UNION ALL
SELECT 
	ROUND(EN * BOY * AMOUNT / 1000000,2) AS M2,CL.SPECODE AS CARITUR,INV.FICHENO AS FISNO,STRNS.DATE_ AS TARIH, ROUND((STRNS.LINENET  / CASE WHEN INV.TRRATE = 0 THEN 1 ELSE INV.TRRATE END ),2) AS DOVIZTUTAR, MONTH(INV.DATE_) AS AY,YEAR(INV.DATE_) AS YIL,INV.TRRATE,
	STRNS.SOURCEINDEX, STRNS.DISCPER, STRNS.VAT, STRNS.OUTPUTIDCODE, STRNS.AMOUNT,STRNS.TOTAL ,STRNS.LINENET 
	,CL.CODE as CARIKODU ,CL.DEFINITION_ AS CARIADI
	 FROM TIGER..LG_024_01_INVOICE INV WITH(NOLOCK) 
	 LEFT JOIN  TIGER..LG_024_CLCARD CL ON INV.CLIENTREF = CL.LOGICALREF
	LEFT JOIN TIGER..LG_024_01_STLINE STRNS WITH(NOLOCK) ON  INV.LOGICALREF = STRNS.INVOICEREF
	LEFT JOIN TIGER..LG_024_ITEMS ITM WITH(NOLOCK) ON  ITM.LOGICALREF = STRNS.STOCKREF
	LEFT OUTER JOIN TIGER..LG_024_EMUHACC GLACC WITH(NOLOCK) ON (STRNS.ACCOUNTREF  =  GLACC.LOGICALREF) LEFT OUTER JOIN "TIGER"..LG_SLSMAN SLSMC WITH(NOLOCK) ON (STRNS.SALESMANREF = SLSMC.LOGICALREF)
	 LEFT JOIN TIGER..LG_XT050_024 WITH(NOLOCK) ON PARLOGREF=STOCKREF
	 WHERE 
	 EN> 0 AND 
 
	   INV.CANCELLED = 0
	--(STRNS.INVOICEREF = 7869) 
	AND (STRNS.DETLINE = 0) AND (STRNS.SOURCEINDEX IN (0,1,3,7,8,10,11,12))      
	AND INV.TRCODE IN (8)
	 AND CL.SPECODE LIKE '%HRACAT%'
	 UNION ALL
	 -- GEL�R / 03- H�ZMET
	 	SELECT 
	0 AS M2,CL.SPECODE AS CARITUR,INV.FICHENO AS FISNO,INV.DATE_ AS TARIH,0 AS DOVIZTUTAR, MONTH(INV.DATE_) AS AY,YEAR(INV.DATE_) AS YIL,INV.TRRATE,
	STRNS.SOURCEINDEX, STRNS.DISCPER, STRNS.VAT, STRNS.OUTPUTIDCODE, STRNS.AMOUNT,STRNS.TOTAL  ,STRNS.LINENET
	,CL.CODE as CARIKODU ,CL.DEFINITION_ AS CARIADI
	 FROM TIGER..LG_024_01_INVOICE INV WITH(NOLOCK) 
	 LEFT JOIN  TIGER..LG_024_CLCARD CL ON INV.CLIENTREF = CL.LOGICALREF
	LEFT JOIN TIGER..LG_024_01_STLINE STRNS WITH(NOLOCK) ON  INV.LOGICALREF = STRNS.INVOICEREF
	LEFT JOIN TIGER..LG_024_ITEMS ITM WITH(NOLOCK) ON  ITM.LOGICALREF = STRNS.STOCKREF
	LEFT OUTER JOIN TIGER..LG_024_EMUHACC GLACC WITH(NOLOCK) ON (STRNS.ACCOUNTREF  =  GLACC.LOGICALREF) LEFT OUTER JOIN "TIGER"..LG_SLSMAN SLSMC WITH(NOLOCK) ON (STRNS.SALESMANREF = SLSMC.LOGICALREF)
	 
	 WHERE 
	 
  
	   INV.CANCELLED = 0
	--(STRNS.INVOICEREF = 7869) 
	AND (STRNS.DETLINE = 0) AND (STRNS.SOURCEINDEX IN (0,1,3,7,8,10,11,12))      
	AND INV.TRCODE IN (9)
	   
	    -- GEL�R   04- D��ER FATURALAR
	 UNION ALL
	 
		  SELECT M2,'' AS CARITUR, '' FISNO, CAST(CONCAT(Yil, '-', Ay, '-01') AS DATE) AS TARIH,0 AS DOVIZTUTAR,AY,Yil,0 as TRRATE,0 AS SOURCEINDEX,0 AS DISCPER, 20 AS VAT,'' AS OUTPUTIDCODE,
		  OrtalamaM2Fiyati,FaturaTutari as TOTAL,FaturaTutari AS LINENET
 ,'' as CARIKODU ,'' AS CARIADI
    FROM FercamB2B_Default_v1.[dbo].[FinansDigerFatura]


	 -- GEL�R    '05.KDV �ADE

	 UNION ALL
	 
		  SELECT 0 M2,'' AS CARITUR, '' FISNO, CAST(CONCAT(Yil, '-', Ay, '-01') AS DATE) AS TARIH,0 AS DOVIZTUTAR,AY,Yil,0 as TRRATE,0 AS SOURCEINDEX,0 AS DISCPER, 20 AS VAT,'' AS OUTPUTIDCODE,
		  0 as OrtalamaM2Fiyati,Toplam as TOTAL,Toplam AS LINENET
 ,'' as CARIKODU ,'' AS CARIADI
    FROM FercamB2B_Default_v1.[dbo].VW_KdvIadeDosyasi

	-- G�DER   01-CAM
	UNION ALL
	 SELECT   
 	SUM(CASE      WHEN STL.IOCODE IN(1,0) THEN AMOUNT
ELSE 0  END)   AS M2,CL.SPECODE AS CARITUR,INV.FICHENO AS FISNO,INV.DATE_ AS TARIH, ROUND((INV.NETTOTAL  / CASE WHEN INV.TRRATE = 0 THEN 1 ELSE INV.TRRATE END ),2) AS DOVIZTUTAR, 
		MONTH(INV.DATE_) AS AY,YEAR(INV.DATE_) AS YIL,INV.TRRATE,
	INV.SOURCEINDEX, 0.00 AS DISCPER, INV.VAT, '' AS OUTPUTIDCODE, 0.00 AS  AMOUNT,INV.NETTOTAL as TOTAL ,INV.NETTOTAL LINENET 
	,CL.CODE as CARIKODU ,CL.DEFINITION_ AS CARIADI
FROM         TIGER..LG_024_01_STLINE STL  WITH(NOLOCK)
LEFT OUTER JOIN  TIGER..LG_024_01_INVOICE INV WITH(NOLOCK) ON INV.LOGICALREF=STL.INVOICEREF
LEFT OUTER JOIN  TIGER..LG_024_CLCARD CL WITH(NOLOCK) ON INV.CLIENTREF=CL.LOGICALREF
LEFT OUTER JOIN  TIGER..LG_024_EMCENTER EMCENTER WITH(NOLOCK) ON EMCENTER.LOGICALREF=STL.CENTERREF
WHERE EMCENTER.CODE =  '15' AND INV.TRCODE <> 25   GROUP BY year(INV.DATE_) , MONTH(INV.DATE_) ,CL.SPECODE,INV.FICHENO,INV.DATE_,INV.NETTOTAL,INV.TRRATE,INV.SOURCEINDEX,INV.VAT,CL.CODE   ,CL.DEFINITION_