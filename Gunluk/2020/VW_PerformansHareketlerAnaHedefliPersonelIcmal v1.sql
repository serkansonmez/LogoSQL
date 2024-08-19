USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerAnaHedefliPersonelIcmal]    Script Date: 2.10.2020 17:49:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[VW_PerformansHareketlerAnaHedefliPersonelIcmal] as
select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,
UcretPersonelId,AdiSoyadi,count(PuanDegeri) as PuanVerilenSayi,Count(Id) as ToplamSayi,isnull(SUM(cast(PuanDegeri as float)) / count(cast(PuanDegeri as float)),0) as PuanDegeri,
case when count(PuanDegeri) < Count(Id) then 'Devam Ediyor' else 'Tamamland�' end as Durum   from VW_PerformansHareketlerAnaHedefliDetayli
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,UcretPersonelId,AdiSoyadi


GO

