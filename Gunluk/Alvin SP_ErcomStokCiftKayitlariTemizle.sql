--  exec SP_ErcomStokCiftKayitlariTemizle
create procedure SP_ErcomStokCiftKayitlariTemizle as 
declare @StokKodu varchar(50)
declare @PozNo varchar(50)

declare @silinmeyecekId int

DECLARE processes CURSOR FOR

--select* into ErcomStok_20231121 from ErcomStok
select StokKodu  from ErcomStok group by StokKodu having   count(StokKodu)>1

OPEN processes
 
FETCH NEXT FROM processes
INTO  @StokKodu 
WHILE @@FETCH_STATUS = 0
BEGIN
       -- silinmeyecek Id'yi bul
	   select top 1 @silinmeyecekId=Id from ErcomStok where StokKodu=@StokKodu    order by Id 

	   delete from ErcomStok where StokKodu=@StokKodu   and ID <> @silinmeyecekId  

FETCH NEXT FROM processes
INTO @StokKodu 
END

 


CLOSE processes
DEALLOCATE processes