--create view VW_MyTeamGroupList as 

--select * from VW_MyTeamGroupList   
 declare @UserId int = 71

select ResponsibleId,ResponsiblePerson,count(ResponsiblePerson) as Count_ from (
select VW_TaskResponsibleIdList.TaskId,VW_TaskResponsibleIdList.ResponsibleId ,[TaskList].Subject_ ,Kullanicilar.AdiSoyadi as ResponsiblePerson from VW_TaskResponsibleIdList 
left join [TaskList] on [TaskList].Id = VW_TaskResponsibleIdList.TaskId
left join Kullanicilar on Kullanicilar.id = VW_TaskResponsibleIdList.ResponsibleId
where [TaskList].[RowDeleted] = '0' and [TaskList].TaskStatusId = 3 and
  (VW_TaskResponsibleIdList.ResponsibleId  in  (select YetkiTableId from Kullanici_Yetkileri where YetkiTurleriId = 19 and KullaniciId =  @UserId and YetkiTableId <> @UserId)  )

  ) tbl group by ResponsibleId,ResponsiblePerson
-- select * from  TaskStatus 

-- select * from VW_TaskResponsibleIdList