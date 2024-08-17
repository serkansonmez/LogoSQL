USE [GINSOFT_NET_PROD]
GO

/****** Object:  View [dbo].[VW_TaskIcmalListesi]    Script Date: 2.02.2022 22:00:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--select * from Kullanicilar where id = 371
--select * from [VW_TaskIcmalListesi] where RowUpdatedBy = 371

 ALTER View [dbo].[VW_TaskIcmalListesi] AS 

select 'Itself' as Initiator, Kullanicilar.id as RowUpdatedBy,StatusType, count(TaskList.Id) AS Sayac from    TaskStatus,Kullanicilar
left join TaskList   on Kullanicilar.id = TaskList.RowUpdatedBy
--left join TaskStatus    on   TaskStatus.Id = TaskStatusId 
where Kullanicilar.Aktif = 1
group by Kullanicilar.id,StatusType

UNION ALL



select 'Assigned' as Initiator, Kullanicilar.id as ResponsibleId,StatusType, count(TaskList.Id) AS Sayac  from TaskStatus,Kullanicilar,VW_TaskResponsibleIdList
left join TaskList on     TaskList.Id = VW_TaskResponsibleIdList.TaskId    --Kullanicilar.id = TaskList.RowUpdatedBy --and
--left join TaskStatus on TaskStatus.Id = TaskStatusId
where   TaskStatus.Id is not null and TaskList.RowUpdatedBy > 0 and Kullanicilar.Aktif = 1
group by Kullanicilar.id,StatusType 
GO


