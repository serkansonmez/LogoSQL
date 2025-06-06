USE [SuperIk_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_PerformansHareketlerAnaHedefliInsert]    Script Date: 27.07.2020 12:59:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM OrganizasyonSemasi
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

DECLARE processes CURSOR FOR

SELECT  OrganizasyonSemasi.Id,UnvanlarId,SubelerId,UcretPersonelId,PerformansAnaHedefleri.Id from OrganizasyonSemasi 
left join PerformansAnaHedefleri on PerformansAnaHedefleri.AltHedeflerAktif ='0' and PerformansAnaHedefleri.AlternatifTabloAdi='Subeler'
left join Subeler on SubelerId = Subeler.Id
where OrganizasyonSemasi.FirmalarId=@FirmalarId and PerformansAnaHedefleri.Id is not null
and PozisyonAdi <> UPPER(PozisyonAdi) COLLATE Latin1_General_CS_AS  and Subeler.DegerlendirmeYapilmayacak='0'

OPEN processes
FETCH NEXT FROM processes
INTO @OrganizasyonSemasiId,@UnvanlarId,@SubelerId,@UcretPersonelId,@PerformansAnaHedefleriId
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
	  from Subeler 
	  left join PerformansHareketlerAnaHedefli on PerformansHareketlerAnaHedefli.SubeMarkaId =Subeler.Id and PerformansHareketlerAnaHedefli.PerformansDonemiId = @PerformansDonemiId and  PerformansHareketlerAnaHedefli.PerformansAnaHedefleriId = @PerformansAnaHedefleriId and  PerformansHareketlerAnaHedefli.FirmalarId = @FirmalarId and PerformansHareketlerAnaHedefli.PuanlayanOrganizasyonSemasiId = @OrganizasyonSemasiId
	  where Subeler.Id <> @SubelerId and PerformansHareketlerAnaHedefli.Id is  null
	FETCH NEXT FROM processes
	INTO  @OrganizasyonSemasiId,@UnvanlarId,@SubelerId,@UcretPersonelId,@PerformansAnaHedefleriId
END


CLOSE processes
DEALLOCATE processes

end