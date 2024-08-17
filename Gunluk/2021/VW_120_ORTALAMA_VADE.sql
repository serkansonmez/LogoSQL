USE [TIGER3_STEEL]
GO

/****** Object:  View [dbo].[VW_121_ORTALAMA_VADE]    Script Date: 25.05.2021 15:41:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 CREATE VIEW [dbo].[VW_121_ORTALAMA_VADE] AS
SELECT TBLTOPLAMKATSAYI.CARDREF, 
cast(cast( ToplamKatsayi / ToplamKalan   as datetime) as date) as OrtalamaVade ,

  convert(varchar, cast( ToplamKatsayi / ToplamKalan   as datetime) ,104) as OrtalamaVadeStr
FROM 
(SELECT CARDREF,SUM(CAST( DATE_ AS INT) * TOTAL ) AS ToplamKatsayi FROM LG_121_01_PAYTRANS WHERE PAID = 0 GROUP BY CARDREF) AS TBLTOPLAMKATSAYI
left join (
SELECT CARDREF,SUM(  TOTAL ) as ToplamKalan FROM LG_121_01_PAYTRANS WHERE PAID = 0 GROUP BY CARDREF) as TblToplamKalan on TblToplamKalan.CARDREF = TBLTOPLAMKATSAYI.CARDREF
GO


