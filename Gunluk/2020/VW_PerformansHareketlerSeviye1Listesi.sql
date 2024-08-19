USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerSeviye1Listesi]    Script Date: 3.09.2020 08:48:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[VW_PerformansHareketlerSeviye1Listesi] as
SELECT 'Seviye1' as Seviye, HedefBaslik,AdiSoyadi,UcretPersonelId,FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,UnvanlarId, avg(PuanDegeri * 1.00) Ortalama , min(PuanDegeri * 1.00) as EnAlt, Max(PuanDegeri * 1.00) as EnUst
,avg(PuanDegeri * 1.00) - 25 as EnAltFarki, 
min(PuanDegeri * 1.00) - (avg(PuanDegeri * 1.00) - 25) as AltPuanDurumDeger,
case when min(PuanDegeri * 1.00)>avg(PuanDegeri * 1.00) - 25 then 'Puan Kalýyor' else 'Puan Gidiyor' end AltPuanDurum
,avg(PuanDegeri * 1.00) + 25 as EnUstFarki, 
avg(PuanDegeri * 1.00) + 25 - max(PuanDegeri * 1.00) as UstPuanDurumDeger,
case when avg(PuanDegeri * 1.00) + 25 > max(PuanDegeri * 1.00) then 'Puan Kalýyor' else 'Puan Gidiyor' end UstPuanDurum
FROM VW_PerformansHareketler
   where AdiSoyadi like 'volkan%'  
 group by HedefBaslik,AdiSoyadi,UcretPersonelId,PerformansDonemiId,FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,UnvanlarId
 having   avg(PuanDegeri * 1.00)  > 0
  /*
 UNION ALL
 
 SELECT 'Seviye1' as Seviye, HedefBaslik,AdiSoyadi,UcretPersonelId,FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,UnvanlarId, avg(PuanDegeri * 1.00) Ortalama , min(PuanDegeri * 1.00) as EnAlt, Max(PuanDegeri * 1.00) as EnUst
,avg(PuanDegeri * 1.00) - 15 as EnAltFarki, 
min(PuanDegeri * 1.00) - (avg(PuanDegeri * 1.00) - 15) as AltPuanDurumDeger,
case when min(PuanDegeri * 1.00)>avg(PuanDegeri * 1.00) - 15 then 'Puan Kalýyor' else 'Puan Gidiyor' end AltPuanDurum
,avg(PuanDegeri * 1.00) + 15 as EnUstFarki, 
avg(PuanDegeri * 1.00) + 15 - max(PuanDegeri * 1.00) as UstPuanDurumDeger,
case when avg(PuanDegeri * 1.00) + 15 > max(PuanDegeri * 1.00) then 'Puan Kalýyor' else 'Puan Gidiyor' end UstPuanDurum
FROM VW_PerformansHareketler
 -- where AdiSoyadi like 'volkan%'  
 group by HedefBaslik,AdiSoyadi,UcretPersonelId,PerformansDonemiId,FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,UnvanlarId
 having   avg(PuanDegeri * 1.00)  > 0
 */


GO


