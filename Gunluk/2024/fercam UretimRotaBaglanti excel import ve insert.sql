insert into UretimRotaBaglanti
select [REFERANS NUMARASI]
      ,[ÜRÜN ROTASI]
      ,[FIRIN ROTASI]
      ,[Bando Setup Rotasý]
      ,[Ürün Modeli]  from UrunRotaKodlariKasim24   
left join UretimRotaBaglanti ON UretimRotaBaglanti.FercamKodu = UrunRotaKodlariKasim24.[REFERANS NUMARASI]
WHERE UretimRotaBaglanti.FercamKodu is null  

--select * from UretimRotaBaglanti