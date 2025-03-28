 SELECT   
 sum(	CASE      WHEN STL.IOCODE IN(1,0) THEN AMOUNT
											 ELSE 0 END )  as 'GirisMiktari',
                    sum(   CASE   WHEN STL.IOCODE IN(1,0)  THEN VATMATRAH
											 ELSE 0 END  ) as 'GirisKdvMatrahi',
					 		year(INV.DATE_) AS YIL,
							MONTH(INV.DATE_) AS AY
FROM         LG_023_01_STLINE STL  WITH(NOLOCK)
--LEFT OUTER JOIN  LG_023_ITEMS ITM ON ITM.LOGICALREF = STL.STOCKREF AND STL.LINETYPE IN (0) 
--LEFT OUTER JOIN  LG_023_SRVCARD SRV WITH(NOLOCK) ON STL.STOCKREF = SRV.LOGICALREF AND STL.LINETYPE=4
--LEFT OUTER JOIN  LG_023_UNITSETL UNTL WITH(NOLOCK) ON UNTL.LOGICALREF=STL.UOMREF
--LEFT OUTER JOIN  L_CAPIWHOUSE   CAPI WITH(NOLOCK) ON CAPI.NR=STL.SOURCEINDEX AND CAPI.FIRMNR=023
LEFT OUTER JOIN  LG_023_01_INVOICE INV WITH(NOLOCK) ON INV.LOGICALREF=STL.INVOICEREF
--LEFT OUTER JOIN  LG_023_CLCARD CLC WITH(NOLOCK) ON CLC.LOGICALREF=STL.CLIENTREF
LEFT OUTER JOIN  LG_023_EMCENTER EMCENTER WITH(NOLOCK) ON EMCENTER.LOGICALREF=STL.CENTERREF
WHERE EMCENTER.CODE =  '15' AND INV.TRCODE <> 25  GROUP BY year(INV.DATE_) , MONTH(INV.DATE_) 
