Create View VW_TaskListByStatusCount as 
select ResponsibleId, sum(NotStarted) as NotStarted,sum(Returned) as Returned, sum(InProgress) as InProgress, sum(Completed) as Completed from
(select   VW_TaskResponsibleIdList.ResponsibleId,count( VW_TaskResponsibleIdList.ResponsibleId) as NotStarted,0 Returned,0 as InProgress,0 as Completed from TaskList
left join VW_TaskResponsibleIdList on VW_TaskResponsibleIdList.TaskId = TaskList.Id
where Country is null and RowDeleted = '0' and TaskStatusId=1
group by  VW_TaskResponsibleIdList.ResponsibleId  
UNION ALL
select   VW_TaskResponsibleIdList.ResponsibleId,0 as NotStarted,count(VW_TaskResponsibleIdList.ResponsibleId) Returned,0 as InProgress,0 as Completed from TaskList
left join VW_TaskResponsibleIdList on VW_TaskResponsibleIdList.TaskId = TaskList.Id
where Country is null and RowDeleted = '0' and TaskStatusId=2
group by  VW_TaskResponsibleIdList.ResponsibleId  
UNION ALL
select   VW_TaskResponsibleIdList.ResponsibleId,0 as NotStarted,0 Returned,count(VW_TaskResponsibleIdList.ResponsibleId) as InProgress,0 as Completed from TaskList
left join VW_TaskResponsibleIdList on VW_TaskResponsibleIdList.TaskId = TaskList.Id
where Country is null and RowDeleted = '0' and TaskStatusId=3
group by  VW_TaskResponsibleIdList.ResponsibleId  
UNION ALL
select   VW_TaskResponsibleIdList.ResponsibleId,0 as NotStarted,0 Returned,0 as InProgress,count(VW_TaskResponsibleIdList.ResponsibleId) as Completed from TaskList
left join VW_TaskResponsibleIdList on VW_TaskResponsibleIdList.TaskId = TaskList.Id
where Country is null and RowDeleted = '0' and TaskStatusId=4
group by  VW_TaskResponsibleIdList.ResponsibleId  ) tbl group by ResponsibleId
having ResponsibleId < 1000000