USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_TigerStokListesi]    Script Date: 07/01/2021 14:36:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from [VW_TigerStokListesi] where Stokkodu = '3M 7000006035'
ALTER view [dbo].[VW_TigerStokListesi] as
SELECT 
--ITM.STGRPCODE, jantlarýn kontrolü için
 cast( LOGICALREF  as varchar(21))  as [LOGICALREF]
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
	   
    ,case when ITM.CURCODE = 'EUR' then ISNULL(PRICE, 0) * DovizKurlari.Euro 
	        when ITM.CURCODE = 'USD' then ISNULL(PRICE, 0) * DovizKurlari.Usd 
			else ISNULL(PRICE, 0)  end
			as SatisFiyati
	-- ,FiyatListeleri.FiyatListeleriId as ParekendeFiyat
	  --,'TL' as DovizTuru
	  -- ,160 as DovizTurReferans
	   ,ITM.CURCODE as DovizTuru
	   ,ITM.CURTYPE as DovizTurReferans
	   ,case when ITM.VAT is null then 18 else ITM.VAT end AS KdvOran
	   ,(Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) as KdvliFiyat
	   ,((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) ) + 
	   ((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0))  * n11.KomisyonOrani / 100) as N11HesaplananFiyat
	   ,((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 0 else 0 end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) ) + 
	   ((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 0 else 0 end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0))  * openCard.KomisyonOrani / 100) as OpenCardHesaplananFiyat
	   ,((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) ) + 
	   ((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0))  * trendyol.KomisyonOrani / 100) as TrendyolHesaplananFiyat
	   ,((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) ) + 
	   ((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0))  * hepsiBurada.KomisyonOrani / 100) as HepsiBuradaHesaplananFiyat
      ,((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0)) ) + 
	   ((Round(case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end + (case when ITM.VAT is null then 18 else ITM.VAT end  * case when ITM.CURCODE = 'EUR' then ISNULL(PRICE,0) * DovizKurlari.Euro when ITM.CURCODE = 'USD' then ISNULL(PRICE,0) * DovizKurlari.Usd  else ISNULL(PRICE,0)  end / 100),0))  * amazon.KomisyonOrani / 100) as AmazonHesaplananFiyat
 ,Case when Urunler.UrunlerId is not null then ITM.CODE + ' (Kayýt Var)' else  ITM.CODE end as StokKodu2
  FROM  tmpTigerItems ITM
 -- LEFT JOIN KRC2015.[dbo].LG_015_SPECODES MARKA ON MARKA.SPECODE = ITM.SPECODE5
  LEFT JOIN Pazaryerleri n11 WITH(NOLOCK) ON n11.PazaryeriAdi='N11'
  LEFT JOIN Pazaryerleri openCard WITH(NOLOCK) ON openCard.PazaryeriAdi='Opencard'
  LEFT JOIN Pazaryerleri hepsiBurada WITH(NOLOCK) ON hepsiBurada.PazaryeriAdi='HepsiBurada'
  LEFT JOIN Pazaryerleri amazon WITH(NOLOCK) ON amazon.PazaryeriAdi='Amazon'
  LEFT JOIN Pazaryerleri trendyol WITH(NOLOCK) ON trendyol.PazaryeriAdi='Trendyol'
   left join (select top 1 * from DovizKurlari order by DovizKurlariId desc) as DovizKurlari  on 1=1
  left join Urunler on Urunler.LogoMalzemeKodu COLLATE SQL_Latin1_General_CP1254_CI_AS = ITM.CODE
   WHERE ONHAND>0  --and ITM.CYPHCODE = 'B2B' 

--select * from tmpTigerItems


GO


