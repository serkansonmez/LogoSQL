USE [AltinCezveB2B_Default_v1]
GO

SELECT [T�r�]
      ,[Kodu]
      ,[Yeni Kod]
      ,[A��klamas�]
      ,[Ana Birim]
      ,[�retici Kodu]
	  ,'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20))
	  ,case  when [T�r�] = '(HM)' then  10 when [T�r�] = '(YM)' then  11 when [T�r�] = '(MM)' then  12 end ,
	  LG_325_ITEMS.CARDTYPE 
	   ,'UPDATE  CEZVE..LG_325_ITEMS SET CARDTYPE = ' + CAST( case  when [T�r�] = '(HM)' then  10 when [T�r�] = '(YM)' then  11 when [T�r�] = '(MM)' then  12 end AS VARCHAR(20))  + ' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) 
  FROM [dbo].[MalzemeYeniKodlar]
LEFT JOIN CEZVE..LG_325_ITEMS ON  CODE = [Yeni Kod]
where LG_325_ITEMS.CARDTYPE  is not null

--WHERE [A��klamas�] like '%tat%'

--'UPDATE  CEZVE..LG_325_ITEMS SET CODE = ''' + [Yeni Kod] + ''' WHERE LOGICALREF=' + CAST(LOGICALREF AS VARCHAR(20)) is NOT  null

-- select * INTO CEZVE..LG_325_ITEMS_20250108 from  CEZVE..LG_325_ITEMS
