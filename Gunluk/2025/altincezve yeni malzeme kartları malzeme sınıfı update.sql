USE [AltinCezveB2B_Default_v1]
GO

SELECT [Türü]
      ,[Kodu]
      ,[Yeni Kod]
      ,[Açýklamasý]
      ,[Ana Birim]
      ,[Üretici Kodu]
	  ,'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20))
	  ,case  when [Türü] = '(HM)' then  10 when [Türü] = '(YM)' then  11 when [Türü] = '(MM)' then  12 end ,
	  LG_325_ITEMS.CARDTYPE 
	   ,'UPDATE  CEZVE..LG_325_ITEMS SET CARDTYPE = ' + CAST( case  when [Türü] = '(HM)' then  10 when [Türü] = '(YM)' then  11 when [Türü] = '(MM)' then  12 end AS VARCHAR(20))  + ' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) 
  FROM [dbo].[MalzemeYeniKodlar]
LEFT JOIN CEZVE..LG_325_ITEMS ON  CODE = [Yeni Kod]
where LG_325_ITEMS.CARDTYPE  is not null

--WHERE [Açýklamasý] like '%tat%'

--'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) is NOT  null

-- select * INTO CEZVE..LG_325_ITEMS_20250108 from  CEZVE..LG_325_ITEMS
