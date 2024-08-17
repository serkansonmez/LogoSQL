USE [TrendyolDb]
GO

SELECT [ProductId]
      ,[AttId]
      ,[AttName]
      ,[AttValueId]
      ,[AttValueName]
      ,[AttCode]
  FROM [dbo].[tbl_001_EPazar_TrendStokAttributes] where AttValuename like 'CON%'

select * from tbl_001_stok where a_barkod = '0354370'

select * from tbl_001_EPazar_Stok

 select * from tbl_001_EPazar_TrendImage where StokId = '051043583c90acac64330e612005fc73'

  --select * from tbl_001_EPazar_TrendKategori

  --select * from tbl_001_EPazar_TrendStokItems

 
 select * from tbl_001_EPazar_TrendStok where Title like '285/45ZR21 (109Y) FR ContiSportContact 5P MO Continental 0356480 Yazlýk Lastik%'
 '195/65R15 91H UltraContact Continental 0312349 Yazlýk Lastik'


select * from tbl_001_EPazar_TrendStok where Id = '03aa1ec9a937f4f4c78813b5c5c41b57'


