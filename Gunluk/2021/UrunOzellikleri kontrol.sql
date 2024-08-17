select SecenekId,count(SecenekId) as Sayi from UrunOzellikleri where UrunlerId = 11936 group by SecenekId

select SecenekDegeriId,count(SecenekDegeriId) as Sayi from UrunOzellikleri where 
UrunlerId = 11936 and  SecenekId = 4 group by SecenekDegeriId

select SecenekDegeriId,count(SecenekDegeriId) as Sayi from UrunOzellikleri where 
                                               SecenekId  =4 and  UrunlerId = 11936 group by SecenekDegeriId



											   select SecenekDegeriId,count(SecenekDegeriId) as Sayi from UrunOzellikleri where 
                                               SecenekId  =5 and  UrunlerId = 11936 group by SecenekDegeriId




select Secenek.SecenekAdi,SecenekDegeri.secenekdegeriAciklama ,Secenek.SecenekId FROM UrunOzellikleri 
left join Secenek on Secenek.SecenekId = UrunOzellikleri.SecenekId
left join SecenekDegeri on SecenekDegeri.SecenekDegeriId = UrunOzellikleri.SecenekDegeriId
where UrunlerId = 11936  


varyant[0].Name = Renk
varyant[0].Name = Kýrmýzý
varyant[1].Name = Paket
varyant[1].Name = 100


varyant[0].Name = Renk
varyant[0].Name = Sarý
varyant[1].Name = Paket
varyant[1].Name = 100