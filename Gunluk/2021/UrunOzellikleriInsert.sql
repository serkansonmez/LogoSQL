insert into UrunOzellikleri
SELECT Urunler.UrunlerId, 'Marka','Diger' FROM Urunler 
left join UrunOzellikleri on UrunOzellikleri.UrunlerId = Urunler.UrunlerId and
UrunOzellikleri.UrunSecenegiBaslik = 'Marka' and
UrunOzellikleri.UrunSecenegiDeger = 'Diger'  
where UrunOzellikleri.UrunOzellikleriId is null


SELECT * FROM UrunOzellikleri where UrunlerId = 2441


update UrunOzellikleri set UrunSecenegiDeger = 'Diðer'  where UrunSecenegiDeger = 'Diger'