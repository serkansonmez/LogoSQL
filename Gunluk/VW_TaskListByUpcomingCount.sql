create view VW_TaskListByUpcomingCount as 
select   VW_TaskResponsibleIdList.ResponsibleId,count( VW_TaskResponsibleIdList.ResponsibleId) as BekleyenTaskSayisi  from TaskList
left join VW_TaskResponsibleIdList on VW_TaskResponsibleIdList.TaskId = TaskList.Id
where Country is null and RowDeleted = '0' and TaskStatusId=3 and VW_TaskResponsibleIdList.ResponsibleId<1000000 and
DeadLine<Dateadd(dd,7,getdate())
group by VW_TaskResponsibleIdList.ResponsibleId 