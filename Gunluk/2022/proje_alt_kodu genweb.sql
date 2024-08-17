 alter view VW_ProjeAltTuru as 
select cast( ProjeTuru.ID as varchar(20)) + '-' +  cast( ProjeAltTuru.ID  as varchar(20)) as Id  , ProjeTurAdi + '-' + ProjeAltTurAdi as Adi,
ProjeTuru.Kod as ProjeTuruKodu,
ProjeAltTuru.Kod as ProjeAltTuruKodu
from  ProjeTuru, ProjeAltTuru
 
 select * from VW_TigerFirmalar

 select count(*) + 1 as SonSira from TaskList where CompanyId = 78


 select  * from TaskList  where ProjectPhaseId is not null
 select '039.10.010.' + cast(CompanyId as varchar(10))+ '.' + cast(Id as varchar(10)) , * from VW_TaskList
 
 update TaskList set  VwProjeAltTuruId = '1-1' where ProjectPhaseId is not null  
 update TaskList set  CompanyId = '85' where ProjectPhaseId is not null and Subject_  ='Portelli'
  update TaskList set  CompanyId = '84' where ProjectPhaseId is not null and Subject_  ='Guarrato'
update TaskList set  CompanyId = '86' where ProjectPhaseId is not null and Subject_  ='Principe I'
update TaskList set  CompanyId = '87' where ProjectPhaseId is not null and Subject_  ='Principe II'
update TaskList set  CompanyId = '88' where ProjectPhaseId is not null and Subject_  ='Santa Domenica'
update TaskList set  ProjeKodu = '039.10.010.0' + cast(CompanyId as varchar(10))+ '.' + cast(Id as varchar(10)) where ProjectPhaseId is not null and Subject_  ='Principe II'

 select '039.10.010.' + cast(CompanyId as varchar(10))+ '.' + cast(Id as varchar(10)) , * from VW_TaskList
 


Viglione
Gimillaro
--Principe I
--XXX
--Principe II
--Guarrato
--Portelli
--Santa Domenica
Gimillaro
Iesce
Viglione
Viglione
Pigna
Ciurlo
Mele