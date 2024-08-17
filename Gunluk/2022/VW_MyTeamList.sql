declare @UserId int = 71
declare @ResponsibleId int = 32

create view VW_MyTeamList as 
 
select VW_TaskResponsibleIdList.TaskId,VW_TaskResponsibleIdList.ResponsibleId ,[TaskList].Subject_ ,Kullanicilar.AdiSoyadi as ResponsiblePerson from VW_TaskResponsibleIdList 
left join [TaskList] on [TaskList].Id = VW_TaskResponsibleIdList.TaskId
left join Kullanicilar on Kullanicilar.id = VW_TaskResponsibleIdList.ResponsibleId
where [TaskList].[RowDeleted] = '0' and [TaskList].TaskStatusId = 3 and
  (VW_TaskResponsibleIdList.ResponsibleId  in  (select YetkiTableId from Kullanici_Yetkileri where YetkiTurleriId = 19 and KullaniciId =  71 and YetkiTableId <> 71)  )
  and VW_TaskResponsibleIdList.ResponsibleId  =32 
   