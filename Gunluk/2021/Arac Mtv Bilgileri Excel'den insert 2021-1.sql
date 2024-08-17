select sum (mtv ) from AracMtv2021_1

select * from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2021
--select sum(MtvTutari) from AracMtvBilgileri where DonemNumarasi = 1 and DonemYili = 2021


--insert into AracMtvBilgileri
select 

0 [RowVersion]
      ,'0' [RowDeleted]
      ,'20210731' [RowUpdatedTime]
      ,2 [RowUpdatedBy]
      ,AracBilgileri.id [AracBilgisiId]
      ,'20210731' [OdemeTarihi]
      ,MTV  [MtvTutari]
      ,2021 [DonemYili]
      ,1 [DonemNumarasi]
      ,'-' [MakbuzNo]

 from AracMtv2021_2
LEFT JOIN AracBilgileri on replace(PlakaKodu,' ','') = PLAKA 
where AracBilgileri.id not in (select AracBilgisiId from AracMtvBilgileri where DonemYili = 2021 and DonemNumarasi=2)
and AracBilgileri.id is not null AND AracBilgileri.RowDeleted = '0'    
 



select * from  AracMtvBilgileri where DonemYili = 2021 and DonemNumarasi = 1


update  AracMtvBilgileri set DonemNumarasi = 1 , OdemeTarihi = '20210131'
where DonemYili = 2021 and DonemNumarasi = 2



select * from AracMtv2021_1


select * from AracBilgileri where PlakaKodu = '10 BR 499'