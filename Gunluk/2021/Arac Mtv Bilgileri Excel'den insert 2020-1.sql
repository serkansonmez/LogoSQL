select sum (mtv ) from AracMtv2020_1

select * from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2020
--select sum(MtvTutari) from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2020


--insert into AracMtvBilgileri
select 

0 [RowVersion]
      ,'0' [RowDeleted]
      ,'20200131' [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,AracBilgileri.id [AracBilgisiId]
      ,'20200131' [OdemeTarihi]
      ,MTV  [MtvTutari]
      ,2020 [DonemYili]
      ,1 [DonemNumarasi]
      ,'-' [MakbuzNo]


 from AracMtv2020_1
LEFT JOIN AracBilgileri on PlakaKodu = PLAKANO  
where AracBilgileri.id not in (select AracBilgisiId from AracMtvBilgileri where DonemYili = 2020 and DonemNumarasi=2)
and AracBilgileri.id is not null AND AracBilgileri.RowDeleted = '0'    
 



select * from  AracMtvBilgileri where DonemYili = 2020 and DonemNumarasi = 1


update  AracMtvBilgileri set DonemNumarasi = 1 , OdemeTarihi = '20200131'
where DonemYili = 2020 and DonemNumarasi = 2



select * from AracMtv2020_1