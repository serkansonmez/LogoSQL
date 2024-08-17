USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansHareketlerSeviye2Listesi]    Script Date: 20.09.2021 06:55:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create view [dbo].[VW_PerformansExcelHareketSeviye2] as
 
 
SELECT PuanlananPersonelAdi,PuanlananUcretPersonelId, avg(Puan * 1.00) Ortalama , min(Puan * 1.00) as EnAlt, Max(Puan * 1.00) as EnUst
,avg(Puan * 1.00) - 15 as EnAltFarki, 
min(Puan * 1.00) - (avg(Puan * 1.00) - 15) as AltPuanDurumDeger,
case when min(Puan * 1.00)>avg(Puan * 1.00) - 15 then 'Puan Kalýyor' else 'Puan Gidiyor' end AltPuanDurum
,avg(Puan * 1.00) + 15 as EnUstFarki, 
avg(Puan * 1.00) + 15 - max(Puan * 1.00) as UstPuanDurumDeger,
case when avg(Puan * 1.00) + 15 > max(Puan * 1.00) then 'Puan Kalýyor' else 'Puan Gidiyor' end UstPuanDurum
FROM   VW_PerformansExcelHareketIcmali
 -- where AdiSoyadi like 'volkan%'  
 group by PuanlananPersonelAdi,PuanlananUcretPersonelId
 having   avg(Puan * 1.00)  > 0
 

GO


