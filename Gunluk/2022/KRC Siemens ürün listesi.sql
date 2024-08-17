USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_SiemensStokListesi]    Script Date: 03/21/2022 15:29:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO















--select * from [VW_SiemensStokListesi]

ALTER view [dbo].[VW_SiemensStokListesi] as 
SELECT DISTINCT  
--ITM.STGRPCODE, jantlarýn kontrolü için
  
      
      isnull( ITM.NAME,'') AS name
	   
	  
	  ,'https://krcelektromarket.com/' + isnull( Urunler.SeoBaglantisi,'') as url
     -- ,replace(isnull(urunler.LogoMalzemeKodu,''),' ','-') as mlfb
      ,replace(isnull(urunler.Sku,''),' ','-') as mlfb
      
	  
      ,ONHAND  as stock
     -- , STOCKREF
    
  FROM ( 
  
  select STOCKREF, SUM(ONHAND) AS ONHAND from KRC2022.DBO.LV_022_01_STINVTOT where INVENNO = -1 GROUP BY STOCKREF
  
--  SELECT STOCKREF AS STOCKREF,
        
--         SUM(ISNULL(  KRC2022.DBO.LG_022_01_GETSTTRANSCOEF(TRCODE,
--                                         IOCODE,
--                                         LINETYPE,
--                                         0,
--                                         LPRODSTAT,
--                                         LPRODRSRVSTAT,
--                                         0,
--                                         SOURCELINK,
--                                         BILLED,
--                                         12)
--                    * AMOUNT
--                    * (KRC2022.DBO.LG_022_01_GETUNITCOEF(UINFO1, UINFO2)),
--                    0))
--            AS ONHAND 
--    FROM KRC2022.[DBO].LG_022_01_STLINE
--   WHERE (    CANCELLED = 0
--          AND STATUS = 0
--          AND ORDTRANSREF = 0
--          AND STOCKREF <> 0
--          AND LINETYPE NOT IN (2, 3, 7))
--         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0))
--GROUP BY STOCKREF     



) ENV
  left join KRC2022.[dbo].LG_022_ITEMS ITM  WITH(NOLOCK) ON    ENV.STOCKREF = ITM.LOGICALREF
  left join (select top 1 * from DovizKurlari order by DovizKurlariId desc) as DovizKurlari  on 1=1
  left join Urunler on Urunler.LogoMalzemeKodu COLLATE SQL_Latin1_General_CP1254_CI_AS = ITM.CODE
left join (SELECT CARDREF,ISNULL(PRICE, 0) AS PRICE,CUR.CURTYPE,CUR.CURCODE FROM  KRC2022.DBO.LG_022_PRCLIST Q1 
left join KRC2022.DBO.L_CURRENCYLIST CUR ON CUR.CURTYPE = Q1.CURRENCY

WHERE Q1.CARDREF IN 
(SELECT TOP 1 CARDREF FROM  KRC2022.DBO.LG_022_PRCLIST Q2 WHERE Q1.CARDREF =  Q2.CARDREF ORDER BY Q2.BEGDATE DESC)) AS TblFiyat on 
TblFiyat.CARDREF = ITM.LOGICALREF
 
   WHERE --MarkaId = 17 and ONHAND>0    and len(urunler.Sku)> 3 and 
   urunler.UrunlerId = 12858 
    --and ITM.CYPHCODE = 'B2B' 
  -- AND Urunler.UrunlerId is not null
 --and

--select * from Urunler
--select * from Marka




GO


