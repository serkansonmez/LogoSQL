 CREATE view VW_TigerMalzemeGruplari as 
 select 1 as Referans ,  'Ticari Mal ' as GrupAdi UNION ALL SELECT 
 2 as Referans , 'Karma Koli'  as GrupAdi UNION ALL SELECT    3 as Referans , 'Depozitolu Mal'  as GrupAdi UNION ALL SELECT  4 as Referans , 'Sabit K�ymet'  as GrupAdi UNION ALL SELECT  10 as Referans , 'Ham Madde'  as GrupAdi UNION ALL SELECT  11 as Referans , 'Yar� Mamul'  as GrupAdi UNION ALL SELECT  12 as Referans , 'Mamul'  as GrupAdi UNION ALL SELECT  13 as Referans , 'T�ketim Mal�'  as GrupAdi 
 UNION ALL SELECT  20 as Referans , 'Genel Malzeme S�n�f�' 


 select  * from LG_106_ITEMS