USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_OrganizasyonSemasi]    Script Date: 10.09.2020 15:32:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[VW_OrganizasyonSemasi] as 
select OrganizasyonSemasi.*,UcretPersonel.Adi + ' ' + UcretPersonel.Soyadi  as AdiSoyadi
,UcretPersonel.Adi + ' ' + UcretPersonel.Soyadi  + ' (' + PozisyonAdi + ')'as OrganizasyonAdiSoyadi from OrganizasyonSemasi
left join UcretPersonel on UcretPersonel.Id = UcretPersonelId
GO


