USE [SuperIk_DB]
GO

/****** Object:  StoredProcedure [dbo].[SP_OnayIslemleriInsert]    Script Date: 12.10.2020 14:29:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

ALTER PROCEDURE [dbo].[SP_OnayIslemleriInsert] 
( @FirmaKodu int, @OnayMekanizmaId int, @OnayDokumanId int)
as
/*
--Parametreler
DECLARE @FirmaKodu INT
DECLARE @OnayMekanizmaId INT
DECLARE @OnayDokumanId INT
Set @FirmaKodu=106
Set @OnayMekanizmaId=1
Set @OnayDokumanId=1
*/
DECLARE @AdimSiraNo INT 
DECLARE @OnaylayanGrubuId INT
DECLARE @OnayMekanizmaAdimlariId INT

DECLARE pro037 CURSOR FOR
SELECT 
       [AdimSiraNo]
      ,[OnaylayanGrubuId],id
  FROM [OnayMekanizmaAdimlari] WHERE --FirmaKodu = @FirmaKodu and 
  OnayMekanizmaId=@OnayMekanizmaId

OPEN pro037
FETCH NEXT FROM pro037
INTO @AdimSiraNo,@OnaylayanGrubuId,@OnayMekanizmaAdimlariId
WHILE @@FETCH_STATUS = 0
BEGIN
   INSERT INTO [OnayIslemleri]
           ([OnayDokumanId]
           ,[DokumanTakipNo]
           ,[OnayMekanizmaId]
           ,[AdimSiraNo]
           ,[DurumKodu]
           ,[KaydedenKullaniciId]
           ,[Aciklama]
           ,[Tarih]
           ,OnayMekanizmaAdimlariId
           ,BankaTemsilcisiId
           ,DeadlineDate)
     VALUES
           (@OnayDokumanId
           ,0
           ,@OnayMekanizmaId
           ,@AdimSiraNo
           ,'BEK'
           ,0
           ,NULL
           ,NULL
           ,@OnayMekanizmaAdimlariId
           ,0
           ,NULL)


FETCH NEXT FROM pro037
INTO  @AdimSiraNo,@OnaylayanGrubuId,@OnayMekanizmaAdimlariId
END
CLOSE pro037
DEALLOCATE pro037






 



GO


