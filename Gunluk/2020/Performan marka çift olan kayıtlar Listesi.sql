
select --OrganizasyonSemasi.PozisyonAdi,
--PerformansSablonu.OrganizasyonSemasiId,
PuanlayanOrgSemasi.PozisyonAdi as PuanlayanPozisyon,
 PuanlayanPersonel.Adi + ' ' + PuanlayanPersonel.Soyadi as PuanlayanAdiSoyadi,
PuanlayanPersonel.Id as PuanlayanPersonelId
--,PuanlayanOrganizasyonSemasiId
 ,count(PuanlayanOrganizasyonSemasiId)
 from PerformansSablonu
  
left join OrganizasyonSemasi on OrganizasyonSemasi.Id = OrganizasyonSemasiId
left join OrganizasyonSemasi PuanlayanOrgSemasi on PuanlayanOrgSemasi.Id = PuanlayanOrganizasyonSemasiId
left join UcretPersonel PuanlayanPersonel on PuanlayanOrgSemasi.UcretPersonelId = PuanlayanPersonel.Id
where 
PerformansSablonu.FirmalarId = 4 and 
PerformansAnaHedefleriId = 3 and PuanlayanPersonel.Adi is not null
and not(PuanlayanOrgSemasi.PozisyonAdi like '%müdür%' or PuanlayanOrgSemasi.PozisyonAdi like '%þef%' or PuanlayanOrgSemasi.PozisyonAdi like '%sor%' )

group by PerformansSablonu.OrganizasyonSemasiId,OrganizasyonSemasi.PozisyonAdi,PuanlayanPersonel.Adi ,PuanlayanPersonel.Soyadi
,PuanlayanPersonel.Id ,PuanlayanOrgSemasi.PozisyonAdi 
having  count(PuanlayanOrganizasyonSemasiId)>1