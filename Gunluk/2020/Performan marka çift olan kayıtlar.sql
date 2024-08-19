
declare @OrganizasyonSemasiId int
declare @PuanlayanPersonelId int
declare @PuanlayanOrganizasyonSemasiId int
declare @KalanReferans int 


--select * from BORDRODB.[dbo].HE_PERSONEL_SICIL_001 JPER  
DECLARE processes CURSOR FOR




select -- top 10
--OrganizasyonSemasi.PozisyonAdi,
PerformansSablonu.OrganizasyonSemasiId 
--PuanlayanOrgSemasi.PozisyonAdi as PuanlayanPozisyon
--PuanlayanPersonel.Adi + ' ' + PuanlayanPersonel.Soyadi as PuanlayanAdiSoyadi
,PuanlayanPersonel.Id as PuanlayanPersonelId
--,PuanlayanOrganizasyonSemasiId
--,count(PuanlayanOrganizasyonSemasiId)
 from PerformansSablonu
  
left join OrganizasyonSemasi on OrganizasyonSemasi.Id = OrganizasyonSemasiId
left join OrganizasyonSemasi PuanlayanOrgSemasi on PuanlayanOrgSemasi.Id = PuanlayanOrganizasyonSemasiId
left join UcretPersonel PuanlayanPersonel on PuanlayanOrgSemasi.UcretPersonelId = PuanlayanPersonel.Id
where 
PerformansSablonu.FirmalarId = 4 and 
PerformansAnaHedefleriId = 3 and PuanlayanPersonel.Adi is not null
--and not(PuanlayanOrgSemasi.PozisyonAdi like '%müdür%' or PuanlayanOrgSemasi.PozisyonAdi like '%þef%' or PuanlayanOrgSemasi.PozisyonAdi like '%sor%' )

group by PerformansSablonu.OrganizasyonSemasiId,OrganizasyonSemasi.PozisyonAdi,PuanlayanPersonel.Adi ,PuanlayanPersonel.Soyadi
,PuanlayanPersonel.Id 
having  count(PuanlayanOrganizasyonSemasiId)>1
OPEN processes
FETCH NEXT FROM processes
INTO 
@OrganizasyonSemasiId,@PuanlayanPersonelId
WHILE @@FETCH_STATUS = 0
BEGIN
       set @KalanReferans=0  
       select top 1 @KalanReferans=Id,@PuanlayanOrganizasyonSemasiId=PuanlayanOrganizasyonSemasiId from VW_PerformansSablonu where OrganizasyonSemasiId = @OrganizasyonSemasiId and PuanlayanPersonelId = @PuanlayanPersonelId and PerformansAnaHedefleriId = 3 order by Agirlik Desc
   	 
	   if (@KalanReferans>0)
	   begin
	        --  delete from PerformansSablonu where Id in (
	          select Id from vw_PerformansSablonu where OrganizasyonSemasiId = @OrganizasyonSemasiId and PuanlayanPersonelId = @PuanlayanPersonelId and PerformansAnaHedefleriId = 3 and Id <> @KalanReferans
			  --)
	   end

FETCH NEXT FROM processes
INTO  @OrganizasyonSemasiId,@PuanlayanPersonelId
END
CLOSE processes
DEALLOCATE processes





/*


select --OrganizasyonSemasi.PozisyonAdi,
PerformansSablonu.OrganizasyonSemasiId,
PuanlayanOrgSemasi.PozisyonAdi as PuanlayanPozisyon
--PuanlayanPersonel.Adi + ' ' + PuanlayanPersonel.Soyadi as PuanlayanAdiSoyadi
,PuanlayanPersonel.Id as PuanlayanPersonelId
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
,PuanlayanPersonel.Id 
having  count(PuanlayanOrganizasyonSemasiId)>1


select* from VW_PerformansSablonu where OrganizasyonSemasiId = 1093 and PuanlayanPersonelId = 375 and PerformansAnaHedefleriId = 3

*/