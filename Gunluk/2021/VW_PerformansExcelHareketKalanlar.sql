USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_PerformansExcelHareketSeviye2Seviye2]    Script Date: 20.09.2021 07:06:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--select * from [VW_PerformansExcelHareketKalanlar]
 create View [dbo].[VW_PerformansExcelHareketKalanlar] as
 select VW_PerformansExcelHareketSeviye2.* from VW_PerformansExcelHareketSeviye2 
LEFT join VW_PerformansExcelHareketSeviye2 altSeviye on  
															altSeviye.PuanlananUcretPersonelId = VW_PerformansExcelHareketSeviye2.PuanlananUcretPersonelId and
															 
															altSeviye.AltPuanDurum  = 'Puan Gidiyor'
LEFT join VW_PerformansExcelHareketSeviye2 ustSeviye on 

															ustSeviye.PuanlananUcretPersonelId = VW_PerformansExcelHareketSeviye2.PuanlananUcretPersonelId and
															 
															ustSeviye.UstPuanDurum  = 'Puan Gidiyor'

 where --VW_PerformansExcelHareketSeviye2.AdiSoyadi like 'volkan%'		AND		
 altSeviye.PuanlananUcretPersonelId is  null		AND		ustSeviye.PuanlananUcretPersonelId is  null							 
	 
