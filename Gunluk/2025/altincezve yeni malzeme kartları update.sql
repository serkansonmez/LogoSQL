USE [AltinCezveB2B_Default_v1]
GO

SELECT [Türü]
      ,[Kodu]
      ,[Yeni Kod]
      ,[Açýklamasý]
      ,[Ana Birim]
      ,[Üretici Kodu]
	  ,'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20))
  FROM [dbo].[MalzemeYeniKodlar]
LEFT JOIN CEZVE..LG_325_ITEMS ON  CODE = [Kodu]

WHERE [Açýklamasý] like '%KUÞ%'

--'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) is NOT  null
