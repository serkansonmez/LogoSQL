USE [TIGER3_STEEL]
GO

/****** Object:  View [dbo].[EMY_120_01_VARIANT]    Script Date: 12.10.2021 21:19:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 


 ALTER VIEW [dbo].[EMY_120_01_VARIANT]  AS
  SELECT STOCKREF AS STOCKREF,
         SOURCEINDEX AS INVENNO,
         DATE_ AS DATE_,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  23)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNPRODIN,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  24)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNPRODOUT,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  26)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNOTHERIN,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  27)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNOTHEROUT,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  28)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNWHOUSEIN,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  29)
               * (CASE
                     WHEN PLNAMOUNT + PORDCLSPLNAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNAMOUNT - PORDCLSPLNAMNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNWHOUSEOUT,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         1)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS TEMPIN,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                               SOURCELINK,
                                         BILLED,
                                         2)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS TEMPOUT,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         3)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTPRODIN,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         4)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTOTHERIN,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         5)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTWASTE,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         6)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTOTHEROUT,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         7)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS TRANSFERRED,
         SUM(ISNULL(DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                       IOCODE,
                                       LINETYPE,
                                       0,
                                       LPRODSTAT,
                                       LPRODRSRVSTAT,
                                       0,
                                       SOURCELINK,
                                       BILLED,
                                       17)
                    * (LINENET+DIFFPRICE),
                    0))
            AS AVGVALUE,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         17)
                    * (CASE WHEN REPORTRATE = 0 THEN 0 ELSE (LINENET+DIFFPRICE) END)
                    / (CASE WHEN REPORTRATE = 0 THEN 1 ELSE REPORTRATE END),
                    0))
            AS AVGCURRVAL,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         8)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS PURAMNT,
         SUM(ISNULL(DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                       IOCODE,
                                       LINETYPE,
                                       0,
                                       0,
                                       0,
                                       0,
                                       SOURCELINK,
                                       BILLED,
                                       9)
                    * (LINENET+DIFFPRICE),
                    0))
            AS PURCASH,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         9)
                    * (CASE WHEN REPORTRATE = 0 THEN 0 ELSE (LINENET+DIFFPRICE) END)
                    / (CASE WHEN REPORTRATE = 0 THEN 1 ELSE REPORTRATE END),
                    0))
            AS PURCURR,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         10)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS SALAMNT,
         SUM(ISNULL(DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                       IOCODE,
                                       LINETYPE,
                                       0,
                                       0,
                                       0,
                                       0,
                                       SOURCELINK,
                                       BILLED,
                                       11)
                    * (LINENET+DIFFPRICE),
                    0))
            AS SALCASH,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         11)
                    * (CASE WHEN REPORTRATE = 0 THEN 0 ELSE (LINENET+DIFFPRICE) END)
                    / (CASE WHEN REPORTRATE = 0 THEN 1 ELSE REPORTRATE END),
                    0))
            AS SALCURR,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
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
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         13)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTWHOUSEIN,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         14)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ACTWHOUSEOUT,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         15)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS COUNTADD,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         0,
                                         0,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         16)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS COUNTDEC,
         SUM(ISNULL(DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                       IOCODE,
                                       LINETYPE,
                                       0,
                                       0,
                                       0,
                                       DISTORDLINEREF,
                                       SOURCELINK,
                                       BILLED,
                                       25)
                    * AMOUNT,
                    0))
            AS ONVEHICLE,
         VARIANTREF AS VARIANTREF,
           SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  30)
               * (CASE
                     WHEN PLNAMOUNT + PLNUNRSRVAMOUNT + PORDCLSPLNUNRSRVAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNUNRSRVAMOUNT - PORDCLSPLNUNRSRVAMNT - PLNAMOUNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNRSRVPRODIN,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  31)
               * (CASE
                     WHEN PLNAMOUNT + PLNUNRSRVAMOUNT + PORDCLSPLNUNRSRVAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNUNRSRVAMOUNT - PORDCLSPLNUNRSRVAMNT - PLNAMOUNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNRSRVPRODOUT,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  32)
               * (CASE
                     WHEN PLNAMOUNT + PLNUNRSRVAMOUNT + PORDCLSPLNUNRSRVAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNUNRSRVAMOUNT - PORDCLSPLNUNRSRVAMNT - PLNAMOUNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNRSRVWHOUSEIN,
         SUM(
            ISNULL(
               DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                  IOCODE,
                                  LINETYPE,
                                  0,
                                  LPRODSTAT,
                                  LPRODRSRVSTAT,
                                  0,
                                  SOURCELINK,
                                  BILLED,
                                  33)
               * (CASE
                     WHEN PLNAMOUNT + PLNUNRSRVAMOUNT + PORDCLSPLNUNRSRVAMNT >= AMOUNT
                     THEN
                        0
                     ELSE
                        AMOUNT - PLNUNRSRVAMOUNT - PORDCLSPLNUNRSRVAMNT - PLNAMOUNT
                  END)
               * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
               0))
            AS PLNRSRVWHOUSEOUT,
         SUM(ISNULL(  DBO.LG_120_01_GETSTTRANSCOEF(TRCODE,
                                         IOCODE,
                                         LINETYPE,
                                         0,
                                         LPRODSTAT,
                                         LPRODRSRVSTAT,
                                         0,
                                         SOURCELINK,
                                         BILLED,
                                         17)
                    * AMOUNT
                    * (DBO.LG_120_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND_AVG,
         (CASE WHEN LINETYPE IN (4,11) THEN 1 ELSE 0 END) AS TYP
      --  , COUNT_BIG(*) AS CNT
		 ,LG_120_VARIANT.CODE AS VARIANTCODE
		 ,LG_120_VARIANT.NAME AS VARIANTNAME
		 ,LG_120_VARIANT.ACTIVE AS VARIANTACTIVE
    FROM [DBO].LG_120_01_STLINE
	LEFT JOIN LG_120_VARIANT ON LG_120_VARIANT.LOGICALREF = LG_120_01_STLINE.VARIANTREF
   WHERE (    CANCELLED = 0
          AND STATUS = 0
          AND ORDTRANSREF = 0
          AND STOCKREF <> 0
          AND LINETYPE NOT IN (2, 3, 7))
         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0)) AND LG_120_VARIANT.LOGICALREF IS NOT NULL
GROUP BY STOCKREF,
         DATE_,
         SOURCEINDEX,
         VARIANTREF,
         (CASE WHEN LINETYPE IN (4,11) THEN 1 ELSE 0 END)
		  ,LG_120_VARIANT.CODE 
		 ,LG_120_VARIANT.NAME 
		 ,LG_120_VARIANT.ACTIVE 

GO


select *  from LG_120_VARIANT
select *  from LG_120_UNITSETC
select *  from LG_120_UNITSETF
select *  from LG_120_CHARSET
select *  from LG_120_CHARVAL
select *  from LG_120_CHARCODE
SELECT * FROM LG_120_VRNTCHARASGN
SELECT * FROM LG_120_ITMUNITA WHERE   ITEMREF = 993    AND VARIANTREF  =0
select * from LG_120_INVDEF where ITEMREF = 993 AND VARIANTREF  =0
select * from LG_120_ITMFACTP where ITEMREF = 993 AND VARIANTREF  =0



bununla ilgili bir fonksiyon veya SP yazalým.
X,Y,Z gönderelim, yoksa herþeyi açsýn
LG_120_CHARVAL
ve ardýndan
LG_120_VARIANT
sonra da LOD üzerinden referansý baðlayalým satýra
bir örnek varyant daha ekleyelim mi?
