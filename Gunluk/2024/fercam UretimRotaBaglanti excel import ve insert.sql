insert into UretimRotaBaglanti
select [REFERANS NUMARASI]
      ,[�R�N ROTASI]
      ,[FIRIN ROTASI]
      ,[Bando Setup Rotas�]
      ,[�r�n Modeli]  from UrunRotaKodlariKasim24   
left join UretimRotaBaglanti ON UretimRotaBaglanti.FercamKodu = UrunRotaKodlariKasim24.[REFERANS NUMARASI]
WHERE UretimRotaBaglanti.FercamKodu is null  

--select * from UretimRotaBaglanti