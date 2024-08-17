SELECT 
OnaylayacakId ,
DurumKodu ,
Sayi  FROM VW_OnayIcmalListesi WITH (NOLOCK) where OnaylayacakId=32

--Create View VW_TaskIcmalListesi
select 'Itself' as Initiator, RowUpdatedBy,StatusType, count(RowUpdatedBy) AS Sayac from  TaskList   
left join TaskStatus on TaskStatus.Id = TaskStatusId
group by RowUpdatedBy,StatusType

select 'Assigned' as Initiator, TaskProgress.RowUpdatedBy,StatusType, count(TaskProgress.RowUpdatedBy) AS Sayac from VW_TaskProgressResponsibleIdList 
left join TaskProgress on TaskProgress.Id  = VW_TaskProgressResponsibleIdList.TaskProgressId
left join TaskList on TaskList.Id = TaskProgress.TaskListId
left join TaskStatus on TaskStatus.Id = TaskStatusId
where ResponsibleId =32 and TaskStatus.Id is not null and TaskProgress.RowUpdatedBy > 0
group by TaskProgress.RowUpdatedBy,StatusType

--select * from TaskProgress where TaskListId = 95
--select * from TaskList where RowUpdatedBy = 371
--select * from TaskProgress where ResponsiblePersonId = '371'
--update TaskList set TaskStatusId = 3 where TaskStatusId = 0