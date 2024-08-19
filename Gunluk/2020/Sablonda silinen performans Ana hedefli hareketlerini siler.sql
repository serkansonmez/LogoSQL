delete from [PerformansHareketlerAnaHedefli] where Id in (
SELECT [PerformansHareketlerAnaHedefli].[Id] 
 
  FROM [dbo].[PerformansHareketlerAnaHedefli]
  left join Kullanicilar Kaydeden on Kaydeden.Id = [PerformansHareketlerAnaHedefli].[RowUpdatedBy] 
  left join Firmalar  on Firmalar.Id = [PerformansHareketlerAnaHedefli].FirmalarId 
  left join PerformansDonemleri  on PerformansDonemleri.Id = [PerformansHareketlerAnaHedefli].[PerformansDonemiId] 
 
  left join [PerformansAnaHedefleri]  on [PerformansAnaHedefleri].Id = [PerformansHareketlerAnaHedefli].[PerformansAnaHedefleriId] 
 
  left join OrganizasyonSemasi PuanlayanOrganizasyonSemasi  on PuanlayanOrganizasyonSemasi.Id = [PerformansHareketlerAnaHedefli].PuanlayanOrganizasyonSemasiId 
  left join UcretPersonel  PuanlayanUcretPersonel on PuanlayanUcretPersonel.Id = [PerformansHareketlerAnaHedefli].PuanlayanUcretPersonelId 
  left join PuanTanitimi  on PuanTanitimi.Id = [PerformansHareketlerAnaHedefli].PuanTanitimiId 
  
  left join PerformansSablonu on PerformansSablonu.FirmalarId = [PerformansHareketlerAnaHedefli].FirmalarId and 
								 PerformansSablonu.PerformansDonemiId = [PerformansHareketlerAnaHedefli].PerformansDonemiId and	
						
								 PerformansSablonu.PerformansAnaHedefleriId = [PerformansHareketlerAnaHedefli].PerformansAnaHedefleriId and	 
								 PerformansSablonu.PuanlayanOrganizasyonSemasiId = [PerformansHareketlerAnaHedefli].PuanlayanOrganizasyonSemasiId  	
  where [PerformansHareketlerAnaHedefli].[RowDeleted] = '0' --AND UcretPersonel.Adi like 'volk%'
  and PerformansSablonu.Id is null and [PerformansHareketlerAnaHedefli].Id is not null)