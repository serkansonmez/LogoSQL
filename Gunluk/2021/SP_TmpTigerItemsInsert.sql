USE [KrcB2B_Default_v1]
GO
/****** Object:  StoredProcedure [dbo].[SP_TmpTigerItemsInsert]    Script Date: 07/01/2021 16:23:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
FROM KRC2015.DBO.LG_015_ITEMS ITM
/*
LEFT JOIN 
(SELECT STOCKREF AS STOCKREF,
        
         SUM(ISNULL(  KRC2015.DBO.LG_015_01_GETSTTRANSCOEF(TRCODE,
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
                    * (KRC2015.DBO.LG_015_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND 
           
    FROM KRC2015.[DBO].LG_015_01_STLINE
   WHERE (    CANCELLED = 0
          AND STATUS = 0
          AND ORDTRANSREF = 0
          AND STOCKREF <> 0
          AND LINETYPE NOT IN (2, 3, 7))
         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0))
GROUP BY STOCKREF )  AS  TBL_STOK ON TBL_STOK.STOCKREF = ITM.LOGICALREF
*/
LEFT JOIN (SELECT STOCKREF,SUM(ONHAND) AS ONHAND FROM KRC2015.DBO.LV_015_01_STINVTOT WHERE INVENNO = -1 GROUP BY STOCKREF )  AS  TBL_STOK ON TBL_STOK.STOCKREF = ITM.LOGICALREF

LEFT JOIN (SELECT DISTINCT CARDREF,ISNULL(PRICE,0) AS PRICE,CUR.CURTYPE,CUR.CURCODE  FROM  KRC2015.[dbo].LG_015_PRCLIST Q1 
left join SMDB.DBO.L_CURRENCYLIST  CUR  ON CUR.CURTYPE = Q1.CURRENCY
WHERE Q1.LOGICALREF IN 
(SELECT TOP 1 LOGICALREF FROM  KRC2015.[dbo].LG_015_PRCLIST Q2 WHERE Q1.CARDREF =  Q2.CARDREF ORDER BY Q2.BEGDATE DESC)
) TBL_FIYAT ON TBL_FIYAT.CARDREF = ITM.LOGICALREF
WHERE  TBL_STOK.ONHAND>0 OR TBL_FIYAT.PRICE > 0

END