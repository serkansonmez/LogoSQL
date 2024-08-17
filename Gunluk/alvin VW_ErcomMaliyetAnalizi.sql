USE [AlvinB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_ErcomMaliyetAnalizi]    Script Date: 30.01.2024 13:05:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






--select * from [VW_ErcomMaliyetAnalizi] where Id = 34588


 --ALTER view [dbo].[VW_ErcomMaliyetAnalizi] as 
SELECT DISTINCT [ErcomMaliyetAnalizi].[Id]
      ,[ErcomMaliyetAnalizi].[UserId]
      ,[RowUpdatedTime]
      ,[TeklifTarihi]
      ,[TeklifSiparisNo]
      ,[MusterilerId]
      ,[ErcomStokId]
      ,[Miktar]
      ,[Birim]
      ,[BirimKg]
      ,[ToplamKg]
      ,[BirimFiyat]
      ,[ToplamFiyat]
      ,[KdvTutar]
      ,[MusteriKodu]
	  ,ErcomStok.StokKodu
	  ,ErcomStok.StokAdi
	  ,Users.DisplayName as AktaranKullanici
	  ,[ErcomMaliyetAnalizi].PozNo
	  ,   ErcomSiparis.CARIUNVAN
	  ,TeklifNo
	  ,case when AktifPasif =0 then 'Pasif' else case when KabanSiparisleri.DosyaTarihi is not null THEN 'Üretildi' else 'Beklemede' end end as UretimDurumu
	  ,KabanSiparisleri.DosyaTarihi as UretimTarihi
	  ,ZirveDonem
	  ,ZirveIrsaliyeRef
	  ,ZirveIrsaliyeAltRef
	   ,ZirveSarfFisNo
	   ,year(teklifTarihi) as TeklifYil
	   ,month(teklifTarihi) as TeklifAy
	   ,year(KabanSiparisleri.DosyaTarihi) as UretimYil
	   ,month(KabanSiparisleri.DosyaTarihi) as UretimAy
	  ,TedarikciFirma.FirmaAdi as TedarikciFirmaAdi
	  ,ErcomSiparis.TedarikciFirmaId
  FROM [dbo].[ErcomMaliyetAnalizi]  with(nolock)

left join ErcomStok with(nolock) on [ErcomMaliyetAnalizi].ErcomStokId = ErcomStok.Id
 left join (SELECT *   FROM ErcomDbSiparis_2023  with(nolock)
            UNION ALL 
			SELECT * FROM ErcomDbSiparis_2024  with(nolock)
			   UNION ALL 
			SELECT * FROM ErcomDbSiparis_2025  with(nolock))      ErcomSiparis on [ErcomMaliyetAnalizi].MusteriKodu = ErcomSiparis.CARIKOD
left join Users with(nolock) on Users.UserId = [ErcomMaliyetAnalizi].[UserId]
left join KabanSiparisleri  with(nolock) on KabanSiparisleri.SiparisNo = [ErcomMaliyetAnalizi].TeklifSiparisNo
left join TedarikciFirma  with(nolock) on TedarikciFirma.Id  = ErcomSiparis.TedarikciFirmaId
and KabanSiparisleri.PozNo = replace( [ErcomMaliyetAnalizi].PozNo,'Poz ','')
 

 --select * from KabanSiparisleri  

-- update ErcomDbSiparis_2023 set TedarikciFirmaId = 1
 --select  * from [ErcomMaliyetAnalizi] where TeklifSiparisNo = 'S301268'

GO


