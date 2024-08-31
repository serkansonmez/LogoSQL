USE [AltinCezveB2B_Default_v1]
GO

SELECT [Id]
      ,[Tarih]
      ,[CrossOrder]
      ,[Kod]
      ,[CurrencyCode]
      ,[UNIT]
      ,[Isim]
      ,[CurrencyName]
      ,[ForexBuying]
      ,[ForexSelling]
      ,[BanknoteBuying]
      ,[BanknoteSelling]
  FROM [dbo].[DovizKurlari]

GO
WITH CTE AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Tarih, CrossOrder) AS NewId,
        [Id]
    FROM [dbo].[DovizKurlari]
)
UPDATE CTE
SET Id = NewId;

