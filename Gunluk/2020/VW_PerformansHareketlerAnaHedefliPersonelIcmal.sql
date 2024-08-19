USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerAnaHedefliPersonelIcmal]    Script Date: 3.09.2020 08:47:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER view [dbo].[VW_PerformansHareketlerAnaHedefliPersonelIcmal] as
select FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,
UcretPersonelId,AdiSoyadi,count(PuanDegeri) as PuanVerilenSayi,Count(Id) as ToplamSayi,isnull(SUM(PuanDegeri) / count(PuanDegeri),0) as PuanDegeri,
case when count(PuanDegeri) < Count(Id) then 'Devam Ediyor' else 'Tamamlandý' end as Durum   from VW_PerformansHareketlerAnaHedefliDetayli
group by FirmalarId,SirketAdi,PerformansDonemiId,PerformansDonemi,PerformansAnaHedefleriId,AnaHedefler,UcretPersonelId,AdiSoyadi

GO


