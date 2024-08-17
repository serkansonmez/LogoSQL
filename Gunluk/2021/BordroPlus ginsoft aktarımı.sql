
--1. Jguar personel Kartlarýnýn otomatik olarak UcretPersonel tablosuna aktarýlmasý
 INSERT INTO [GINSOFT_NET_PROD].[dbo].[UcretPersonel]
select DISTINCT '' [Þema Adý],'' [Ýþyeri Adý],[OzelKod],JPER.[TcKimlikNo],JPER.[Adi],JPER.[Soyadi],[ProjeAdi], 
[IseGirisTarihi],[Ucreti],0,0,[Ucreti],0,0,BirimAdi,LREF,0,LREF, 1,0  from VW_GUNCEL_SICIL_LISTESI JPER   
LEFT JOIN [GINSOFT_NET_PROD].[dbo].[UcretPersonel] UcretPers ON JPER.[TcKimlikNo] COLLATE TURKISH_CI_AS  = UcretPers.TcKimlikNo
where UcretPers.TcKimlikNo is  null  



select * from [GINSOFT_NET_PROD].[dbo].[UcretPersonel] where adi = 'hamza'

update [UcretPersonel] set SicilNo = 71137028212 where ID = 13357 

SELECT * FROM Kullanicilar where Kodu = 'hamzayuksel'