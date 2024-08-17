insert into Kullanici_Yetkileri
SELECT DISTINCT Kullanicilar.Id,1,Kullanicilar.Id FROM Kullanicilar 
left join Kullanici_Yetkileri on Kullanici_Yetkileri.KullaniciId  = Kullanicilar.Id AND  Kullanici_Yetkileri.YetkiTurleriId = 1  and Kullanici_Yetkileri.YetkiTableId  = Kullanicilar.Id
 WHERE Kullanici_Yetkileri.Id is   null


 --select * from Kullanici_Yetkileri

 insert into Kullanici_Rolleri
 SELECT DISTINCT Kullanicilar.Id,1  FROM Kullanicilar 
left join Kullanici_Rolleri on Kullanici_Rolleri.KullaniciId  = Kullanicilar.Id AND  
Kullanici_Rolleri.RolId = 1   
 WHERE Kullanici_Rolleri.Id is   null

  insert into Kullanici_Rolleri
 SELECT DISTINCT Kullanicilar.Id,9  FROM Kullanicilar 
left join Kullanici_Rolleri on Kullanici_Rolleri.KullaniciId  = Kullanicilar.Id AND  
Kullanici_Rolleri.RolId = 9  
 WHERE Kullanici_Rolleri.Id is   null
 /*
  --delete from Kullanici_Rolleri where Id in (2264,
2265,
2266,
2267,
2268,
2269,
2270,
2271,
2272) */
