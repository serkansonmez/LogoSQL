USE [GezenWeb_Default_v1]
GO

/****** Object:  View [dbo].[VW_DevriyeHareketListesiTumu]    Script Date: 29.11.2023 17:46:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




 ALTER view [dbo].[VW_DevriyeHareketListesiTumu] as 

SELECT top 1000000000 ROW_NUMBER() OVER   (ORDER BY [DevriyeNoktalari].[ZirveFirmalarId]
      ,[DevriyeNoktalari].[ZirveSubelerId] ,CAST(tblGunluk.Tarih AS DATEtime) + cast(STR(DevriyeSaatler.Saat) + ':00' as DATEtime)) as Id 
       ,[DevriyeNoktalari].[DevriyeNoktalariId]
      ,[DevriyeNoktalari].[ZirveFirmalarId]
      ,[DevriyeNoktalari].[ZirveSubelerId]
     
	  ,ZirveFirmalar.FirmaAdi
	 -- ,ZirveSubeler.SubeAdi
	 ,DevriyeSubeler.DevriyeSubeAdi as SubeAdi
	   ,[DevriyeNoktasiTanimi]
	  --,tblGunluk.Tarih
	  --,cast(STR(DevriyeSaatler.Saat) + ':00' as DATEtime) as Saat
	  ,CAST(tblGunluk.Tarih AS DATEtime) + cast(STR(DevriyeSaatler.Saat) + ':00' as DATEtime) AS PlanlananTarih
	--  ,CAST(tblHareket.Tarih AS DATEtime) + cast(STR(tblHareket.Saat) + ':00' as DATEtime) AS GerceklesenTarih
	   ,TarihSaat as GerceklesenTarih
	   ,Users.DisplayName as DevriyeAtan 
	  ,CAST(tblGunluk.Tarih AS DATE) as Tarih
	  ,tblHareket.Latitude
	   ,tblHareket.Longitude
  FROM [dbo].[DevriyeNoktalari]
  cross join (select * from  DevriyeSaatler where DevriyeAktif=1) DevriyeSaatler
  cross join fnc_GunlukTarih() tblGunluk
  left join DevriyeSubeler on DevriyeSubeler.DevriyeSubelerId = DevriyeNoktalari.DevriyeSubelerId
  left join ZirveFirmalar on ZirveFirmalar.Id = [ZirveFirmalarId]
  left join ZirveSubeler on ZirveSubeler.Id = [ZirveSubelerId]
  LEFT join ( select DevriyeNoktalariId, cast(Tarih as date) as Tarih,DATEPART(HOUR, Tarih) AS Saat,UserId,MIN(Tarih) as TarihSaat
  ,MIN(Latitude) AS Latitude, MIN(Longitude) AS Longitude
 from DevriyeHareket group by DevriyeNoktalariId,cast(Tarih as date),DATEPART(HOUR, Tarih),UserId  ) tblHareket on tblHareket.DevriyeNoktalariId = [DevriyeNoktalari].DevriyeNoktalariId
  and tblHareket.Tarih  = tblGunluk.Tarih and  tblHareket.Saat  = DevriyeSaatler.Saat
   left join Users on Users.UserId = tblHareket.UserId
   where tblGunluk.tarih>'20230731' --and Users.DisplayName  is not null
  -- and ZirveSubeler.SubeAdi = 'BURSA_BETON_MERKEZ(ÝHSAN GEZEN ÖZEL GÜVENLÝK)'
   and DevriyeNoktalari.DevriyeNoktasiTanimi not in ('ÇIKIÞ','GÝRÝÞ')
    and DevriyeNoktalari.AktifPasif = 1
  order by 
    [DevriyeNoktalari].[ZirveFirmalarId]
      ,[ZirveSubelerId]
  ,CAST(tblGunluk.Tarih AS DATEtime) + cast(STR(DevriyeSaatler.Saat) + ':00' as DATEtime)

  
  /*

  SELECT* FROM DevriyeSaatler
 select DevriyeNoktalariId,cast(Tarih as date) as Tarih,DATEPART(HOUR, Tarih) AS Saat,MIN(Tarih) as TarihSaat
 from DevriyeHareket group by DevriyeNoktalariId,cast(Tarih as date),DATEPART(HOUR, Tarih)  
 */
 SELECT  * FROM DevriyeSubeSaatler   

 --1. agrega þubeler 19:00 – 07:00 arasý aktif olacak
--1.1 önce tamamý pasif olacak
 update DevriyeSubeSaatler set DevriyeAktif = 0 where DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI'))
--1.2 sonra 19:00 – 07:00 arasý aktif olacak
 update DevriyeSubeSaatler set DevriyeAktif = 1 where DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI'))
 and ((DevriyeSubeSaatler.Saat between 19 and 24) or (DevriyeSubeSaatler.Saat between 0 and 7))
 /* select * from DevriyeSubeSaatler where  DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI'))
 and ((DevriyeSubeSaatler.Saat between 19 and 24) or (DevriyeSubeSaatler.Saat between 0 and 7)) */


 --2. beton tesisleri 20:00 – 08:00 arasý aktif olacak
--2.1 önce tamamý pasif olacak
 update DevriyeSubeSaatler set DevriyeAktif = 0 where DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi NOT in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI','BURSA BETON MERKEZ'))
--1.2 sonra 19:00 – 07:00 arasý aktif olacak
 update DevriyeSubeSaatler set DevriyeAktif = 1 where DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi NOT in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI','BURSA BETON MERKEZ'))
 and ((DevriyeSubeSaatler.Saat between 20 and 24) or (DevriyeSubeSaatler.Saat between 0 and 8))
 /* select * from DevriyeSubeSaatler where  DevriyeSubelerId in 
 (SELECT DevriyeSubelerId FROM DevriyeSubeler WHERE DevriyeSubeAdi NOT in ('BURSA BETON KAYAPA','BURSA BETON GÜNEYKÖY','BURSA BETON YEÞÝLÇOMLU','BURSA BETON CÝHATLI','BURSA BETON MERKEZ'))
 and ((DevriyeSubeSaatler.Saat between 20 and 24) or (DevriyeSubeSaatler.Saat between 0 and 8)) */


