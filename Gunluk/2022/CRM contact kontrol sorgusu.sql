SELECT 
T0.[DestekTalepleriId] AS [DestekTalepleriId],
T0.[RowUpdatedTime] AS [RowUpdatedTime],
T0.[UserId] AS [UserId],
T0.[TalepTarihi] AS [TalepTarihi],
T0.[DestekDurumKodlariId] AS [DestekDurumKodlariId],
T0.[CustomerID] AS [CustomerId],
T0.[CustomerContactId] AS [CustomerContactId],
T0.[DestekKonu] AS [DestekKonu],
T0.[DosyaEki1] AS [DosyaEki1],
T0.[DosyaEki2] AS [DosyaEki2],
T0.[DosyaEki3] AS [DosyaEki3],
jUser.[Username] AS [UserUsername],
jDestekDurumKodlari.[DurumAdi] AS [DestekDurumKodlariDurumAdi],
jCustomer.[CompanyName] AS [CustomerCompanyName],
jCustomerContact.[ContactName] AS [CustomerContactContactName] 
FROM [dbo].[DestekTalepleri] T0 
LEFT JOIN [dbo].[Users] jUser ON (jUser.[UserId] = T0.[UserId]) 
LEFT JOIN [dbo].[DestekDurumKodlari] jDestekDurumKodlari ON (jDestekDurumKodlari.[DestekDurumKodlariId] = T0.[DestekDurumKodlariId]) 
LEFT JOIN [dbo].[Customers] jCustomer ON (jCustomer.[CustomerID] = T0.[CustomerID]) 
LEFT JOIN [dbo].[CustomerContact] jCustomerContact ON (jCustomerContact.[CustomerContactId] = T0.[CustomerContactId]) 
WHERE  T0.[CustomerID] = 'C1332'

SELECT * FROM Users where [CustomerID] = 'C1332'

SELECT DISTINCT 
fld.[CustomerID] AS [CustomerID],
fld.[CustomerContactId] AS [CustomerContactId],
fld.[ContactName] AS [ContactName] 
FROM [dbo].[CustomerContact] T0, [dbo].[CustomerContact] fld 
WHERE  T0.[CustomerID] = 'C1332' and T0.[CustomerID] = fld.CustomerID AND  substring( fld.ContactName,1,4) like '%Büþr%'