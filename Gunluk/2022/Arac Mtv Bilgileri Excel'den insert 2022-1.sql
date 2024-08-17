select sum (mtv ) from AracMtv2022_1
select * from AracMtv2022_1

select * from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2022
--select sum(MtvTutari) from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2022


--insert into AracMtvBilgileri
select 

0 [RowVersion]
      ,'0' [RowDeleted]
      ,'20220131' [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,AracBilgileri.id [AracBilgisiId]
      ,'20220131' [OdemeTarihi]
      ,MTV  [MtvTutari]
      ,2022 [DonemYili]
      ,1 [DonemNumarasi]
      ,'-' [MakbuzNo]

 from AracMtv2022_1
LEFT JOIN AracBilgileri on replace(PlakaKodu,' ','') = PLAKA 
where AracBilgileri.id not in (select AracBilgisiId from AracMtvBilgileri where DonemYili = 2022 and DonemNumarasi=1)
and AracBilgileri.id is not null AND AracBilgileri.RowDeleted = '0'    
 



select * from  AracMtvBilgileri where DonemYili = 2022 and DonemNumarasi = 2


update  AracMtvBilgileri set DonemNumarasi = 1 , OdemeTarihi = '20220131'
where DonemYili = 2022 and DonemNumarasi = 2



select * from AracMtv2022_1


select * from AracBilgileri where PlakaKodu = '10 BR 499'