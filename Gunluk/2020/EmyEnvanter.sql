USE [ArgelasB2B_Default_v1]
GO

/****** Object:  View [dbo].[EmyEnvanter]    Script Date: 9.11.2020 22:49:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











--select * from [EmyEnvanter] where Logicalref is null
 ALTER View [dbo].[EmyEnvanter] as 
SELECT DISTINCT cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20)) as [LOGICALREF]
      ,[Stok Kodu]
      ,[Stok Adý]
	  -- ,MARKA.DEFINITION_ AS [Marka]
	   ,ITM.SPECODE5 AS [Marka]
	  ,CASE WHEN LEN([Stok Adý])-LEN(REPLACE([Stok Adý], ' ', '')) < 2 
            THEN [Stok Adý]
            ELSE LEFT([Stok Adý],  
                               CHARINDEX(' ', [Stok Adý],
                               CHARINDEX(' ', [Stok Adý],
                               CHARINDEX(' ', [Stok Adý])+1)+1) )
       END as Ebat
     
      ,TUR.DEFINITION_ AS [Tür]
	  ,ITM.NAME4 as Desen
	  ,EmySeriLotEnvanter.Yil as Dot
	  ,FiyatListeleri.EtiketK + ' ' + FiyatListeleri.EtiketN + ' ' + FiyatListeleri.EtiketG + ' ' + FiyatListeleri.EtiketDb as LastikEtiketi
	  
      ,MEVSIM.DEFINITION_ AS  [Mevsim]
      ,FiiliStok  as [Depo Miktarý]
      ,ISNULL(FiyatListeleri.KdvDahilFiyat,0) [Birim Fiyat]
      ,[Envanter Tutarý]
      ,ITM.NAME3 as [UretimKodu]
      ,Case when FiiliStok>20 then '20+' else cast(PARSENAME(FiiliStok,2) as varchar(20)) end as [DepoMiktariStr]
	  ,ITM.PRODUCERCODE as UreticiKodu
	  ,round(ISNULL((FiyatListeleri.KdvDahilFiyat) * (100 - GenelParametreler.PesinOdemeIndirimOrani) / 100 ,0),0)  as PesinFiyat
      ,round(ISNULL((FiyatListeleri.KdvDahilFiyat) * (100 + GenelParametreler.KrediKartiKomisyonOrani) / 100 ,0),0)  as VadeliFiyat
      ,0 as ParekendeFiyat
  FROM TIGER3.[dbo].[ARG_Envanter] ENV
  left join TIGER3.[dbo].LG_003_ITEMS ITM ON ITM.SPECODE = '1-LASTik' and ITM.CARDTYPE = 1 and ENV.LOGICALREF = ITM.LOGICALREF

  LEFT JOIN TIGER3.[dbo].LG_003_SPECODES MARKA ON MARKA.SPECODE = ENV.[Marka]
  LEFT JOIN TIGER3.[dbo].LG_003_SPECODES TUR ON TUR.SPECODE = ENV.[Tür]
  LEFT JOIN TIGER3.[dbo].LG_003_SPECODES MEVSIM ON MEVSIM.SPECODE = ENV.[Mevsim] and MEVSIM.DEFINITION_ <> 'TANIMSIZ'
  left join EmySeriLotEnvanter on EmySeriLotEnvanter.LOGICALREF = ITM.LOGICALREF
  left join FiyatListeleri ON [UretimKodu] = FiyatListeleri.UrunKoduLogo collate SQL_Latin1_General_CP1_CI_AS --and FiyatListeleri.Yil = EmySeriLotEnvanter.Yil
  left join GenelParametreler ON  GenelParametrelerId = 1
 -- left join FirmaDetayBilgileri ON  FirmaDetayBilgileri.TigerCariKodu  = 1
  WHERE [Depo Miktarý]>0 and ITM.CYPHCODE = 'B2B' and cast(ENV.[LOGICALREF]  as varchar(20))+ '-' + cast(EmySeriLotEnvanter.Yil as varchar(20)) is not null
 --and (FiyatListeleri.KdvDahilFiyat>0)

--SELECT * FROM TIGER3.[dbo].LG_003_ITEMS WHERE SPECODE = '1-LASTik'

 --SELECT * FROM TIGER3.[dbo].LG_003_SPECODES WHERE SPECODE = '1-LASTik'

GO


