USE [AlvinB2B_Default_v1]
GO

SELECT * from AsasDbFiyat where ListeNo is null
 
SELECT ROW_NUMBER() over (order by LISTENO ) AS [Sayac],
  LISTENO as [ListeNo],
  VW_IREN_ASAS_2024_dbFiyat.STOKKODU as [StokKodu] ,
  FIYAT1 as [Fiyat1],
  FIYAT2 as [Fiyat2],
  FIYAT3 as [Fiyat3],
  FIYAT4 as [Fiyat4],
  FIYAT5 as [Fiyat5],
  FIYAT6 as [Fiyat6],
  FIYAT7 as [Fiyat7],
  FIYAT8 as [Fiyat8],
  FIYAT9 as [Fiyat9],
  FIYAT10 as [Fiyat10], 
  IskontoOrani,
  ROUND(FIYAT1 - (FIYAT1 * isnull(IskontoOrani,0) / 100),2) as IskontoFiyat1, 
  DOVIZ 
  into AsasDbFiyat 
  FROM VW_IREN_ASAS_2024_dbFiyat
  LEFT join ErcomStok ON ErcomStok.StokKodu = VW_IREN_ASAS_2024_dbFiyat.STOKKODU

SELECT [Sayac]
      ,[ListeNo]
      ,[StokKodu]
      ,[Fiyat1]
      ,[Fiyat2]
      ,[Fiyat3]
      ,[Fiyat4]
      ,[Fiyat5]
      ,[Fiyat6]
      ,[Fiyat7]
      ,[Fiyat8]
      ,[Fiyat9]
      ,[Fiyat10]
      ,[Doviz]
  FROM [dbo].[ErcomDbFiyat]

GO


