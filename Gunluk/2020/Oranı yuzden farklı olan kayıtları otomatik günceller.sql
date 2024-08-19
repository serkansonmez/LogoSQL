declare @FirmalarId int
declare @PerformansDonemiId int
declare @OrganizasyonSemasiId int
declare @PerformansAnaHedefleriId int
declare @Toplam float
declare @Adet float

declare @PuanlayanPersonelId int
declare @PuanlayanOrganizasyonSemasiId int
declare @KalanReferans int 

declare @YeniOran float

--select * from BORDRODB.[dbo].HE_PERSONEL_SICIL_001 JPER  
DECLARE processes CURSOR FOR


select   FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,round(sum(Agirlik),2),count(Agirlik) from 
PerformansSablonu 
where PerformansAnaHedefleriId = 3
group by FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId 
having round(sum(Agirlik),2)<>100


OPEN processes
FETCH NEXT FROM processes
INTO 
@FirmalarId,@PerformansDonemiId,@OrganizasyonSemasiId,@PerformansAnaHedefleriId,@Toplam,@Adet
WHILE @@FETCH_STATUS = 0
BEGIN
       set @YeniOran = 100 / @Adet
	   update PerformansSablonu set Agirlik = @YeniOran where Id in (

       select Id from PerformansSablonu where FirmalarId= @FirmalarId and PerformansDonemiId=@PerformansDonemiId
	   and  OrganizasyonSemasiId=@OrganizasyonSemasiId and PerformansAnaHedefleriId=@PerformansAnaHedefleriId)

FETCH NEXT FROM processes
INTO  @FirmalarId,@PerformansDonemiId,@OrganizasyonSemasiId,@PerformansAnaHedefleriId,@Toplam,@Adet
END
CLOSE processes
DEALLOCATE processes





/*


select FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId,round(sum(Agirlik),2),count(Agirlik) from 
PerformansSablonu 
where PerformansAnaHedefleriId = 3
group by FirmalarId,PerformansDonemiId,OrganizasyonSemasiId,PerformansAnaHedefleriId 
having round(sum(Agirlik),2)<>100

*/