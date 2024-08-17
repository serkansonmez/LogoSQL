insert into Kullanici_Yetkileri
SELECT 379,RolId FROM Kullanici_Rolleri where KullaniciID = 361

insert into Kullanici_Yetkileri
select 379,YetkiTurleriId,YetkiTableId from Kullanici_Yetkileri  where KullaniciID = 361