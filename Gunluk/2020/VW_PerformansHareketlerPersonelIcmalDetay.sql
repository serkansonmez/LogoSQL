USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerPersonelIcmalDetay]    Script Date: 3.09.2020 08:47:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER view [dbo].[VW_PerformansHareketlerPersonelIcmalDetay] as
select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,
UcretPersonelId,AdiSoyadi,count(PuanDegeri) as PuanVerilenSayi,Count(Id) as ToplamSayi,
--isnull(SUM(AgirlikPuani) / count(AgirlikPuani),0) as AgirlikPuani,
isnull(SUM(AgirlikPuani) ,0) as AgirlikPuani,
case when count(PuanDegeri) < Count(Id) then 'Devam Ediyor' else 'Tamamlandý' end as Durum   
,HedefBaslik
,PerformansHedefleriId
from VW_PerformansHareketler --where AdiSoyadi like 'volkan%' and PuanlayanAdiSoyadi like 'özn%'
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,UcretPersonelId,AdiSoyadi
,HedefBaslik,PerformansHedefleriId

--select * from [VW_PerformansHareketlerPersonelIcmalDetay] where AdiSoyadi like 'volkan%' and PuanlayanAdiSoyadi like 'özn%'
--select * from VW_PerformansHareketler
--select * from [VW_PerformansHareketlerPersonelIcmal]



GO


