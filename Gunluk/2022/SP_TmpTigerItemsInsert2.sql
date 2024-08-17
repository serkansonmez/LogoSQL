USE [KrcB2B_Default_v1]
GO
/****** Object:  StoredProcedure [dbo].[SP_TmpTigerItemsInsert]    Script Date: 03/29/2022 09:06:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from [TmpTigerItems] where LOGICALREF = 162983  145662
--exec [SP_TmpTigerItemsInsert]
ALTER PROCEDURE [dbo].[SP_TmpTigerItemsInsert]
  
AS
BEGIN

IF not  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TmpTigerItems]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[TmpTigerItems](
		[LOGICALREF] [int] NOT NULL,
		[CODE] [varchar](25) NULL,
		[NAME] [varchar](51) NULL,
		[ONHAND] [float] NULL,
		[PRICE] [float] NOT NULL,
		[PRODUCERCODE] [varchar](50) NULL,
		VAT int NOT NULL,
		CURCODE VARCHAR(20) ,
		CURTYPE INT ,
	) ON [PRIMARY]
end

truncate table [TmpTigerItems]
insert into [TmpTigerItems]
SELECT LOGICALREF, CODE, NAME,TBL_STOK.ONHAND, ISNULL(TBL_FIYAT.PRICE,0) AS PRICE  ,PRODUCERCODE,VAT,CURCODE,CURTYPE
FROM krc2022.DBO.LG_022_ITEMS ITM
/*
LEFT JOIN 
(SELECT STOCKREF AS STOCKREF,
        
         SUM(ISNULL(  krc2022.DBO.LG_022_01_GETSTTRANSCOEF(TRCODE,
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
                    * (krc2022.DBO.LG_022_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND 
           
    FROM krc2022.[DBO].LG_022_01_STLINE
   WHERE (    CANCELLED = 0
          AND STATUS = 0
          AND ORDTRANSREF = 0
          AND STOCKREF <> 0
          AND LINETYPE NOT IN (2, 3, 7))
         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0))
GROUP BY STOCKREF )  AS  TBL_STOK ON TBL_STOK.STOCKREF = ITM.LOGICALREF
*/
--LEFT JOIN (SELECT STOCKREF,SUM(ONHAND) AS ONHAND FROM krc2022.DBO.LV_022_01_STINVTOT WHERE INVENNO = -1 GROUP BY STOCKREF )  AS  TBL_STOK ON TBL_STOK.STOCKREF = ITM.LOGICALREF
LEFT JOIN (SELECT STOCKREF,SUM(ONHAND) AS ONHAND FROM krc2022.DBO.LV_022_01_STINVTOT
  WHERE INVENNO IN (
1000,
1110,
1120,
1130,
1140,
1150,
1160,
1170,
1190,
1200,
1210,
1220,
1230,
1240  )

 GROUP BY STOCKREF )  AS  TBL_STOK ON TBL_STOK.STOCKREF = ITM.LOGICALREF

LEFT JOIN (SELECT DISTINCT CARDREF,ISNULL(PRICE,0) AS PRICE,CUR.CURTYPE,CUR.CURCODE  FROM  krc2022.[dbo].LG_022_PRCLIST Q1 
left join SMDB.DBO.L_CURRENCYLIST  CUR  ON CUR.CURTYPE = Q1.CURRENCY
WHERE Q1.LOGICALREF IN 
(SELECT TOP 1 LOGICALREF FROM  krc2022.[dbo].LG_022_PRCLIST Q2 WHERE Q1.CARDREF =  Q2.CARDREF AND PRICE>0 ORDER BY Q2.BEGDATE DESC)
) TBL_FIYAT ON TBL_FIYAT.CARDREF = ITM.LOGICALREF
WHERE  TBL_STOK.ONHAND>0 OR TBL_FIYAT.PRICE > 0

END