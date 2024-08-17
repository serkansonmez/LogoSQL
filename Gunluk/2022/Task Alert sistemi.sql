--SELECT * FROM VW_TaskList where RowDeleted = '0'

--Assigned
select ResponsibleId,count(responsibleId) as Sayac,Kullanicilar.AdiSoyadi,Kullanicilar.EMail   from VW_TaskResponsibleIdList
left join TaskList ON TaskList.Id = VW_TaskResponsibleIdList.TaskId
left join Kullanicilar ON Kullanicilar.id = VW_TaskResponsibleIdList.ResponsibleId
where TaskList.RowDeleted = '0' and   DepartmanAdi is null and TaskList.TaskStatusId = 3
group by ResponsibleId,Kullanicilar.AdiSoyadi  ,Kullanicilar.EMail 


select VW_TaskList.Id,VW_TaskList.To_ as From_,VW_TaskList.ResponsiblePersons ,DeadLine,PriorityType,Subject_,Description_,AppId from VW_TaskResponsibleIdList
left join VW_TaskList ON VW_TaskList.Id = VW_TaskResponsibleIdList.TaskId
where VW_TaskList.RowDeleted = '0' and VW_TaskResponsibleIdList.ResponsibleId = 32
order by DeadLine

-- My Tasks
select RowUpdatedBy,count(RowUpdatedBy) as Sayac  from TaskList
where TaskList.RowDeleted = '0' and TaskList.TaskStatusId = 3
group by TaskList.RowUpdatedBy


select VW_TaskList.Id,VW_TaskList.To_ as From_,VW_TaskList.ResponsiblePersons ,DeadLine,PriorityType,Subject_,Description_,AppId  from VW_TaskList
where RowDeleted = '0' and TaskStatusId = 3 and RowUpdatedBy =32 
order by DeadLine
 