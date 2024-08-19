USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansAnaHedeflerdeEksikUnvanlar]    Script Date: 3.09.2020 08:45:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[VW_PerformansAnaHedeflerdeEksikUnvanlar] as 
select DISTINCT   PerformansAnaHedefleri.Id as PerformansAnaHedefleriId,PerformansAnaHedefleri.AnaHedefler,Unvanlar.UnvanAdi,Unvanlar.Id as UnvanlarId from PerformansSablonu
left join OrganizasyonSemasi on OrganizasyonSemasi.Id =PerformansSablonu.OrganizasyonSemasiId
left join Unvanlar on Unvanlar.Id = OrganizasyonSemasi.UnvanlarId
left join PerformansAnaHedefleri on PerformansAnaHedefleri.Id = PerformansSablonu.PerformansAnaHedefleriId
left join PerformansHedefleri on PerformansHedefleri.PerformansAnaHedefleriId = PerformansSablonu.PerformansAnaHedefleriId and PerformansHedefleri.UnvanlarId = OrganizasyonSemasi.UnvanlarId
where PerformansHedefleri.Id is null and PerformansAnaHedefleri.AltHedeflerAktif='1'


GO


