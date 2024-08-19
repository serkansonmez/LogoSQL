  select cast(FirmalarId as varchar(20))  + '-' + cast( UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemiId as varchar(20)) + '-' + cast(PerformansAnaHedefleriId as varchar(20)),* from VW_PerformansHareketler 
   
LEFT join VW_PerformansHareketlerSeviyeListesi altSeviye on altSeviye.FirmalarId = VW_PerformansHareketler.FirmalarId and 

															altSeviye.UcretPersonelId = VW_PerformansHareketler.UcretPersonelId and
															altSeviye.PerformansDonemiId = VW_PerformansHareketler.PerformansDonemiId and
															altSeviye.PerformansAnaHedefleriId = VW_PerformansHareketler.PerformansAnaHedefleriId and
															altSeviye.EnAlt = VW_PerformansHareketler.PuanDegeri and
															AltPuanDurum  = 'Puan Gidiyor'
 where VW_PerformansHareketler.AdiSoyadi like 'volkan%'		AND		altSeviye.UcretPersonelId is not null								 
									/*
  cast(FirmalarId as varchar(20))  + '-' + cast( UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemiId as varchar(20)) + '-' + cast(PerformansAnaHedefleriId as varchar(20)) + '-' + cast((PuanDegeri * 1.00) as varchar(20))   
  not in (
select cast(FirmalarId as varchar(20))  + '-' + cast( UcretPersonelId as varchar(20)) + '-' + cast(PerformansDonemiId as varchar(20)) + '-' + cast(PerformansAnaHedefleriId as varchar(20)) + '-' + cast(EnAlt as varchar(20))     from	VW_PerformansHareketlerSeviyeListesi altSeviye  where AltPuanDurum  = 'Puan Gidiyor')
*/