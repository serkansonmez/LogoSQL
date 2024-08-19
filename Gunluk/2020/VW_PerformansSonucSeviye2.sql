USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansSonucSeviye2]    Script Date: 3.09.2020 08:49:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--select * from [VW_PerformansSonuc]

CREATE view [dbo].[VW_PerformansSonucSeviye2] as 
select 
cast(Firmalar.Id as varchar(20))  + '-' + cast(vw_UcretPersonel.Id as varchar(20)) + '-' + cast(PerformansDonemleri.Id as varchar(20)) as Id ,
vw_UcretPersonel.Id as UcretPersonelId,Adi + ' ' + Soyadi as AdiSoyadi,TcKimlikNo,
(isnull(TblYetkinliklerKisisel.Seviye2,0) + isnull(TblYetkinliklerMesleki.Seviye2,0) + isnull(TblYetkinliklerLiderlik.Seviye2,0)) / 3 as YetkinlikPuan,
isnull(TblYetkinliklerKisisel.Seviye2,0) as YetkinlikKisiselPuan,
isnull(TblYetkinliklerMesleki.Seviye2,0) as YetkinlikMeslekiPuan,
isnull(TblYetkinliklerLiderlik.Seviye2,0) as YetkinlikLiderlikPuan,

  



( isnull(TblMarkalarIletisim.Seviye2,0)  +   (isnull(TblMarkalarStok.Seviye2,0) + isnull(TblMarkalarTahsilat.Seviye2,0))) / 3 as MarkaPuan,
isnull(TblMarkalarIletisim.Seviye2,0) as MarkalarIletisimPuan,
isnull(TblMarkalarStok.Seviye2,0) as MarkalarStokPuan,
isnull(TblMarkalarTahsilat.Seviye2,0) as MarkalarTahsilatPuan,
 
(
((isnull(TblYetkinliklerKisisel.Seviye2,0) + isnull(TblYetkinliklerMesleki.Seviye2,0) + isnull(TblYetkinliklerLiderlik.Seviye2,0)) / 3) 
+ (( isnull(TblMarkalarIletisim.Seviye2,0)  +   (isnull(TblMarkalarStok.Seviye2,0) + isnull(TblMarkalarTahsilat.Seviye2,0))) / 3 )) / 2 as GenelSonuc
,PerformansDonemleri.Id as PerformansDonemiId , PerformansDonemleri.Aciklama
,Firmalar.Id as FirmalarId ,Firmalar.SirketAdi
,vw_UcretPersonel.[Firma]
      ,vw_UcretPersonel.[Bolge]
      ,vw_UcretPersonel.[SicilNo]
      
      ,[Adi]
      ,vw_UcretPersonel.[Soyadi]
      ,vw_UcretPersonel.[Gorevi]
      ,vw_UcretPersonel.[GirisTarihi]
	   ,vw_UcretPersonel.[BabaAdi]
      ,vw_UcretPersonel.[IkametAdresi]
      ,vw_UcretPersonel.[IletisimTelefon]
      ,vw_UcretPersonel.[GsmNo]
      ,vw_UcretPersonel.[BankaSubeNo]
      ,vw_UcretPersonel.[PersonelGorevParametreId]
      ,vw_UcretPersonel.[AyakkabiNo]
      ,vw_UcretPersonel.[TisortBeden]
      ,vw_UcretPersonel.[PantolonBeden]
      ,[KanGrubu]
      ,[CalismaBakanligiDestegiVarmi]
      ,[CalisanDurumuId]
      ,[KanunNo]
      ,[EngelliMi]
      ,[SirketKisaKod]
      ,[SirketTelefonNo]
      ,[DogumTarihi]
      ,[Eposta]
      ,[BesHesapKodu]
      ,[ProjeKodu]
      ,[PersonelAgiTanimlariId]
      ,vw_UcretPersonel.[PozisyonAdi]
      ,[SubeAdi]
      ,vw_UcretPersonel.[UnvanAdi]
    --  , isnull(CAST( (Select top 1 LH_001_FAMILY.LDATA FROM BORDRODB.dbo.LH_001_FAMILY LH_001_FAMILY WHERE LH_001_FAMILY.PERREF = vw_UcretPersonel.TB_Pers_LREF ) as varbinary(max)),NULL) As Resim 
	  , cast(Firmalar.Id as varchar(20))  + '-' + cast(vw_UcretPersonel.Id as varchar(20)) + '-' + cast(PerformansDonemleri.Id as varchar(20)) as Id2
from     vw_UcretPersonel 
 CROSS JOIN  PerformansDonemleri
  CROSS JOIN  Firmalar
--left join VW_PerformansHareketlerPersonelIcmal TblYetkinlikler on TblYetkinlikler.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinlikler.PerformansAnaHedefleriId = 1 and PerformansDonemleri.Id = TblYetkinlikler.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblYetkinliklerKisisel on TblYetkinliklerKisisel.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerKisisel.PerformansAnaHedefleriId = 1 and TblYetkinliklerKisisel.HedefBaslik = 'Kiþisel Yetkinlikler' and PerformansDonemleri.Id = TblYetkinliklerKisisel.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblYetkinliklerMesleki on TblYetkinliklerMesleki.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerMesleki.PerformansAnaHedefleriId = 1 and TblYetkinliklerMesleki.HedefBaslik = 'Mesleki Yetkinlikler' and PerformansDonemleri.Id = TblYetkinliklerMesleki.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblYetkinliklerLiderlik on TblYetkinliklerLiderlik.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerLiderlik.PerformansAnaHedefleriId = 1 and TblYetkinliklerLiderlik.HedefBaslik = 'Liderlik Yetkinlikleri' and PerformansDonemleri.Id = TblYetkinliklerLiderlik.PerformansDonemiId

--left join VW_PerformansHareketlerAnaHedefliPersonelIcmal TblSube on TblSube.UcretPersonelId = vw_UcretPersonel.Id and PerformansDonemleri.Id = TblSube.PerformansDonemiId

--left join VW_PerformansHareketlerPersonelIcmal TblMarkalar on TblMarkalar.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalar.PerformansAnaHedefleriId = 3  and PerformansDonemleri.Id = TblMarkalar.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblMarkalarIletisim on TblMarkalarIletisim.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarIletisim.PerformansAnaHedefleriId = 3 and TblMarkalarIletisim.HedefBaslik = 'Ýletiþim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarIletisim.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblMarkalarStok on TblMarkalarStok.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarStok.PerformansAnaHedefleriId = 3 and TblMarkalarStok.HedefBaslik = 'Stok Yönetim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarStok.PerformansDonemiId
left join VW_PerformansSonucSeviyelerIcmali TblMarkalarTahsilat on TblMarkalarTahsilat.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarTahsilat.PerformansAnaHedefleriId = 3 and TblMarkalarTahsilat.HedefBaslik = 'Tahsilat ve Teklif Yönetim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarTahsilat.PerformansDonemiId


where PerformansDonemleri.Id= 1
--left join PerformansDonemleri on PerformansDonemleri.Id = TblMarkalar.PerformansDonemiId and PerformansDonemleri.Id = TblYetkinlikler.PerformansDonemiId and PerformansDonemleri.Id = TblSube.PerformansDonemiId

 
--select count(*) from VW_PerformansHareketler where PerformansDonemiId = 1 AND PerformansAnaHedefleriId = 1 group by HedefBaslik
--select count(cnt) from 
--(select count(*) as cnt  from VW_PerformansHareketler where PerformansDonemiId = 1 AND PerformansAnaHedefleriId = 1 group by HedefBaslik) sayac





 


GO


