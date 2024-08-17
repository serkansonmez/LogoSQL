select * from Kullanicilar where id in (SELECT KullaniciId FROM Kullanici_Yetkileri WHERE  YetkiTableId = 366 and YetkiTurleriId = 1)


select * from Kullanicilar where kodu like '%o%'