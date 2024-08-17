USE [ArgelasB2B_Default_v1]
GO

/****** Object:  View [dbo].[EmyEticaret]    Script Date: 1.11.2022 15:21:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SELECT * FROM trendyoldb..tbl_001_stok where a_kod =  '10301010151951'


SELECT * FROM ArgelasB2B_Default_v1..EmyEticaret where [Stok Kodu] like  '10301010151951%'



select * from  tbl MailTablosu 
SELECT  *   FROM tbl_001_EPazar_Siparis WITH (NOLOCK) WHERE SatisSiparisRef is null and   Id >44
 
 SELECT  *   FROM trendyoldb..tbl_001_EPazar_TrendIptalSipmas WITH (NOLOCK) WHERE SatisSiparisRef is null and   Id >44 1641119325


 SELECT  *   FROM trendyoldb..tbl_001_EPazar_TrendSipmas


SELECT  *   FROM trendyoldb..tbl_001_EPazar_TrendIptalInvoiceAddress



update  tbl_001_EPazar_Siparis set  SAtisSiparisRef=-1 WHERE Id =49



 --SELECT * FROM  [EmyEnvanter]


--select DISTINCT MARKA   from [EmyEnvanter] where MARKA is null
--select DISTINCT Mevsim ,SUBSTRING(Mevsim,3,1),ascii(SUBSTRING(Mevsim,3,1)) ,replace(Mevsim,'Þ','S')  from [EmyEnvanter]
 
 
 --ALTER View [dbo].[EmyEticaret] as 
SELECT DISTINCT  
--ITM.STGRPCODE, jantlarýn kontrolü için
 cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20)) as [LOGICALREF]
      ,[Stok Kodu] + + '-' + cast(EmySeriLotEnvanter.Yil - 2000 as varchar(20)) as [Stok Kodu]
      ,[Stok Adý]
	   ,REPLACE(REPLACE(REPLACE(REPLACE(replace(MARKA.DEFINITION_,'Ý','I'),'Þ','S'),'Ö','O'),'Ü','U'),'Ç','C')  AS [Marka]
	     
	  -- ,ITM.SPECODE5 AS [Marka]
	  ,CASE WHEN LEN([Stok Adý])-LEN(REPLACE([Stok Adý], ' ', '')) < 2 
            THEN [Stok Adý]
            ELSE LEFT([Stok Adý],  
                               CHARINDEX(' ', [Stok Adý],
                               CHARINDEX(' ', [Stok Adý],
                               CHARINDEX(' ', [Stok Adý])+1)+1) )
       END as Ebat
      
      ,REPLACE(REPLACE(REPLACE(REPLACE(replace(TUR.DEFINITION_,'Ý','I'),'Þ','S'),'Ö','O'),'Ü','U'),'Ç','C')  AS [Tür]
	  ,ITM.NAME4 as Desen
	  ,EmySeriLotEnvanter.Yil as Dot
	 -- ,2021 as dot
	  ,FiyatListeleri.EtiketK + ' ' + FiyatListeleri.EtiketN + ' ' + FiyatListeleri.EtiketG + ' ' + FiyatListeleri.EtiketDb as LastikEtiketi
	  
     -- ,REPLACE(REPLACE(REPLACE(REPLACE(replace(MEVSIM.DEFINITION_,CHAR(221),'I'),'Þ','S'),'Ö','O'),'Ü','U'),'Ç','C')  AS  [Mevsim]
	  ,MEVSIM.DEFINITION_   AS  [Mevsim]
      ,FiiliStok  as [Depo Miktarý]
      ,  round(ISNULL(case when SonSatisFiyati > 0 then SonSatisFiyati else FiyatListeleri.KdvDahilFiyat end,0),0) 
	  
	 -- case when MarkaMevsimYilIndirimOranlari.IndirimOrani is null then 
	 --     ISNULL(case when SonSatisFiyati > 0 then SonSatisFiyati else KdvDahilFiyat end,0) 
		--else   
		--   round(ISNULL((case when SonSatisFiyati > 0 then SonSatisFiyati else KdvDahilFiyat end) * (100 - MarkaMevsimYilIndirimOranlari.IndirimOrani) / 100 ,0),0) end
		   [Birim Fiyat]
      ,[Envanter Tutarý]
      ,ITM.NAME3 as [UretimKodu]
      ,Case when FiiliStok>20 then '20+' else cast(PARSENAME(FiiliStok,2) as varchar(20)) end as [DepoMiktariStr]
	  ,ITM.PRODUCERCODE as UreticiKodu
	    , case when   EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati   
	   
	    else 
	     round(ISNULL((
		               
		case when (MarkaMevsimYilIndirimOranlari.IndirimOrani is null or MarkaMevsimYilIndirimOranlari.IndirimOrani =0) then 
	      ISNULL(case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end,0) 
		else   
		    [dbo].[IskontoHesapla](case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end, MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,ArtisOrani) end
		 
		              ) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  
         end
		     as PesinFiyat
      ,  
	          
			  
			   round(ISNULL((
		               
					case when   EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati   
	   
	    else 
	     round(ISNULL((
		               
		case when (MarkaMevsimYilIndirimOranlari.IndirimOrani is null or MarkaMevsimYilIndirimOranlari.IndirimOrani =0) then 
	      ISNULL(case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end,0) 
		else   
		    [dbo].[IskontoHesapla](case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end, MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,ArtisOrani) end
		 
		              ) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  
         end



			  
			  ) * (100 + GenelParametreler.KrediKartiKomisyonOrani) / 100 ,0),0)  
			  
			  
			    as VadeliFiyat
      ,  -- satýþ fiyatý * MarkaOrani

	   
		               
		case when   EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati   
	   
	    else 
	     round(ISNULL((
		               
		case when (MarkaMevsimYilIndirimOranlari.IndirimOrani is null or MarkaMevsimYilIndirimOranlari.IndirimOrani =0) then 
	      ISNULL(case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end,0) 
		else   
		    [dbo].[IskontoHesapla](case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end, MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,ArtisOrani) end
		 
		              ) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  
         end
					  
					  + 

					  ( 	  case when   EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati   
	   
	    else 
	     round(ISNULL((
		               
		case when (MarkaMevsimYilIndirimOranlari.IndirimOrani is null or MarkaMevsimYilIndirimOranlari.IndirimOrani =0) then 
	      ISNULL(case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end,0) 
		else   
		    [dbo].[IskontoHesapla](case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else FiyatListeleri.KdvDahilFiyat end, MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,ArtisOrani) end
		 
		              ) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  
         end  * LastikFirmalari.MarkaOrani / 100 ) 
	   
	  as ParekendeFiyat
	-- 0 as ParekendeFiyat
	-- ,FiyatListeleri.FiyatListeleriId as ParekendeFiyat
	  ,ITM.STGRPCODE as Jant
	  ,  


	       round(ISNULL((
		               
		case when (MarkaMevsimYilIndirimOranlari.IndirimOrani is null or MarkaMevsimYilIndirimOranlari.IndirimOrani =0) then 
	      ISNULL( FiyatListeleri.KdvDahilFiyat  ,0) 
		else   
		    [dbo].[IskontoHesapla]( FiyatListeleri.KdvDahilFiyat  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,ArtisOrani) end
		 
		              ) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  
	  
	 -- case when MarkaMevsimYilIndirimOranlari.IndirimOrani is null then 
	 --     ISNULL(case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else KdvDahilFiyat end,0) 
		--else   
		--   round(ISNULL((case when EmyEnvanterFiyatListesi.SatisFiyati > 0 then EmyEnvanterFiyatListesi.SatisFiyati else KdvDahilFiyat end) * (100 - MarkaMevsimYilIndirimOranlari.IndirimOrani) / 100 ,0),0) end
		   [KdvDahilListeFiyati],
		  --   tblSonAlis.ALIS_BIRIM_FIYATI,
		     [dbo].[fnc_EticaretIskontoHesapla]( Round( isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani)  as ETicaretBazFiyati,
			I.AREA as Desi,
			[dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)  as KargoFiyati,
			TrenyolParametre.KomisyonOrani as TrendyolKomisyonOrani,
		    
			
	 	 --  [dbo].[fnc_TrendyolKomisyonHesapla]( [dbo].[fnc_EticaretIskontoHesapla]( Round(FiyatListeleri.KdvDahilFiyat,0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,EkIskontoTutar,EticaretArtisOrani) , [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2),TrenyolParametre.KomisyonOrani   )  as  TrendyolKomisyonu,
			 
			 --   [dbo].[fnc_EticaretIskontoHesapla]( Round(FiyatListeleri.KdvDahilFiyat,0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,EkIskontoTutar,EticaretArtisOrani)  + 
			 --  [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)   +
			 --[dbo].[fnc_TrendyolKomisyonHesapla]( [dbo].[fnc_EticaretIskontoHesapla]( Round(FiyatListeleri.KdvDahilFiyat,0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,EkIskontoTutar,EticaretArtisOrani) , [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2),TrenyolParametre.KomisyonOrani   )  
			   
			 --  as  HesaplananTrendyolFiyati,
			 
			round( [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani)  + 
			  [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)   +
			( ( [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani)  + 
			   [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)   +
			 [dbo].[fnc_TrendyolKomisyonHesapla]( [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani) , [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2),TrenyolParametre.KomisyonOrani   )  
			 ) * TrenyolParametre.KomisyonOrani / 100),2) as HesaplananTrendyolFiyati, 

			round((  [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani)  + 
			  [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)   +
			( ( [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani)  + 
			   [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2)   +
			 [dbo].[fnc_TrendyolKomisyonHesapla]( [dbo].[fnc_EticaretIskontoHesapla]( Round(isnull(FiyatListeleri.KdvDahilFiyat,tblSonAlis.ALIS_BIRIM_FIYATI),0)  , MarkaMevsimYilIndirimOranlari.IndirimOrani,IskontoOrani1,IskontoOrani2,IskontoOrani3,IskontoOrani4,IskontoOrani5,EkIskontoTutar,EticaretArtisOrani) , [dbo].[fnc_PazaryeriDesiHesapla]( I.AREA  , 2),TrenyolParametre.KomisyonOrani   )  
			 ) * TrenyolParametre.KomisyonOrani / 100)) * TrenyolParametre.KomisyonOrani / 100 ,2) as  TrendyolKomisyonu,

			TrendyolFiyatListesi.TrendyolFiyati as TrendyolFiyatiManuel,
			EmyEnvanterFiyatListesi.SatisFiyati as ManuelSatisFiyati,
		    ITM.MARKREF
  FROM TIGER3.[dbo].[ARG_Envanter] ENV
  left join TIGER3.[dbo].LG_006_ITEMS ITM ON ITM.SPECODE = '1-LASTik' and ITM.CARDTYPE = 1 and ENV.LOGICALREF = ITM.LOGICALREF
   LEFT OUTER JOIN TIGER3.[dbo].LG_006_ITMUNITA I WITH(NOLOCK) ON ITM.LOGICALREF = I.ITEMREF 
  LEFT JOIN TIGER3.[dbo].LG_006_SPECODES MARKA ON MARKA.SPECODE = ITM.SPECODE5
  LEFT JOIN LastikFirmalari on LastikFirmalari.FirmaAdi collate SQL_Latin1_General_CP1254_CI_AS = MARKA.DEFINITION_ 
  LEFT JOIN TIGER3.[dbo].LG_006_SPECODES TUR ON TUR.SPECODE = ENV.[Tür]
  LEFT JOIN TIGER3.[dbo].LG_006_SPECODES MEVSIM ON MEVSIM.SPECODE = ENV.[Mevsim] and MEVSIM.DEFINITION_ <> 'TANIMSIZ'
  left join EmySeriLotEnvanter on EmySeriLotEnvanter.LOGICALREF = ITM.LOGICALREF
  left join VW_FiyatListeleriGuncel FiyatListeleri ON [UretimKodu] = FiyatListeleri.UrunKoduLogo collate SQL_Latin1_General_CP1_CI_AS --and FiyatListeleri.Yil = EmySeriLotEnvanter.Yil
  left join GenelParametreler ON  GenelParametrelerId = 1
  left join (SELECT         EMY_006_SONALISFIYATI.STLINELOGREF,  EMY_006_SONALISFIYATI.STOCKREF,  (LG_006_01_STLINE.VATMATRAH /  LG_006_01_STLINE.AMOUNT) * 2 AS ALIS_BIRIM_FIYATI
FROM            TIGER3.dbo.EMY_006_SONALISFIYATI EMY_006_SONALISFIYATI LEFT OUTER JOIN
                        TIGER3.dbo.LG_006_01_STLINE LG_006_01_STLINE ON  LG_006_01_STLINE.LOGICALREF =  EMY_006_SONALISFIYATI.STLINELOGREF) as tblSonAlis on tblSonAlis.STOCKREF = ITM.LOGICALREF
  left join Pazaryerleri TrenyolParametre ON  TrenyolParametre.PazaryerleriId = 1
   left join EmyEnvanterFiyatListesi on  EmyEnvanterFiyatListesi.LOGICALREF collate SQL_Latin1_General_CP1254_CI_AS =  cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20))
    left join TrendyolFiyatListesi on  TrendyolFiyatListesi.LOGICALREF collate SQL_Latin1_General_CP1254_CI_AS =  cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20))
 left join ( select Yil,Marka,Tur,Mevsim,Jant,Sum(isnull(EkIskontoTutar,0)) as EkIskontoTutar,sum(IskontoOrani3) as IskontoOrani3, sum(IskontoOrani4) as IskontoOrani4, sum(IskontoOrani5) as IskontoOrani5, 
 sum(IndirimOrani) as IndirimOrani,sum(IskontoOrani1) as IskontoOrani1,sum(IskontoOrani2) as IskontoOrani2,max(ArtisOrani) as ArtisOrani ,max(ETicaretArtisOrani) as ETicaretArtisOrani   from MarkaMevsimYilIndirimOranlari
 group by Yil,Marka,Tur,Mevsim,Jant) MarkaMevsimYilIndirimOranlari on (MarkaMevsimYilIndirimOranlari.Mevsim = MEVSIM.DEFINITION_ collate SQL_Latin1_General_CP1_CI_AS or MarkaMevsimYilIndirimOranlari.Mevsim = 'TÜMÜ') and 
											 MarkaMevsimYilIndirimOranlari.Yil = EmySeriLotEnvanter.Yil collate SQL_Latin1_General_CP1_CI_AS  and 
											 (MarkaMevsimYilIndirimOranlari.Tur = TUR.DEFINITION_  collate SQL_Latin1_General_CP1_CI_AS OR MarkaMevsimYilIndirimOranlari.Tur = 'TÜMÜ' ) and 
											 (MarkaMevsimYilIndirimOranlari.Jant = ITM.STGRPCODE  collate SQL_Latin1_General_CP1_CI_AS OR MarkaMevsimYilIndirimOranlari.Jant = 'TÜMÜ' ) and 
											 (MarkaMevsimYilIndirimOranlari.Marka = MARKA.DEFINITION_ collate SQL_Latin1_General_CP1_CI_AS OR MarkaMevsimYilIndirimOranlari.Marka = 'TÜMÜ' )
 -- left join FirmaDetayBilgileri ON  FirmaDetayBilgileri.TigerCariKodu  = 1
  WHERE [Depo Miktarý]>0 and ITM.CYPHCODE = 'B2B' and cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20)) is not null
  AND  I.LINENR=1 -- and ITM.PRODUCERCODE  ='0357076'


  --select  [dbo].[fnc_TrendyolKomisyonHesapla](
  --and cast(ENV.[LOGICALREF]  as varchar(20)) <> '29176'

  -- select * from [EmyEticaret] where UreticiKodu= '0357076'
 --and (case when SonSatisFiyati > 0 then SonSatisFiyati else KdvDahilFiyat end>0)

--SELECT * FROM TIGER3.[dbo].LG_006_ITEMS WHERE SPECODE = '1-LASTik'

 --SELECT * FROM TIGER3.[dbo].LG_006_SPECODES WHERE SPECODE = '1-LASTik'

 /*
 select * from MarkaMevsimYilIndirimOranlari where Marka = 'CONTINENTAL' and Yil = 2020 and Jant = '17' and 
 Tur = 'BINEK' and Mevsim = 'YAZ'


 select Yil,Marka,Tur,Mevsim,Jant,Sum(isnull(EkIskontoTutar,0)) as EkIskontoTutar,sum(IskontoOrani3) as IskontoOrani3, 
 sum(IndirimOrani) as IndirimOrani,sum(IskontoOrani1) as IskontoOrani1,sum(IskontoOrani2) as IskontoOrani2  from MarkaMevsimYilIndirimOranlari
 group by Yil,Marka,Tur,Mevsim,Jant
GO */


GO


