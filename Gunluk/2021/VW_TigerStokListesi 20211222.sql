USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_TigerStokListesi]    Script Date: 22.12.2021 10:24:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--SELECT * FROM [VW_TigerStokListesi]
  ALTER view [dbo].[VW_TigerStokListesi] as 
SELECT DISTINCT  
--ITM.STGRPCODE, jantlarýn kontrolü için
 cast( STOCKREF  as varchar(20))  as [LOGICALREF]
      ,ITM.CODE AS  [StokKodu]
      ,ITM.NAME AS [StokAdi]
	   
	  -- ,ITM.SPECODE5 AS [Marka]
	  ,'' as Ebat
      
      
	  
      ,ONHAND  as [DepoMiktari]
       
	  ,ISNULL(PRICE, 0) as BirimFiyat
      ,case when TblFiyat.CURCODE = 'EUR' then   DovizKurlari.Euro 
	        when TblFiyat.CURCODE = 'USD' then   DovizKurlari.Usd 
			else 1 end [EnvanterTutari]
       
      ,Case 
	         when ONHAND>20 then '20+' 
		 else 
	         cast(ONHAND as varchar(20)) 
	  end as [DepoMiktariStr]
	  ,ITM.PRODUCERCODE as UreticiKodu
	   
      ,case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE, 0) * DovizKurlari.Euro 
	        when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE, 0) * DovizKurlari.Usd 
			else ISNULL(PRICE, 0)  end
			as SatisFiyati
	-- ,FiyatListeleri.FiyatListeleriId as ParekendeFiyat
	  --,'TL' as DovizTuru
	  -- ,160 as DovizTurReferans
	   ,TblFiyat.CURCODE as DovizTuru
	   ,TblFiyat.CURTYPE as DovizTurReferans
	   ,case when ITM.VAT is null then 18 else ITM.VAT end AS KdvOran
	   ,(Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) as KdvliFiyat
	   ,((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) ) + 
	   ((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4))  * n11.KomisyonOrani / 100) as N11HesaplananFiyat
	   ,((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) ) + 
	   ((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4))  * openCard.KomisyonOrani / 100) as OpenCardHesaplananFiyat
	   ,((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) ) + 
	   ((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4))  * trendyol.KomisyonOrani / 100) as TrendyolHesaplananFiyat
	   ,((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) ) + 
	   ((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4))  * hepsiBurada.KomisyonOrani / 100) as HepsiBuradaHesaplananFiyat
      ,((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4)) ) + 
	   ((Round(case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when TblFiyat.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when TblFiyat.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),4))  * amazon.KomisyonOrani / 100) as AmazonHesaplananFiyat

  --FROM (SELECT STOCKREF,INVENNO, SUM(ONHAND) AS ONHAND FROM TIGER3.[dbo].LV_003_01_STINVTOT_V1   GROUP BY STOCKREF,INVENNO  ) ENV
  ,Case when Urunler.UrunlerId is not null then ITM.CODE + ' (Kayýt Var)' else  ITM.CODE end as StokKodu2
    ,isnull(Urunler.N11KampanyaFiyat,0) as N11KampanyaFiyat
	,isnull(Urunler.N11Fiyat,0) as N11Fiyat
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
  left join (select top 1 * from DovizKurlari order by DovizKurlariId desc) as DovizKurlari  on 1=1
  left join Urunler on Urunler.LogoMalzemeKodu COLLATE SQL_Latin1_General_CP1254_CI_AS = ITM.CODE
left join (SELECT DISTINCT CARDREF,ISNULL(PRICE, 0) AS PRICE,CUR.CURTYPE,CUR.CURCODE FROM  TIGER3.DBO.LG_003_PRCLIST Q1 
left join TIGER3.DBO.L_CURRENCYLIST CUR ON CUR.CURTYPE = Q1.CURRENCY

WHERE Q1.CARDREF IN 
(SELECT TOP 1 CARDREF FROM  TIGER3.DBO.LG_003_PRCLIST Q2 WHERE Q1.CARDREF =  Q2.CARDREF ORDER BY Q2.BEGDATE DESC)) AS TblFiyat on 
TblFiyat.CARDREF = ITM.LOGICALREF
 -- LEFT JOIN TIGER3.[dbo].LG_003_SPECODES MARKA ON MARKA.SPECODE = ITM.SPECODE5
  LEFT JOIN Pazaryerleri n11 WITH(NOLOCK) ON n11.PazaryeriAdi='N11'
  LEFT JOIN Pazaryerleri openCard WITH(NOLOCK) ON openCard.PazaryeriAdi='Opencard'
  LEFT JOIN Pazaryerleri hepsiBurada WITH(NOLOCK) ON hepsiBurada.PazaryeriAdi='HepsiBurada'
  LEFT JOIN Pazaryerleri amazon WITH(NOLOCK) ON amazon.PazaryeriAdi='Amazon'
  LEFT JOIN Pazaryerleri trendyol WITH(NOLOCK) ON trendyol.PazaryeriAdi='Trendyol'
 
   WHERE 1=1 
GO


