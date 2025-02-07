USE [SuperIk_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_PerformansHareketlerAnaHedefliInsert]    Script Date: 15.09.2020 22:06:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SELECT PuanlayanUcretPersonelId,COUNT(*) FROM PerformansHareketlerAnaHedefli
--GROUP BY PuanlayanUcretPersonelId
--exec [SP_PerformansHareketlerAnaHedefliInsert] 1,4,1
--select * from PerformansHareketlerAnaHedefli where puanlayanUcretPersonelId  = 507
ALTER PROCEDURE [dbo].[SP_PerformansHareketlerAnaHedefliInsert] 
 ( @UserId int, @FirmalarId int, @PerformansDonemiId int)
as
begin
--declare @FirmalarId  int =4
declare @DonemKodu varchar(2)
 
declare @OrganizasyonSemasiId  int  
declare @UnvanlarId  int 
declare @SubelerId  int 
declare @UcretPersonelId  int 
--declare @PerformansDonemiId  int =1
declare @PerformansAnaHedefleriId int 
declare @strSQL nvarchar(max) 

DECLARE processes CURSOR FOR

SELECT    OrganizasyonSemasi.Id, SubelerId,UcretPersonelId,PerformansAnaHedefleri.Id from OrganizasyonSemasi 
left join PerformansAnaHedefleri on PerformansAnaHedefleri.AltHedeflerAktif ='0' and PerformansAnaHedefleri.AlternatifTabloAdi='Subeler'
left join Subeler on SubelerId = Subeler.Id
where OrganizasyonSemasi.FirmalarId=4 and PerformansAnaHedefleri.Id is not null --and OrganizasyonSemasi.Id = 1123
and PozisyonAdi <> UPPER(PozisyonAdi) COLLATE Latin1_General_CS_AS  and Subeler.DegerlendirmeYapilmayacak='0' 

OPEN processes
FETCH NEXT FROM processes
INTO @OrganizasyonSemasiId, @SubelerId,@UcretPersonelId,@PerformansAnaHedefleriId
WHILE @@FETCH_STATUS = 0
BEGIN
    
	  insert into PerformansHareketlerAnaHedefli
	SELECT  '0' as [RowDeleted]
      ,getdate() [RowUpdatedTime]
      ,@UserId [RowUpdatedBy]
      ,@FirmalarId  [FirmalarId]
      ,@PerformansDonemiId as [PerformansDonemiId]
      ,@PerformansAnaHedefleriId as [PerformansAnaHedefleriId]
      ,Subeler.Id [SubeMarkaId]
      ,@OrganizasyonSemasiId [PuanlayanOrganizasyonSemasiId]
      ,@UcretPersonelId [PuanlayanUcretPersonelId]
      ,0 [PuanTanitimiId]
      ,null [PuanlamaTarihi]
	  ,null as Yorum
	  ,'1' as AktifPasif
	  from Subeler 
	  left join PerformansHareketlerAnaHedefli on 
	  PerformansHareketlerAnaHedefli.SubeMarkaId =Subeler.Id and 
	  PerformansHareketlerAnaHedefli.PerformansDonemiId = @PerformansDonemiId and  
	  PerformansHareketlerAnaHedefli.PerformansAnaHedefleriId = @PerformansAnaHedefleriId and  
	  PerformansHareketlerAnaHedefli.FirmalarId = @FirmalarId and 
	  PerformansHareketlerAnaHedefli.PuanlayanOrganizasyonSemasiId = @OrganizasyonSemasiId
	  where Subeler.Id <> @SubelerId and PerformansHareketlerAnaHedefli.Id is  null
	FETCH NEXT FROM processes
	INTO  @OrganizasyonSemasiId, @SubelerId,@UcretPersonelId,@PerformansAnaHedefleriId
END


CLOSE processes
DEALLOCATE processes
-- Personeli değişen kayıtlardan

DECLARE prcs1 CURSOR FOR

	  select PerformansHareketlerAnaHedefli.Id,OrganizasyonSemasi.UcretPersonelId  from PerformansHareketlerAnaHedefli 
	  left join OrganizasyonSemasi on OrganizasyonSemasi.Id = PerformansHareketlerAnaHedefli.PuanlayanOrganizasyonSemasiId 
	  where OrganizasyonSemasi.UcretPersonelId <> PerformansHareketlerAnaHedefli.PuanlayanUcretPersonelId

OPEN prcs1
FETCH NEXT FROM prcs1
INTO  @PerformansAnaHedefleriId,@UcretPersonelId
WHILE @@FETCH_STATUS = 0
BEGIN
       set @strSQL = 'update PerformansHareketlerAnaHedefli set PuanlayanUcretPersonelId=' + CAST( @UcretPersonelId as varchar(20)) + ' where Id =' + CAST( @PerformansAnaHedefleriId as varchar(20))
	     EXEC (@strSQL)
	FETCH NEXT FROM prcs1
	INTO  @PerformansAnaHedefleriId,@UcretPersonelId
END


CLOSE prcs1
DEALLOCATE prcs1
--3. bir şekilde bağlantısı kopan organizasyon bağlantıları iptal ediliyor.
delete from PerformansHareketlerAnaHedefli where Id in (
select PerformansHareketlerAnaHedefli.Id from PerformansHareketlerAnaHedefli  
left join OrganizasyonSemasi on OrganizasyonSemasi.Id = PerformansHareketlerAnaHedefli.PuanlayanOrganizasyonSemasiId
 where OrganizasyonSemasi.Id is null)


end