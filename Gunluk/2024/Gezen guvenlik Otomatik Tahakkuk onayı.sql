USE [GezenWeb_Default_v1]
GO

insert into TahakkukOnaylari
SELECT  
       getdate() [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,VW_PersonelTahakkuk.Id as [PersonelTahakkukId]
      ,1 [OnayDurumId]
      ,'Uygundur' [Aciklama]
      ,null [MailGondermeTarihi]
      ,null [MailKime]
      ,null [MailBilgi]
  FROM VW_PersonelTahakkuk
  where Yil >= 2024 and MaasAy = 7
 


