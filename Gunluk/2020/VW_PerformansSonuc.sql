USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansSonuc]    Script Date: 21.07.2020 11:28:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from [VW_PerformansSonuc]

ALTER view [dbo].[VW_PerformansSonuc] as 
select 
cast(Firmalar.Id as varchar(20))  + '-' + cast(vw_UcretPersonel.Id as varchar(20)) + '-' + cast(PerformansDonemleri.Id as varchar(20)) as Id ,
vw_UcretPersonel.Id as UcretPersonelId,Adi + ' ' + Soyadi as AdiSoyadi,TcKimlikNo,
isnull(TblYetkinlikler.AgirlikPuani,0) as YetkinlikPuan,
isnull(TblYetkinliklerKisisel.AgirlikPuani,0) as YetkinlikKisiselPuan,
isnull(TblYetkinliklerMesleki.AgirlikPuani,0) as YetkinlikMeslekiPuan,
isnull(TblYetkinliklerLiderlik.AgirlikPuani,0) as YetkinlikLiderlikPuan,

isnull(TblYetkinlikler.Durum,'Ayarlanmadý') as YetkinlikDurum,
isnull(cast(TblYetkinlikler.PuanVerilenSayi as varchar(20)) + '/' + cast(TblYetkinlikler.toplamSayi as varchar(20)),'0/0') as YetkinlikSonuc,

isnull(TblSube.PuanDegeri,0) as SubePuan,isnull(TblSube.Durum,'Ayarlanmadý') as SubeDurum,
isnull(cast(TblSube.PuanVerilenSayi as varchar(20)) + '/' + cast(TblSube.toplamSayi as varchar(20)),'0/0') as SubeSonuc ,

isnull(TblMarkalar.AgirlikPuani,0) as MarkaPuan,
isnull(TblMarkalarIletisim.AgirlikPuani,0) as MarkalarIletisimPuan,
isnull(TblMarkalarStok.AgirlikPuani,0) as MarkalarStokPuan,
isnull(TblMarkalarTahsilat.AgirlikPuani,0) as MarkalarTahsilatPuan,

isnull(TblMarkalar.Durum,'Ayarlanmadý') as MarkaDurum,
isnull(cast(TblMarkalar.PuanVerilenSayi as varchar(20)) + '/' + cast(TblMarkalar.toplamSayi as varchar(20)),'0/0') as MarkaSonuc 

,(isnull(TblYetkinlikler.AgirlikPuani,0) + isnull(TblSube.PuanDegeri,0) + isnull(TblMarkalar.AgirlikPuani,0)) / 3 as GenelSonuc
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
      ,[PozisyonAdi]
      ,[SubeAdi]
      ,[UnvanAdi]
    --  , isnull(CAST( (Select top 1 LH_001_FAMILY.LDATA FROM BORDRODB.dbo.LH_001_FAMILY LH_001_FAMILY WHERE LH_001_FAMILY.PERREF = vw_UcretPersonel.TB_Pers_LREF ) as varbinary(max)),NULL) As Resim 
from     vw_UcretPersonel 
 CROSS JOIN  PerformansDonemleri
  CROSS JOIN  Firmalar
left join VW_PerformansHareketlerPersonelIcmal TblYetkinlikler on TblYetkinlikler.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinlikler.PerformansAnaHedefleriId = 1 and PerformansDonemleri.Id = TblYetkinlikler.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblYetkinliklerKisisel on TblYetkinliklerKisisel.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerKisisel.PerformansAnaHedefleriId = 1 and TblYetkinliklerKisisel.HedefBaslik = 'Kiþisel Yetkinlikler' and PerformansDonemleri.Id = TblYetkinliklerKisisel.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblYetkinliklerMesleki on TblYetkinliklerMesleki.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerMesleki.PerformansAnaHedefleriId = 1 and TblYetkinliklerMesleki.HedefBaslik = 'Liderlik Yetkinlikleri' and PerformansDonemleri.Id = TblYetkinliklerMesleki.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblYetkinliklerLiderlik on TblYetkinliklerLiderlik.UcretPersonelId = vw_UcretPersonel.Id and TblYetkinliklerLiderlik.PerformansAnaHedefleriId = 1 and TblYetkinliklerLiderlik.HedefBaslik = 'Liderlik Yetkinlikleri' and PerformansDonemleri.Id = TblYetkinliklerLiderlik.PerformansDonemiId

left join VW_PerformansHareketlerAnaHedefliPersonelIcmal TblSube on TblSube.UcretPersonelId = vw_UcretPersonel.Id and PerformansDonemleri.Id = TblSube.PerformansDonemiId

left join VW_PerformansHareketlerPersonelIcmal TblMarkalar on TblMarkalar.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalar.PerformansAnaHedefleriId = 3  and PerformansDonemleri.Id = TblMarkalar.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblMarkalarIletisim on TblMarkalarIletisim.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarIletisim.PerformansAnaHedefleriId = 3 and TblMarkalarIletisim.HedefBaslik = 'Ýletiþim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarIletisim.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblMarkalarStok on TblMarkalarStok.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarStok.PerformansAnaHedefleriId = 3 and TblMarkalarStok.HedefBaslik = 'Stok Yönetim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarStok.PerformansDonemiId
left join VW_PerformansHareketlerPersonelIcmalDetay TblMarkalarTahsilat on TblMarkalarTahsilat.UcretPersonelId = vw_UcretPersonel.Id and TblMarkalarTahsilat.PerformansAnaHedefleriId = 3 and TblMarkalarTahsilat.HedefBaslik = 'Tahsilat ve Teklif Yönetim Yetkinliði' and PerformansDonemleri.Id = TblMarkalarTahsilat.PerformansDonemiId



--left join PerformansDonemleri on PerformansDonemleri.Id = TblMarkalar.PerformansDonemiId and PerformansDonemleri.Id = TblYetkinlikler.PerformansDonemiId and PerformansDonemleri.Id = TblSube.PerformansDonemiId

 
--select *from VW_PerformansHareketlerAnaHedefliPersonelIcmal



GO


