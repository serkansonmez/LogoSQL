 
 
  SELECT STOCKREF AS STOCKREF,
  COUNT(STOCKREF),
        -- SOURCEINDEX AS INVENNO,
         SUM(ISNULL(  DBO.LG_003_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         12)
                    * AMOUNT
                    * (DBO.LG_003_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND 
    FROM [DBO].LG_003_01_STLINE
   WHERE (    CANCELLED = 0
          AND STATUS = 0
          AND ORDTRANSREF = 0
          AND STOCKREF <> 0
          AND LINETYPE NOT IN (2, 3, 7))
         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0))
GROUP BY STOCKREF --, SOURCEINDEX  
        
         

GO


