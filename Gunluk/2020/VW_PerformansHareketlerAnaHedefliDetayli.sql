USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerAnaHedefliDetayli]    Script Date: 3.09.2020 08:46:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--select * from [VW_PerformansHareketlerAnaHedefliDetayli]

ALTER view [dbo].[VW_PerformansHareketlerAnaHedefliDetayli] as 
SELECT [PerformansHareketlerAnaHedefli].[Id]
       
      ,[PerformansHareketlerAnaHedefli].[RowUpdatedTime] as KayitZamani
      ,[PerformansHareketlerAnaHedefli].[RowUpdatedBy] as KaydedenId
	  , Kaydeden.AdiSoyadi as KaydedenAdi
      ,[PerformansHareketlerAnaHedefli].[FirmalarId]  
	  ,Firmalar.SirketAdi
      ,[PerformansDonemiId]
	  ,PerformansDonemleri.Aciklama as PerformansDonemi
	  ,Subeler.Id as SubeId
	  ,Subeler.SubeAdi

	  
      ,[PerformansHareketlerAnaHedefli].[PerformansAnaHedefleriId]
	  ,[PerformansAnaHedefleri].AnaHedefler


      ,[PuanlayanOrganizasyonSemasiId]
	  ,PuanlayanOrganizasyonSemasi.PozisyonAdi as PuanlayanPozisyonAdi
      ,[PuanlayanUcretPersonelId]
	  ,PuanlayanUcretPersonel.Adi + ' ' + PuanlayanUcretPersonel.Soyadi as PuanlayanAdiSoyadi

      ,[PuanTanitimiId]
	  ,PuanTanitimi.PuanAciklama
	  ,PuanTanitimi.PuanDegeri
      ,[PuanlamaTarihi]
	  ,OrganizasyonSemasi.UcretPersonelId
	  ,UcretPersonel.Adi + ' ' + UcretPersonel.Soyadi as AdiSoyadi
	  ,Yorum
  FROM [dbo].[PerformansHareketlerAnaHedefli]
  left join Kullanicilar Kaydeden on Kaydeden.Id = [PerformansHareketlerAnaHedefli].[RowUpdatedBy] 
  left join Firmalar  on Firmalar.Id = [PerformansHareketlerAnaHedefli].FirmalarId 
  left join PerformansDonemleri  on PerformansDonemleri.Id = [PerformansHareketlerAnaHedefli].[PerformansDonemiId] 
  left join Subeler on [PerformansHareketlerAnaHedefli].SubeMarkaId = Subeler.Id
  left join OrganizasyonSemasi on OrganizasyonSemasi.SubelerId = Subeler.Id
  left join UcretPersonel on UcretPersonel.Id = OrganizasyonSemasi.UcretPersonelId
  left join [PerformansAnaHedefleri]  on [PerformansAnaHedefleri].Id = [PerformansHareketlerAnaHedefli].[PerformansAnaHedefleriId] 

  left join OrganizasyonSemasi PuanlayanOrganizasyonSemasi  on PuanlayanOrganizasyonSemasi.Id = [PerformansHareketlerAnaHedefli].PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel  PuanlayanUcretPersonel on PuanlayanUcretPersonel.Id = [PerformansHareketlerAnaHedefli].PuanlayanUcretPersonelId 
  left join PuanTanitimi  on PuanTanitimi.Id = [PerformansHareketlerAnaHedefli].PuanTanitimiId 
  where [PerformansHareketlerAnaHedefli].[RowDeleted] = '0'  and PerformansHareketlerAnaHedefli.AktifPasif='1' --and PuanDegeri is not null






GO


