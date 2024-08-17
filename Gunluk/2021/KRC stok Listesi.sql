alter view [dbo].[VW_TigerStokListesi] as
SELECT 
--ITM.STGRPCODE, jantlarýn kontrolü için
 cast( STOCKREF  as varchar(21))  as [LOGICALREF]
      ,ITM.CODE AS  [StokKodu]
      ,ITM.NAME AS [StokAdi]
	   
	  -- ,ITM.SPECODE5 AS [Marka]
	  ,'' as Ebat
      
      
	  
      ,ONHAND  as [DepoMiktari]
       
	  ,ISNULL(PRICE,0) as BirimFiyat
      ,0 [EnvanterTutari]
       
      ,Case 
	         when ONHAND>21 then '21+' 
		 else 
	         cast(ONHAND as varchar(21)) 
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

  FROM (SELECT STOCKREF, SUM(ONHAND) AS ONHAND FROM KRC2015.[dbo].LV_015_01_STINVTOT_V1   GROUP BY STOCKREF  ) ENV
  left join KRC2015.[dbo].LG_015_ITEMS ITM  WITH(NOLOCK) ON    ENV.STOCKREF = ITM.LOGICALREF
  left join (SELECT DISTINCT CARDREF,ISNULL(PRICE,0) AS PRICE FROM  KRC2015.[dbo].LG_015_PRCLIST Q1 WITH(NOLOCK) WHERE Q1.LOGICALREF IN 
(SELECT TOP 1 LOGICALREF FROM  KRC2015.[dbo].LG_015_PRCLIST Q2 WITH(NOLOCK) WHERE Q1.CARDREF =  Q2.CARDREF ORDER BY Q2.BEGDATE DESC)) AS TblFiyat on 
TblFiyat.CARDREF = ITM.LOGICALREF
 -- LEFT JOIN KRC2015.[dbo].LG_015_SPECODES MARKA ON MARKA.SPECODE = ITM.SPECODE5
  LEFT JOIN Pazaryerleri n11 WITH(NOLOCK) ON n11.PazaryeriAdi='N11'
  LEFT JOIN Pazaryerleri openCard WITH(NOLOCK) ON openCard.PazaryeriAdi='Opencard'
  LEFT JOIN Pazaryerleri hepsiBurada WITH(NOLOCK) ON hepsiBurada.PazaryeriAdi='HepsiBurada'
  LEFT JOIN Pazaryerleri amazon WITH(NOLOCK) ON amazon.PazaryeriAdi='Amazon'
  LEFT JOIN Pazaryerleri trendyol WITH(NOLOCK) ON trendyol.PazaryeriAdi='Trendyol'
 
   WHERE ONHAND>0  --and ITM.CYPHCODE = 'B2B' 