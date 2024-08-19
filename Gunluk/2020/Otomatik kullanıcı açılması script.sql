  --select * from Kullanicilar  UNION ALL
insert into Kullanicilar
SELECT  
       0 [RowVersion]
      ,'0' [RowDeleted]
      ,getdate() [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Adi))) + '.' +  
dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Soyadi)))  as [Kodu]
      ,Adi + ' ' + Soyadi as [AdiSoyadi]
      ,'12345' [Parola]
      ,'1' [Aktif]
      ,'0' [ParolaDegistirmeli]
      ,dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Adi))) + '.' +  
dbo.ufn_TurkishToEnglish(dbo.ufn_CamelCase(dbo.ufn_SplitName(Soyadi))) + '@krcelektromarket.com.tr' [EMail]
      ,null [ParolaHash]
      ,0 AS [GsmNo]
      ,'Turkcell' [GsmOperator]
      ,[TcKimlikNo]
      ,'-' [EmailUser]
      ,'-' [EmailPassword]
      ,4 [FirmalarId]
      ,2 [FirmaYetkiSeviyesiId]
  FROM [dbo].UcretPersonel where Adi is not null
GO


