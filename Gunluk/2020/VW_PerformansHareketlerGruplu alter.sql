USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerGruplu]    Script Date: 12.09.2020 20:40:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER view [dbo].[VW_PerformansHareketlerGruplu] as 
SELECT  
       [PerformansHareketler].[FirmalarId]
      ,[PerformansDonemiId]   
      ,[PerformansHareketler].[UcretPersonelId]
      ,[PuanlayanUcretPersonelId]
	  ,sum(PuanTanitimiId) as PuanToplami
	  ,count(PuanTanitimiId) as PuanSayisi
	  ,(select count(PuanTanitimiId) from PerformansHareketler q1 where q1.RowDeleted = '0' and q1.PuanTanitimiId=0
	                                       and [PerformansHareketler].[FirmalarId]=q1.FirmalarId  
										   and [PerformansHareketler].PerformansAnaHedefleriId=q1.PerformansAnaHedefleriId
	                                       and [PerformansHareketler].[PerformansDonemiId]=q1.[PerformansDonemiId]
										   and [PerformansHareketler].[UcretPersonelId]=q1.[UcretPersonelId]
										   and [PerformansHareketler].[PuanlayanUcretPersonelId]=q1.[PuanlayanUcretPersonelId]
										   and [PerformansHareketler].OrganizasyonSemasiId=q1.OrganizasyonSemasiId) as BaslangicPuanSayisi
      , OrganizasyonSemasiId
	  ,[PerformansHareketler].PerformansAnaHedefleriId
	  ,OrganizasyonSemasi.MarkaCiroOranId 
  FROM [dbo].[PerformansHareketler]
  left join  UcretPersonel on PuanlayanUcretPersonelId = UcretPersonel.Id
  left join  OrganizasyonSemasi on OrganizasyonSemasiId = OrganizasyonSemasi.Id
  left join  PerformansDonemleri on PerformansDonemleri.Id = [PerformansHareketler].PerformansDonemiId
  where [PerformansHareketler].[RowDeleted] = '0' --and PuanlayanUcretPersonelId = 2

  --and PuanlayanUcretPersonelId= 405  and [PerformansHareketler].UcretPersonelId= 399


  group by [PerformansHareketler].[FirmalarId]
      ,[PerformansDonemiId]   
      ,[PerformansHareketler].[UcretPersonelId]
      ,[PuanlayanUcretPersonelId]
	  ,OrganizasyonSemasiId
	 , [PerformansHareketler].PerformansAnaHedefleriId
	 ,OrganizasyonSemasi.MarkaCiroOranId 
 --and [PerformansHareketler].[FirmalarId] = 4
 --select * from [PerformansHareketler]
 
 
 --select * from OrganizasyonSemasi where Id = 1093







GO


