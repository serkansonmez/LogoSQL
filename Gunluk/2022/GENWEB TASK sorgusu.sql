DECLARE @AramaMetni varchar(30) = '%%'
declare @IlkTarih datetime = '20220101'
declare @SonTarih datetime = '20220308'
declare @UserId int = 367
declare @StatusType varchar(20) = 'In Progress'

SELECT DISTINCT [TaskList].[Id]
      ,[TaskList].[RowUpdatedTime]
      ,[TaskList].[RowUpdatedBy]
      ,Kullanicilar.AdiSoyadi as To_
      ,[TaskTypeId]
      ,TaskType.TypeName
      ,[TaskPriorityId]
      ,TaskPriority.PriorityType
      ,[TaskStatusId]
      ,TaskStatus.StatusType
      
      ,[ResponsiblePersonId]
      ,VW_TaskResponsiblePersonList.Persons as ResponsiblePersons
      ,[Subject_]
      ,[Description_]
      ,[DateInitiated]
      ,[DeadLine]
      ,[RevisedDeadLine]
      ,[DoneDate]
      ,[AttachFileName]
      ,[AttachFileDesc]
      ,[SessionId]
      ,[IsActive]
      ,[AppId]
      ,prg.Comment
      ,prg.FeedbackDate
      ,isnull(prg.Percentage,0) as Percentage
       ,VW_TaskResponsiblePersonList.PersonsMail as ResponsiblePersonsMail
       ,Kullanicilar.EMail as To_Email
       ,isnull(prg.Id,0) as ProgressId
       ,DATEDIFF(dd,[DateInitiated], ISNULL([RevisedDeadLine],[DeadLine])) TerminGunSayisi
       ,DATEDIFF(dd,ISNULL([RevisedDeadLine],[DeadLine]), DoneDate) TerminiGecenGunSayisi
       ,isnull(VW_TaskResponsiblePersonCCList.Persons ,'') as ResponsibleCCPersons
       ,isnull(VW_TaskResponsiblePersonCCList.PersonsMail ,'') as ResponsibleCCPersonsMail
       ,TaskList.RowDeleted
  FROM [TaskList] with(nolock)
  left join Kullanicilar with(nolock) on Kullanicilar.id  = [TaskList].[RowUpdatedBy]
  left join TaskType with(nolock) on TaskType.Id  = [TaskList].TaskTypeId
  left join TaskPriority with(nolock) on TaskPriority.Id  = [TaskList].TaskPriorityId
  left join TaskStatus with(nolock) on TaskStatus.Id  = [TaskList].TaskStatusId
  left join VW_TaskResponsiblePersonList on VW_TaskResponsiblePersonList.TaskId = [TaskList].Id

  left join VW_TaskResponsiblePersonCCList on VW_TaskResponsiblePersonCCList.TaskId = [TaskList].Id

  LEFT OUTER JOIN VW_TaskResponsibleIdList ON VW_TaskResponsibleIdList.TaskId = TaskList.Id 
  LEFT OUTER JOIN VW_TaskResponsibleCCIdList	 ON VW_TaskResponsibleCCIdList.TaskId = TaskList.Id 
  LEFT OUTER JOIN VW_TaskProgressForwardIdList ON VW_TaskProgressForwardIdList.TaskProgressId = TaskList.Id 

  LEFT OUTER JOIN (
select Id,TaskListId,Comment,FeedbackDate,Percentage from TaskProgress q1 with(nolock)  where q1.Id in (select top 1 Id from TaskProgress q2 with(nolock) 
where q1.TaskListId =  q2.TaskListId order by FeedbackDate desc)) prg ON prg.TaskListId = TaskList.Id 

  where [TaskList].[RowDeleted] = '0' and ([TaskList].RowUpdatedBy =@UserId or VW_TaskResponsibleIdList.ResponsibleId =@UserId or VW_TaskResponsibleCCIdList.ResponsibleCCId = @UserId or VW_TaskProgressForwardIdList.ForwardId = @UserId)
and (prg.Comment like @AramaMetni or [Subject_] like @AramaMetni or [Description_] like @AramaMetni  ) and TaskStatus.StatusType=@StatusType and cast([DateInitiated] as date) BETWEEN cast(@IlkTarih as date) and cast( @SonTarih as date)
Order By [TaskList].[Id]