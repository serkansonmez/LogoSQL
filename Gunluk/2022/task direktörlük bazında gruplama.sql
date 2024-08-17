declare @UserId int =32
declare @AramaMetni varchar(30) = '%%'
DECLARE @StatusType varchar(30) = 'In Progress'
declare @IlkTarih datetime  = '20220301'
declare @SonTarih datetime  = '20220430'

select  VW_DokumanDepartmanKodlari.Id as DepartmanId, VW_DokumanDepartmanKodlari.DepartmanAdi,count(DepartmanAdi) as Sayi from VW_TaskResponsibleIdList 
left join TaskList on TaskList.Id = VW_TaskResponsibleIdList.TaskId
left join VW_DokumanDepartmanKodlari on  VW_DokumanDepartmanKodlari.UyelerId =  VW_TaskResponsibleIdList.ResponsibleId 
where ResponsibleId<100000
  and [TaskList].[RowDeleted] = '0' and ([TaskList].RowUpdatedBy  in  (select YetkiTableId from Kullanici_Yetkileri where YetkiTurleriId = 19 and KullaniciId = @UserId and YetkiTableId <> @UserId) and VW_TaskResponsibleIdList.ResponsibleId in (select YetkiTableId from Kullanici_Yetkileri where YetkiTurleriId = 19 and KullaniciId = @UserId and YetkiTableId <> @UserId) )
--and (prg.Comment like @AramaMetni or [Subject_] like @AramaMetni or [Description_] like @AramaMetni  ) and TaskStatus.StatusType=@StatusType and cast([DateInitiated] as date) BETWEEN cast(@IlkTarih as date) and cast( @SonTarih as date)
 group by VW_DokumanDepartmanKodlari.Id  , VW_DokumanDepartmanKodlari.DepartmanAdi
--order by TaskId

--select * from VW_DokumanDepartmanKodlari
--select * from TaskList where Id in (142)

--select * from Kullanicilar where id in (358)