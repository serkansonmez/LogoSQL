USE [EnaFlow_DB]
GO

/****** Object:  View [dbo].[VW_TedarikcilereGidenMailler]    Script Date: 6.04.2022 09:34:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--ALTER view [dbo].[VW_TedarikcilereGidenMailler] as  
select OnaytalepleriId,kime from SatinalmaTalepFormu WITH(NOLOCK)
left join MailTablosu  WITH(NOLOCK) on TabloAdi = 'SatinalmaTalepFormu' and TabloId = SatinalmaTalepFormu.Id
where   kime is not null group by onaytalepleriID,kime
GO


