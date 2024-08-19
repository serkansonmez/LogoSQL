USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketler]    Script Date: 3.09.2020 08:45:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--select * from [VW_PerformansHareketler]
ALTER view [dbo].[VW_PerformansHareketler] as 
SELECT [PerformansHareketler].[Id]
       
      ,[PerformansHareketler].[RowUpdatedTime] as KayitZamani
      ,[PerformansHareketler].[RowUpdatedBy] as KaydedenId
	  , Kaydeden.AdiSoyadi as KaydedenAdi
      ,[PerformansHareketler].[FirmalarId]  
	  ,Firmalar.SirketAdi
      ,[PerformansHareketler].[PerformansDonemiId]
	  ,PerformansDonemleri.Aciklama as PerformansDonemi
	   
      ,[PerformansHareketler].[OrganizasyonSemasiId]
	  ,OrganizasyonSemasi.PozisyonAdi
      ,[PerformansHareketler].[UcretPersonelId]
	  ,UcretPersonel.Adi + ' ' + UcretPersonel.Soyadi as AdiSoyadi
      ,[PerformansHareketler].[PerformansAnaHedefleriId]
	  ,[PerformansAnaHedefleri].AnaHedefler
      ,[PerformansHareketler].[UnvanlarId]
	   ,Unvanlar.UnvanAdi
      ,[PerformansHedefleriId]
	   ,[PerformansHedefleri].HedefBaslik
	  ,[PerformansHedefleri].HedefAciklama
      ,[PerformansHareketler].[PuanlayanOrganizasyonSemasiId]
	  ,PuanlayanOrganizasyonSemasi.PozisyonAdi as PuanlayanPozisyonAdi
      ,[PuanlayanUcretPersonelId]
	  ,PuanlayanUcretPersonel.Adi + ' ' + PuanlayanUcretPersonel.Soyadi as PuanlayanAdiSoyadi
      ,PerformansSablonu.[Agirlik]
      ,[PuanTanitimiId]
	  ,PuanTanitimi.PuanAciklama
	  ,PuanTanitimi.PuanDegeri
      ,[PuanlamaTarihi]
	  , ((PerformansHedefleri.AgirlikOrani  * PuanDegeri    ) / 100.00) *  PerformansSablonu.Agirlik / 100 as AgirlikPuani
	--  ,PerformansSablonu.Agirlik * PerformansHedefleri.AgirlikOrani * PuanDegeri / 100 as AgirlikPuani
	  ,OrganizasyonSemasi.MarkaCiroOranId
	  ,MarkaCiroOran.CiroOran
	  ,MarkaCiroOran.EnvanterOran
	  ,MarkaCiroOran.DosyaAciklama as MarkaDosyaKonumu
	  ,Yorum
	  , cast(Firmalar.Id as varchar(20))  + '-' + cast([PerformansHareketler].UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemleri.Id as varchar(20)) as Id2
	  ,UcretPersonel.TcKimlikNo
  FROM [dbo].[PerformansHareketler]
  left join Kullanicilar Kaydeden on Kaydeden.Id = [PerformansHareketler].[RowUpdatedBy] 
  left join Firmalar  on Firmalar.Id = [PerformansHareketler].FirmalarId 
  left join PerformansDonemleri  on PerformansDonemleri.Id = [PerformansHareketler].[PerformansDonemiId] 
  left join OrganizasyonSemasi  on OrganizasyonSemasi.Id = [PerformansHareketler].OrganizasyonSemasiId 
  left join UcretPersonel  on UcretPersonel.Id = [PerformansHareketler].UcretPersonelId 
  left join Unvanlar  on Unvanlar.Id = [PerformansHareketler].UnvanlarId 
  left join [PerformansAnaHedefleri]  on [PerformansAnaHedefleri].Id = [PerformansHareketler].[PerformansAnaHedefleriId] 
  left join [PerformansHedefleri]  on [PerformansHedefleri].Id = [PerformansHareketler].[PerformansHedefleriId] 
  left join OrganizasyonSemasi PuanlayanOrganizasyonSemasi  on PuanlayanOrganizasyonSemasi.Id = [PerformansHareketler].PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel  PuanlayanUcretPersonel on PuanlayanUcretPersonel.Id = [PerformansHareketler].PuanlayanUcretPersonelId 
  left join PuanTanitimi  on PuanTanitimi.Id = [PerformansHareketler].PuanTanitimiId 
  left join MarkaCiroOran  on MarkaCiroOran.Id = OrganizasyonSemasi.MarkaCiroOranId 
  left join PerformansSablonu on PerformansSablonu.FirmalarId = [PerformansHareketler].FirmalarId and 
								 PerformansSablonu.PerformansDonemiId = [PerformansHareketler].PerformansDonemiId and	
								 PerformansSablonu.OrganizasyonSemasiId = [PerformansHareketler].OrganizasyonSemasiId and	
								 PerformansSablonu.PerformansAnaHedefleriId = [PerformansHareketler].PerformansAnaHedefleriId and	 
								 PerformansSablonu.PuanlayanOrganizasyonSemasiId = [PerformansHareketler].PuanlayanOrganizasyonSemasiId  	
  where [PerformansHareketler].[RowDeleted] = '0' --AND UcretPersonel.Adi like 'volk%'


  --select * from [PerformansHareketler]

  --select * from  PerformansSablonu
  --select * from  [PerformansHedefleri] 





GO


