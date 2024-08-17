USE [EmySteelDB]
GO

/****** Object:  View [dbo].[VW_IsEmirleriDetay]    Script Date: 25.05.2021 15:59:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VW_IsEmirleriDetay] AS

SELECT DISTINCT [IsEmriDetayIsIstasyonu].[Id]
      ,[IsEmriDetayIsIstasyonu].PlanlamaMasterId
      ,[IsIstasyonuId]
	  ,IsIstasyonu.IsIstasyonuAdi
      ,[IsEmriDetayIsIstasyonu].[RowUpdatedTime]
	  ,Calisan.CalisanAdi
	  , IsEmriDetay.LogoVaryantRef
	  
  FROM [dbo].[IsEmriDetayIsIstasyonu] 
  left join IsEmriDetayCalisan ON IsEmriDetayIsIstasyonu.PlanlamaMasterId = IsEmriDetayCalisan.PlanlamaMasterId
  LEFT JOIN Calisan ON Calisan.Id = IsEmriDetayCalisan.CalisanId
  LEFT JOIN IsEmriDetay ON IsEmriDetayIsIstasyonu.PlanlamaMasterId = IsEmriDetay.PlanlamaMasterId 
  LEFT JOIN IsIstasyonu ON IsIstasyonu.Id = IsEmriDetayIsIstasyonu.IsIstasyonuId
  
 
GO


