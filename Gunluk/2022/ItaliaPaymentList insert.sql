USE [GINSOFT_NET_PROD]
GO
/*
SELECT  [ItaliaCreditorId]
      ,[ItaliaCompanyId]
      ,[Document ]
      ,[ItaliaInvoiceAdvanceId]
      ,[InvoiceDate]
      ,[InvoiceNumber]
      ,[CreditDescription]
      ,[CreditorBank]
      ,[CreditorIban]
      ,[WitholdingTax]
      ,[InvoiceAmount]
      ,[RouteNumber]
      ,[FirstPayment]
      ,[FirstPaymentDate]
      ,[SecondPayment]
      ,[SecondPaymentDate]
      ,[ThirdPayment]
      ,[ThirdPaymentDate]
      ,[Balance]
      ,[ItaliaPaymentStatusId]
      ,[ItaliaCostCenterId]
      ,[ProjeId]
      ,[Agreement]
      ,[VW_TabloMasrafMerkeziId]
      ,[TotalCost]
      ,[ItaliaPartnerShipId]
      ,[Payer]
      ,[PayerBank]
      ,[Deadline]
      ,[Notes]
  FROM [dbo].[ItaliaPaymentList]

UNION ALL
*/

--select * from [ItaliaPaymentList]


--INSERT INTO [ItaliaPaymentList]
SELECT ItaliaCreditor.Id AS  [ItaliaCreditorId]
      ,ItaliaCompany.Id as [ItaliaCompanyId]
      ,[Document ]
      ,isnull(ItaliaInvoiceAdvance.Id,0) [ItaliaInvoiceAdvanceId]
      ,[InvoiceDate]
      ,[InvoiceNumber]
      ,[CreditDescription]
      ,[Creditor Bank/ Entity]
      ,[Creditor IBAN/ REF CODE]
      ,[Witholding Tax]
      ,[InvoiceAmount]
      ,[RouteNumber]
      ,[FirstPayment]
      ,[FirstPaymentDate]
      ,[SecondPayment]
      ,[SecondPaymentDate]
      ,[ThirdPayment]
      ,[ThirdPaymentDate]
      ,[Balance]
      ,ItaliaPaymentStatus.Id as [ItaliaPaymentStatusId]
      ,ItaliaCostCenter.Id as [ItaliaCostCenterId]
      ,isnull(Proje.Id,0) as [ProjeId]
      ,[Agreement]
      ,VW_TabloMasrafMerkezi.Id as [VW_TabloMasrafMerkeziId]
      ,[TotalCost]
      ,[ItaliaPartnerShip].Id [ItaliaPartnerShipId]
      ,[Payer]
      ,[PayerBank]
      ,[Deadline]
      ,[Notes]


FROM [dbo].[ItaliaPaymentListFinalExcel]
LEFT JOIN ItaliaCreditor ON ItaliaCreditor.Creditor = [ItaliaPaymentListFinalExcel].Creditor
LEFT JOIN ItaliaCompany ON ItaliaCompany.Company = [ItaliaPaymentListFinalExcel].Company
LEFT JOIN ItaliaInvoiceAdvance ON ItaliaInvoiceAdvance.InvoiceAdvance = [ItaliaPaymentListFinalExcel].InvoiceAdvance
LEFT JOIN ItaliaPaymentStatus ON ItaliaPaymentStatus.Status1 = [ItaliaPaymentListFinalExcel].Status1
LEFT JOIN ItaliaCostCenter ON ItaliaCostCenter.CostCenter = [ItaliaPaymentListFinalExcel].CostCenter
LEFT JOIN Proje ON Proje.ProjeAdi = [ItaliaPaymentListFinalExcel].ProjectName
left join VW_TabloMasrafMerkezi on VW_TabloMasrafMerkezi.DetayKod = [ItaliaPaymentListFinalExcel].[Cost Type]
left join [ItaliaPartnerShip] on [ItaliaPartnerShip].PartnerShip = [ItaliaPaymentListFinalExcel].Partnership
where ItaliaCreditor.Id is not null and Proje.Id is not null 

--select * from VW_TabloMasrafMerkezi where MasrafMerkezi like '%STMG%'

--select * from [ItaliaPaymentListFinalExcel] where MasrafMerkezi like '%%'

 


