select CHARINDEX(' ',UrunKodu), * from FiyatListeleri   where CHARINDEX(' ',UrunKodu)>0


 update FiyatListeleri set AktarimTuru = 1  where CHARINDEX(' ',UrunKodu)>0

 update FiyatListeleri set AktarimTuru = 2  where AktarimTuru is null