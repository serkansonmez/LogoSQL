USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansSonucSeviyelerIcmali]    Script Date: 3.09.2020 08:49:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[VW_PerformansSonucSeviyelerIcmali] as
SELECT FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,
PerformansAnaHedefleriId,AnaHedefler,HedefBaslik,MAX(OrtalamaPuan) Ortalama,MAX(Seviye1Puan) as Seviye1,MAX(Seviye2Puan) as Seviye2 from 

(select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,
PerformansAnaHedefleriId,AnaHedefler,HedefBaslik,avg(PuanDegeri * 1.00) as OrtalamaPuan,0 as Seviye1Puan,0 as Seviye2Puan from [VW_PerformansHareketler] --where AdiSoyadi Like 'volkan%' 
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,PerformansAnaHedefleriId,AnaHedefler,HedefBaslik
UNION ALL
select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,
PerformansAnaHedefleriId,AnaHedefler,HedefBaslik,0 as OrtalamaPuan,avg(PuanDegeri * 1.00) as Seviye1Puan,0 as Seviye2Puan from [VW_PerformansHareketlerSeviye1] --where AdiSoyadi Like 'volkan%' 
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,PerformansAnaHedefleriId,AnaHedefler,HedefBaslik

UNION ALL
select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,
PerformansAnaHedefleriId,AnaHedefler,HedefBaslik,0 as OrtalamaPuan,0 as Seviye1Puan,avg(PuanDegeri * 1.00) as Seviye2Puan from [VW_PerformansHareketlerSeviye2] --where AdiSoyadi Like 'volkan%' 
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,PerformansAnaHedefleriId,AnaHedefler,HedefBaslik) as tbl

group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,UcretPersonelId,AdiSoyadi,PerformansAnaHedefleriId,AnaHedefler,HedefBaslik

--select * from [VW_PerformansHareketlerSeviye1] where AdiSoyadi Like 'volkan%'


GO


