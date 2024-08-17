USE [EnaFlow_DB]
GO

SELECT [id]
      ,[OnayMekanizmaId]
      ,[AdimSiraNo]
      ,[OnaylayanGrubuId]
      ,[FirmaKodu]
      ,[Kime]
      ,[Bilgi]
      ,[Gizli]
      ,[SmsGonder]
      ,[Aciklama]
      ,[AktifPasif] 
  FROM [dbo].[OnayMekanizmaAdimlari] where Bilgi = 'bora@enatextile.com'
   

  update [OnayMekanizmaAdimlari]  set Bilgi = 'bora@enatextile.com; ihsan@enatextile.com' where Bilgi = 'bora@enatextile.com'
GO


