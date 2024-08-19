 

create View [dbo].[VW_YillikIzinHakedisListesi] as
select  Id as UcretPersonelId, GirisTarihi,
DATEDIFF(YY,GirisTarihi,GETDATE()) as GecenYil,
case 
     when DATEDIFF(YY,GirisTarihi,GETDATE())>=1 and DATEDIFF(YY,GirisTarihi,GETDATE())<6 then 14
	 when DATEDIFF(YY,GirisTarihi,GETDATE())>5 and DATEDIFF(YY,GirisTarihi,GETDATE())<15 then 20
	 when DATEDIFF(YY,GirisTarihi,GETDATE())>=15 then 26
else 0 end hakedisIzinGunu,
datefromparts(year(GETDATE()),MONTH(GirisTarihi),DAY(GirisTarihi)) as GerceklesecekTarih 
 from UcretPersonel
 where GirisTarihi is not null
GO


