select sum(q1.Agirlik) from PerformansSablonu q1
            left join PerformansSablonu q2 on q2.FirmalarId = q1.FirmalarId and 
			q2.PerformansDonemiId = q1.PerformansDonemiId and
			q2.OrganizasyonSemasiId = q1.OrganizasyonSemasiId and
			q2.PerformansAnaHedefleriId = q1.PerformansAnaHedefleriId 


select FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,round(sum(Agirlik),2),count(Agirlik) from 
PerformansSablonu 
where PerformansAnaHedefleriId = 3
group by FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId 
having round(sum(Agirlik),2)<>100