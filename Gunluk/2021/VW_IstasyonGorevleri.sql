USE [EmySteelDB]
GO

/****** Object:  View [dbo].[VW_IstasyonGorevleri]    Script Date: 25.05.2021 15:58:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[VW_IstasyonGorevleri] AS

  SELECT DISTINCT 
  
  IsIstasyonu.[Id]
      ,[IsIstasyonuKodu]
      ,IsIstasyonu.[IsIstasyonuAdi]
	  ,VW_IsEmirleriDetay.CalisanAdi
	  ,VW_IsEmirleriDetay.LogoVaryantRef
	  ,VW_IsEmirleriDetay.PlanlamaMasterId
	  ,VW_IsEmirleriDetay.RowUpdatedTime
   From IsIstasyonu 

  LEFT JOIN VW_IsEmirleriDetay ON VW_IsEmirleriDetay.IsIstasyonuId = IsIstasyonu.Id
GO


