USE [BORDROPLUS_DB]
GO

SELECT [PERSONELDURUMU]
      ,[LREF]
      ,[SicilNo]
      ,[Adi]
      ,[Soyadi]
  --    ,[GrubaGirisTarihi]
       
      
   
     -- ,CAST([DogumTarihi] AS varchar(200)
     ,  FORMAT ([DogumTarihi], 'dd/MM/yyyy ') [DogumTarihi]
  FROM [dbo].[VW_GUNCEL_SICIL_LISTESI] where PERSONELDURUMU= 'AKTÝF ÇALIÞAN'

GO


