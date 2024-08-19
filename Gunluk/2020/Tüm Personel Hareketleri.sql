exec [dbo].[SP_PersonelIsyeriHareketleri] 'serkan','sönmez','%' 

create PROCEDURE [dbo].[SP_PersonelIsyeriHareketleri]
( @Adi varchar(20),@Soyadi varchar(20), @TcKimlikNo varchar(20) )
as 
begin

--DECLARE @Adi varchar(20) = 'serkan'
--DECLARE @Soyadi varchar(20) = 'sönmez'
--DECLARE @TcKimlikNo varchar(20) = '%'

DECLARE @sql nvarchar(4000);
declare  @TABLE
TABLE (	  
 SiraNo int,
 PerRef int,
 AdiSoyadi varchar(100) COLLATE Turkish_CI_AS,
 TcKimlikNo VARCHAR(50) COLLATE Turkish_CI_AS,
 KurumAdi varchar(100) COLLATE Turkish_CI_AS,
 IsyeriKodu varchar(512) COLLATE Turkish_CI_AS,
 IsyeriAdi varchar(512) COLLATE Turkish_CI_AS,
 IsyeriSicilNo varchar(512) COLLATE Turkish_CI_AS,
 BaslangicTarihi datetime,
 BitisTarihi datetime   )

SET @sql = 'SELECT * FROM OPENQUERY([192.168.1.6], 
                          ''select * from  Logo_JguarDb.dbo.fnc_PersonelIsyeriHareketleri('''''+@Adi+ ''''','''''+@Soyadi+ ''''','''''+@TcKimlikNo+ ''''')'')';

--select @sql
insert into @TABLE
EXEC (@sql)


select 'BordroPlus (2012 ve öncesi)' as Kaynak, * from bordro_db.dbo.fnc_PersonelIsyeriHareketleri(@Adi,@Soyadi,@TcKimlikNo)
UNION ALL
select 'BordroPlus (bornova)' as Kaynak,* from bordro_db_test.dbo.fnc_PersonelIsyeriHareketleri(@Adi,@Soyadi,@TcKimlikNo)
UNION ALL
select 'BordroPlus (2020 ve sonrasý)' as Kaynak,* from BORDROPLUS_DB.dbo.fnc_PersonelIsyeriHareketleri(@Adi,@Soyadi,@TcKimlikNo)
UNION ALL
SELECT 'J-guar (2013 ve 2019 arasý)' as Kaynak,SiraNo ,
 PerRef ,
 AdiSoyadi ,
 TcKimlikNo ,
 KurumAdi ,
 IsyeriKodu ,
 IsyeriAdi ,
 IsyeriSicilNo,
 BaslangicTarihi ,
 BitisTarihi  FROM @TABLE 

 
 end