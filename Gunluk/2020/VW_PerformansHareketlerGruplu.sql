USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerGruplu]    Script Date: 3.09.2020 08:47:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[VW_PerformansHareketlerGruplu] as 
SELECT  
       [PerformansHareketler].[FirmalarId]
      ,[PerformansDonemiId]   
      ,[UcretPersonelId]
      ,[PuanlayanUcretPersonelId]
	  ,sum(PuanTanitimiId) as PuanToplami
	  ,count(PuanTanitimiId) as PuanSayisi
	  ,(select count(PuanTanitimiId) from PerformansHareketler q1 where q1.RowDeleted = '0' and q1.PuanTanitimiId=0 and [PerformansHareketler].[FirmalarId]=q1.FirmalarId  
	                                       and [PerformansHareketler].[PerformansDonemiId]=q1.[PerformansDonemiId]
										   and [PerformansHareketler].[UcretPersonelId]=q1.[UcretPersonelId]
										   and [PerformansHareketler].[PuanlayanUcretPersonelId]=q1.[PuanlayanUcretPersonelId]
										   and [PerformansHareketler].OrganizasyonSemasiId=q1.OrganizasyonSemasiId) as BaslangicPuanSayisi
      , OrganizasyonSemasiId
	  ,[PerformansHareketler].PerformansAnaHedefleriId
  FROM [dbo].[PerformansHareketler]
  left join  UcretPersonel on PuanlayanUcretPersonelId = UcretPersonel.Id
  left join  PerformansDonemleri on PerformansDonemleri.Id = [PerformansHareketler].PerformansDonemiId
  where [PerformansHareketler].[RowDeleted] = '0' --and PuanlayanUcretPersonelId = 2
  group by [PerformansHareketler].[FirmalarId]
      ,[PerformansDonemiId]   
      ,[UcretPersonelId]
      ,[PuanlayanUcretPersonelId]
	  ,OrganizasyonSemasiId
	 , [PerformansHareketler].PerformansAnaHedefleriId
 --and [PerformansHareketler].[FirmalarId] = 4
 --select * from [PerformansHareketler]






GO


