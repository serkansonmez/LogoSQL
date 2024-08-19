USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerSeviye2]    Script Date: 3.09.2020 08:48:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from [VW_PerformansHareketlerSeviye2]
 CREATE View [dbo].[VW_PerformansHareketlerSeviye2] as
 select VW_PerformansHareketler.* from VW_PerformansHareketler 
LEFT join VW_PerformansHareketlerSeviye2Listesi altSeviye on altSeviye.FirmalarId = VW_PerformansHareketler.FirmalarId and 

															altSeviye.UcretPersonelId = VW_PerformansHareketler.UcretPersonelId and
															altSeviye.PerformansDonemiId = VW_PerformansHareketler.PerformansDonemiId and
															altSeviye.PerformansAnaHedefleriId = VW_PerformansHareketler.PerformansAnaHedefleriId and
															altSeviye.EnAlt = VW_PerformansHareketler.PuanDegeri and
															altSeviye.AltPuanDurum  = 'Puan Gidiyor'
LEFT join VW_PerformansHareketlerSeviye2Listesi ustSeviye on ustSeviye.FirmalarId = VW_PerformansHareketler.FirmalarId and 

															ustSeviye.UcretPersonelId = VW_PerformansHareketler.UcretPersonelId and
															ustSeviye.PerformansDonemiId = VW_PerformansHareketler.PerformansDonemiId and
															ustSeviye.PerformansAnaHedefleriId = VW_PerformansHareketler.PerformansAnaHedefleriId and
															ustSeviye.EnUst = VW_PerformansHareketler.PuanDegeri and
															ustSeviye.UstPuanDurum  = 'Puan Gidiyor'

 where --VW_PerformansHareketler.AdiSoyadi like 'volkan%'		AND		
 altSeviye.UcretPersonelId is  null		AND		ustSeviye.UcretPersonelId is  null							 
									/*
  cast(FirmalarId as varchar(20))  + '-' + cast( UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemiId as varchar(20)) + '-' + cast(PerformansAnaHedefleriId as varchar(20)) + '-' + cast((PuanDegeri * 1.00) as varchar(20))   
  not in (
select cast(FirmalarId as varchar(20))  + '-' + cast( UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemiId as varchar(20)) + '-' + cast(PerformansAnaHedefleriId as varchar(20)) + '-' + cast(EnAlt as varchar(20))     from	VW_PerformansHareketlerSeviyeListesi altSeviye  where AltPuanDurum  = 'Puan Gidiyor')
*/


GO


