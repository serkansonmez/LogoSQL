USE [FercamB2B_Default_v1]
GO
create view VW_KasaPlanlama as 
SELECT [KasaPlanlamaId]
      ,[RowCreatedTime]
      ,[RowCreatedBy]
      ,[UretimEmriNo]
      ,[KasaTahminAdet]
      ,[PlanlamaTarih]
      ,[KasaKimlikNo]
      ,[PlanlananEn]
      ,[PlanlananBoy]
      ,[PlanlananDerinlik]
      ,[SonTeslimTarihi]
      ,[GerceklesenUserId]
      ,[GerceklesenEn]
      ,[GerceklesenBoy]
      ,[GerceklesenDerinlik]
      ,[GerceklesenTarih]
	  ,CLCARD.CODE AS CariHesapKodu
	  ,CLCARD.DEFINITION_ AS CariHesapAdi
	  ,ITEMS.CODE as MalzemeKodu
	  ,ITEMS.NAME as MalzemeAdi
  FROM [dbo].[KasaPlanlama]
 LEFT JOIN TIGER..LG_025_PRODORD PROD  WITH(NOLOCK) ON PROD.FICHENO COLLATE SQL_Latin1_General_CP1_CI_AS =  [KasaPlanlama].[UretimEmriNo]

LEFT JOIN TIGER..LG_025_PEGGING PEGGING  WITH(NOLOCK) ON PEGGING.PEGREF = PROD.LOGICALREF

 LEFT JOIN TIGER.dbo.LG_025_01_ORFLINE  AS ORFLINE  WITH(NOLOCK) ON ORFLINE.LOGICALREF =  PEGGING.PORDLINEREF
    LEFT JOIN TIGER.dbo.LG_025_01_ORFICHE AS ORFICHE  WITH(NOLOCK) ON ORFLINE.LOGICALREF =  PEGGING.PORDFICHEREF
	
    LEFT JOIN TIGER.dbo.LG_025_ITEMS AS ITEMS  WITH(NOLOCK) ON ORFLINE.STOCKREF = ITEMS.LOGICALREF 
    LEFT JOIN TIGER.dbo.LG_025_CLCARD AS CLCARD  WITH(NOLOCK) ON ORFLINE.CLIENTREF = CLCARD.LOGICALREF 
    LEFT OUTER JOIN (SELECT ITEMREF, CLIENTREF, ICUSTSUPCODE FROM TIGER.dbo.LG_025_SUPPASGN  WITH(NOLOCK) ) AS TEDARIKCI 
        ON CLCARD.LOGICALREF = TEDARIKCI.CLIENTREF AND ITEMS.LOGICALREF = TEDARIKCI.ITEMREF  

 