 CREATE view VW_TigerMalzemeGruplari as 
 select 1 as Referans ,  'Ticari Mal ' as GrupAdi UNION ALL SELECT 
 2 as Referans , 'Karma Koli'  as GrupAdi UNION ALL SELECT    3 as Referans , 'Depozitolu Mal'  as GrupAdi UNION ALL SELECT  4 as Referans , 'Sabit Kýymet'  as GrupAdi UNION ALL SELECT  10 as Referans , 'Ham Madde'  as GrupAdi UNION ALL SELECT  11 as Referans , 'Yarý Mamul'  as GrupAdi UNION ALL SELECT  12 as Referans , 'Mamul'  as GrupAdi UNION ALL SELECT  13 as Referans , 'Tüketim Malý'  as GrupAdi 
 UNION ALL SELECT  20 as Referans , 'Genel Malzeme Sýnýfý' 


 select  * from LG_106_ITEMS