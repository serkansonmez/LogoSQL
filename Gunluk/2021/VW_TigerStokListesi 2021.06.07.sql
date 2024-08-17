USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_TigerStokListesi]    Script Date: 7.06.2021 12:33:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--select * from [VW_TigerStokListesi]

 ALTER view [dbo].[VW_TigerStokListesi] as 
SELECT DISTINCT  
--ITM.STGRPCODE, jantlarýn kontrolü için
 cast( STOCKREF  as varchar(20))  as [LOGICALREF]
      ,ITM.CODE AS  [StokKodu]
      ,ITM.NAME AS [StokAdi]
	   
	  -- ,ITM.SPECODE5 AS [Marka]
	  ,'' as Ebat
      
      
	  
      ,ONHAND  as [DepoMiktari]
       
	  ,ISNULL(PRICE,0) as BirimFiyat
      ,0 [EnvanterTutari]
       
      ,Case 
	         when ONHAND>20 then '20+' 
		 else 
	         cast(ONHAND as varchar(20)) 
	  end as [DepoMiktariStr]
	  ,ITM.PRODUCERCODE as UreticiKodu
	   
      ,0 as SatisFiyati
	-- ,FiyatListeleri.FiyatListeleriId as ParekendeFiyat
	  ,'TL' as DovizTuru
	   ,160 as DovizTurReferans
	   ,case when ITM.VAT is null then 18 else ITM.VAT end AS KdvOran
	   ,(Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) as KdvliFiyat
	   ,((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) ) + 
	   ((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0))  * n11.KomisyonOrani / 100) as N11Fiyat
	   ,((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) ) + 
	   ((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0))  * openCard.KomisyonOrani / 100) as OpenCardFiyat
	   ,((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) ) + 
	   ((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0))  * trendyol.KomisyonOrani / 100) as TrendyolFiyat
	   ,((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) ) + 
	   ((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0))  * hepsiBurada.KomisyonOrani / 100) as HepsiBuradaFiyat
      ,((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0)) ) + 
	   ((Round(ISNULL(PRICE,0) + (case when ITM.VAT is null then 18 else ITM.VAT end  * ISNULL(PRICE,0) / 100),0))  * amazon.KomisyonOrani / 100) as AmazonFiyat

  --FROM (SELECT STOCKREF,INVENNO, SUM(ONHAND) AS ONHAND FROM TIGER3.[dbo].LV_003_01_STINVTOT_V1   GROUP BY STOCKREF,INVENNO  ) ENV

  FROM ( SELECT STOCKREF AS STOCKREF,
        
         SUM(ISNULL(  TIGER3.DBO.LG_003_01_GETSTTRANSCOEF(TRCODE,
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
                    * (TIGER3.DBO.LG_003_01_GETUNITCOEF(UINFO1, UINFO2)),
                    0))
            AS ONHAND 
    FROM TIGER3.[DBO].LG_003_01_STLINE
   WHERE (    CANCELLED = 0
          AND STATUS = 0
          AND ORDTRANSREF = 0
          AND STOCKREF <> 0
          AND LINETYPE NOT IN (2, 3, 7))
         AND NOT ((TRCODE IN (5, 10) AND STFICHEREF = 0))
GROUP BY STOCKREF     ) ENV
  left join TIGER3.[dbo].LG_003_ITEMS ITM  WITH(NOLOCK) ON    ENV.STOCKREF = ITM.LOGICALREF
  left join (SELECT CARDREF,ISNULL(PRICE,0) AS PRICE FROM  TIGER3.[dbo].LG_003_PRCLIST Q1 WHERE Q1.CARDREF IN 
(SELECT TOP 1 CARDREF FROM  TIGER3.[dbo].LG_003_PRCLIST Q2 WHERE Q1.CARDREF =  Q2.CARDREF ORDER BY Q2.BEGDATE DESC)) AS TblFiyat on 
TblFiyat.CARDREF = ITM.LOGICALREF
 -- LEFT JOIN TIGER3.[dbo].LG_003_SPECODES MARKA ON MARKA.SPECODE = ITM.SPECODE5
  LEFT JOIN Pazaryerleri n11 WITH(NOLOCK) ON n11.PazaryeriAdi='N11'
  LEFT JOIN Pazaryerleri openCard WITH(NOLOCK) ON openCard.PazaryeriAdi='Opencard'
  LEFT JOIN Pazaryerleri hepsiBurada WITH(NOLOCK) ON hepsiBurada.PazaryeriAdi='HepsiBurada'
  LEFT JOIN Pazaryerleri amazon WITH(NOLOCK) ON amazon.PazaryeriAdi='Amazon'
  LEFT JOIN Pazaryerleri trendyol WITH(NOLOCK) ON trendyol.PazaryeriAdi='Trendyol'
 
   WHERE ONHAND>0  --and ITM.CYPHCODE = 'B2B' 
 --and
GO


