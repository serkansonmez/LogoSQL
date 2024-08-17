create procedure SP_EmyEnvanterFiyatListesiInsert as
insert into EmyEnvanterFiyatListesi
select EmyEnvanter.LOGICALREF ,0  from EmyEnvanter 
left join EmyEnvanterFiyatListesi ON EmyEnvanterFiyatListesi.LOGICALREF collate SQL_Latin1_General_CP1254_CI_AS  = EmyEnvanter.LOGICALREF  
where EmyEnvanterFiyatListesi.EmyEnvanterFiyatListesiId is null