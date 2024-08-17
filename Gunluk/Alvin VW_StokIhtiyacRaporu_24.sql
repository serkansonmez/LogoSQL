USE [AlvinB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_StokIhtiyacRaporu_24]    Script Date: 16.04.2024 10:42:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--select * from [AlvinB2B_Default_v1]..VW_StokIhtiyacRaporu_24 where grupAdi = 'PROFÝL'
 --ALTER view [dbo].[VW_StokIhtiyacRaporu_24] as 
SELECT  
      ROW_NUMBER() over (order by [VW_UretimIhtiyaclariDetayRaporu_24].[StokKodu]) as Id,
       [VW_UretimIhtiyaclariDetayRaporu_24].[StokKodu]
      ,[StokAdi]
	  ,RenkKodu
      ,Isnull(round(sum([Miktar] / 6.5),2),0)  as MiktarBoy
	  ,Isnull(round(sum([Miktar] / 1),2),0)  as MiktarMtul
      ,[Birim]
      ,round(sum([ToplamFiyat]),2) as ToplamFiyat
      ,Isnull(round(avg(StokBakiye),2),0) as ZirveStokBakiye
	   ,Isnull(round(avg(StokBakiye) / 6.5,2),0) as ZirveStokBoy
      ,Isnull([GrupAdi],'Kategori Yok') as GrupAdi
    
      ,Isnull(round(avg(StokBakiye) - sum([Miktar]),2),0) as KalanMtul
      ,Isnull(ceiling((avg(StokBakiye) - sum([Miktar]) ) / 6.5),0) as KalanBoy
     ,avg(tblFiyat.Fiyat2) as SonListeBirimFiyat
	 ,case when Isnull(ceiling((avg(StokBakiye) - sum([Miktar]) ) / 6.5),0)>0 then
	     avg(tblFiyat.Fiyat2) * Isnull(ceiling((avg(StokBakiye) - sum([Miktar]) ) / 6.5),0) * 6.5 
		 else 0 end as StokToplamTutar
	 , case when Isnull(ceiling((avg(StokBakiye) - sum([Miktar]) ) / 6.5),0)<0 then 
	      avg(tblFiyat.Fiyat2) * Isnull(ceiling((avg(StokBakiye) - sum([Miktar]) ) / 6.5),0) * 6.5
		  else 0 end as MalzemeIhtiyacTutar
		--  ,case when TedarikciFirmaAdi is null then 'Asaþpen' else TedarikciFirmaAdi end as TedarikciFirmaAdi
		,TedarikciFirmaAdi
  FROM [dbo].[VW_UretimIhtiyaclariDetayRaporu_24]
  left join (select StokKodu,Fiyat2  from ErcomDbFiyat where ListeNo = (select top 1 ListeNo from ErcomDbFiyatListesi order by ListeNo desc)
              union all
			  select StokKodu,Fiyat1  from AsasDbFiyat where ListeNo = (select top 1 ListeNo from AsasDbFiyatListesi order by ListeNo desc) ) tblFiyat on  
																tblFiyat.StokKodu = [VW_UretimIhtiyaclariDetayRaporu_24].StokKodu
  where [UretimDurumu] = 'Beklemede' and TedarikciFirmaAdi is not null
  group by   [VW_UretimIhtiyaclariDetayRaporu_24].[StokKodu]
      ,[StokAdi]
	  ,[GrupAdi]
	  ,RenkKodu
	  ,Birim
	  ,TedarikciFirmaAdi
 
 /*
select * from VW_UretimIhtiyaclariDetayRaporu_24
select * from ErcomDbFiyat where ListeNo = (select top 1 ListeNo from ErcomDbFiyatListesi order by ListeNo desc)
 */

 --select * from ErcomDbFiyat where StokKodu like  '10143%' and ListeNo > 210
--SELECT * FROM VW_UretimIhtiyaclariDetayRaporu_24
GO


