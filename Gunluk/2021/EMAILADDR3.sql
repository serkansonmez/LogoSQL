select TAXNR,EMAILADDR3,* from gold.dbo.LG_041_CLCARD WHERE CODE LIKE '320%'
select TAXNR,EMAILADDR3,* from gold.dbo.LG_051_CLCARD WHERE CODE LIKE '320%'
select TAXNR,EMAILADDR3,* from gold.dbo.LG_091_CLCARD WHERE CODE LIKE '320%'
select TAXNR,EMAILADDR3,* from gold.dbo.LG_121_CLCARD WHERE CODE LIKE '320%'
select TAXNR,EMAILADDR3,* from gold.dbo.LG_319_CLCARD WHERE CODE LIKE '320%'


select TBL121.DEFINITION_,LG_041_CLCARD.DEFINITION_,TBL121.EMAILADDR3, LG_041_CLCARD.EMAILADDR3,
'UPDATE LG_041_CLCARD SET EMAILADDR3=''' + TBL121.EMAILADDR3 + ''' WHERE LOGICALREF='  +  CAST(LG_041_CLCARD.LOGICALREF AS VARCHAR(20)) , * from  LG_121_CLCARD TBL121
LEFT JOIN LG_041_CLCARD ON SUBSTRING(LG_041_CLCARD.DEFINITION_,1,16) = SUBSTRING(TBL121.DEFINITION_,1,16)
WHERE TBL121.CODE LIKE '320%' AND LEN(TBL121.EMAILADDR3)>4 and LG_041_CLCARD.DEFINITION_ is not null AND TBL121.EMAILADDR3 NOT LIKE 'SERKANSONMEZ16%'