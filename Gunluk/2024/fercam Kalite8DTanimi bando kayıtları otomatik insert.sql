USE [FercamB2B_Default_v1]
GO

--SELECT * FROM Kalite8DTanimi

insert into Kalite8DTanimi
SELECT DISTINCT getdate() [Tarih]
      ,2 [KullaniciId]
      , ITEMCODE [FercamKodu]
      ,2 [OperasyonTanimiId]
      ,NULL [DosyaYolu]
  FROM [dbo].VW_UretimEmirleriListesi
  LEFT join Kalite8DTanimi on Kalite8DTanimi.FercamKodu COLLATE Turkish_CI_AS = ITEMCODE and [OperasyonTanimiId]=2
  where Kalite8DTanimi.Kalite8DTanimiId is   null
GO


