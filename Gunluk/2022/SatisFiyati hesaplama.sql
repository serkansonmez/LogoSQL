declare @TabanFiyat float = 1210
declare @Kargo float = 54.106
declare @SatisFiyati float = 0 

declare @KomisyonTutari float = 0 

set @SatisFiyati = @TabanFiyat + @Kargo + (@SatisFiyati * 0.05)

select @SatisFiyati,(@SatisFiyati * 0.05)


@SatisFiyati = 1330.6382
 