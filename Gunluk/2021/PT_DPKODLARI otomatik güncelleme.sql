USE [GO3DB]
GO

SELECT [ID]
      ,[FISNO]
      ,[STOKKODU]
      ,[STOKADI]
      ,[DPKODU]
      ,[TEDARIKCI_KODU]
      ,[TEDARIKCI_ADI]
      ,[TEDARIKCI_FTNO]
      ,[ADET]
      ,[URUN_TIPI]
      ,[DPKKODU]
      ,[GRUP_KODU]
      ,[FIS_TARIHI]
      ,[KULLANICI]
      ,[SIPARIS_REFERANS]
  FROM [dbo].[PT_HAZIRLIK_SATIR] where DPKODU = 'DP0002'	

GO
select * from PT_DPKODLARI WHERE MARKA IS NOT NULL

update PT_DPKODLARI set Marka = 'Otomatik' where Marka <> 'Manuel'

