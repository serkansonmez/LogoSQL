USE [AltinCezveB2B_Default_v1]
GO

SELECT [T�r�]
      ,[Kodu]
      ,[Yeni Kod]
      ,[A��klamas�]
      ,[Ana Birim]
      ,[�retici Kodu]
	  ,'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20))
  FROM [dbo].[MalzemeYeniKodlar]
LEFT JOIN CEZVE..LG_325_ITEMS ON  CODE = [Kodu]

WHERE [A��klamas�] like '%KU�%'

--'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) is NOT  null
