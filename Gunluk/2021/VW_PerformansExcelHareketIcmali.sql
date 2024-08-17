--select PuanlananPersonelAdi,PuanlayanPersonelAdi,avg(OrtalamaPuan) as Puan from PerformansExcelHareket group by PuanlananPersonelAdi,PuanlayanPersonelAdi

alter view VW_PerformansExcelHareketIcmali as 
Select PuanlananPersonelAdi,PuanlananUcretPersonelId, avg(Puan) as Puan from (
select PuanlananPersonelAdi,PuanlayanPersonelAdi,PuanlananUcretPersonelId,avg(OrtalamaPuan) as Puan from PerformansExcelHareket group by PuanlananUcretPersonelId,PuanlananPersonelAdi,PuanlayanPersonelAdi) tbl
group by PuanlananPersonelAdi,PuanlananUcretPersonelId

--select * from VW_PerformansExcelHareketIcmali