delete from [PerformansHareketler] where Id in (
SELECT [PerformansHareketler].[Id]
 
  FROM [dbo].[PerformansHareketler]
  left join Kullanicilar Kaydeden on Kaydeden.Id = [PerformansHareketler].[RowUpdatedBy] 
  left join Firmalar  on Firmalar.Id = [PerformansHareketler].FirmalarId 
  left join PerformansDonemleri  on PerformansDonemleri.Id = [PerformansHareketler].[PerformansDonemiId] 
  left join OrganizasyonSemasi  on OrganizasyonSemasi.Id = [PerformansHareketler].OrganizasyonSemasiId 
  left join UcretPersonel  on UcretPersonel.Id = [PerformansHareketler].UcretPersonelId 
  left join Unvanlar  on Unvanlar.Id = [PerformansHareketler].UnvanlarId 
  left join [PerformansAnaHedefleri]  on [PerformansAnaHedefleri].Id = [PerformansHareketler].[PerformansAnaHedefleriId] 
  left join [PerformansHedefleri]  on [PerformansHedefleri].Id = [PerformansHareketler].[PerformansHedefleriId] 
  left join OrganizasyonSemasi PuanlayanOrganizasyonSemasi  on PuanlayanOrganizasyonSemasi.Id = [PerformansHareketler].PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel  PuanlayanUcretPersonel on PuanlayanUcretPersonel.Id = [PerformansHareketler].PuanlayanUcretPersonelId 
  left join PuanTanitimi  on PuanTanitimi.Id = [PerformansHareketler].PuanTanitimiId 
  left join MarkaCiroOran  on MarkaCiroOran.Id = OrganizasyonSemasi.MarkaCiroOranId 
  left join PerformansSablonu on PerformansSablonu.FirmalarId = [PerformansHareketler].FirmalarId and 
								 PerformansSablonu.PerformansDonemiId = [PerformansHareketler].PerformansDonemiId and	
								 PerformansSablonu.OrganizasyonSemasiId = [PerformansHareketler].OrganizasyonSemasiId and	
								 PerformansSablonu.PerformansAnaHedefleriId = [PerformansHareketler].PerformansAnaHedefleriId and	 
								 PerformansSablonu.PuanlayanOrganizasyonSemasiId = [PerformansHareketler].PuanlayanOrganizasyonSemasiId  	
  where [PerformansHareketler].[RowDeleted] = '0' --AND UcretPersonel.Adi like 'volk%'
  and PerformansSablonu.Id is null and [PerformansHareketler].Id is not null)