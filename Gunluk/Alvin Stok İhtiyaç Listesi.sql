USE [AlvinB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_ErcomMaliyetAnalizi]    Script Date: 19.03.2024 15:01:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













--select * from [VW_ErcomMaliyetAnalizi] where [TeklifSiparisNo] = '1400068'


--CREATE view [dbo].[VW_StokIhtiyacListesi] as 
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
	  ,isnull((select top 1 FirmaAdi from TedarikciFirma  with(nolock) where TedarikciFirma.Id  = ErcomSiparis.TedarikciFirmaId),'Asaþpen') as TedarikciFirmaAdi
	  ,ErcomSiparis.TedarikciFirmaId
	  ,ErcomStok.IskontoOrani
	  ,case when ErcomStok.IskontoOrani is not null then [BirimFiyat] - ([BirimFiyat] * ErcomStok.IskontoOrani / 100) else [BirimFiyat] end as IskontoBirimFiyat
	  ,case when ErcomStok.IskontoOrani is not null then [ToplamFiyat] - ([ToplamFiyat] * ErcomStok.IskontoOrani / 100) else [ToplamFiyat] end as IskontoToplamFiyat
	  ,case when ErcomStok.IskontoOrani is not null then [KdvTutar] - ([KdvTutar] * ErcomStok.IskontoOrani / 100) else [KdvTutar] end  as IskontoKdvTutar
	  ,AktifPasif
	  ,case when SUBSTRING(TeklifSiparisNo,1,1)='Y' then '1-Teklif' else '2-Ýmalat' end as UretimAsamasi
	   ,ZirveStok2024.BAKIYE
	  
  FROM (select * from [ErcomMaliyetAnalizi] with(nolock) 
   WHERE AktifPasif= 1 
	 ) as [ErcomMaliyetAnalizi]   

left join ErcomStok with(nolock) on [ErcomMaliyetAnalizi].ErcomStokId = ErcomStok.Id
 left join ( 
			SELECT * FROM ErcomDbSiparis_2024  with(nolock)
			 )      ErcomSiparis on [ErcomMaliyetAnalizi].MusteriKodu = ErcomSiparis.CARIKOD
left join Users with(nolock) on Users.UserId = [ErcomMaliyetAnalizi].[UserId]
left join KabanSiparisleri  with(nolock) on KabanSiparisleri.SiparisNo = [ErcomMaliyetAnalizi].TeklifSiparisNo
left join ZirveStok2024 on ZirveStok2024.stk = ErcomStok.StokKodu --zirvegenel.. VW_StokPerformansListesi_2024 on VW_StokPerformansListesi_2024.stk = StokKodu
--left join TedarikciFirma  with(nolock) on TedarikciFirma.Id  = ErcomSiparis.TedarikciFirmaId
and KabanSiparisleri.PozNo = replace( [ErcomMaliyetAnalizi].PozNo,'Poz ','')
 where ErcomMaliyetAnalizi.AktifPasif = 1
-- AND stk = '7051'
--where TeklifSiparisNo = '1400004'
 --select * from [ErcomMaliyetAnalizi]  where year(teklifTarihi) = 2024

-- update ErcomDbSiparis_2023 set TedarikciFirmaId = 1
 --select  * from [ErcomMaliyetAnalizi] where TeklifSiparisNo = 'S301268'

--select * from ErcomDbSiparis_2024 WHERE SIPARISNO LIKE '1400023'

--select * from  zirvegenel.. VW_StokPerformansListesi_2024 where stk = '7051'

--select stk,count(stk) from ZirveStok2024  group by stk having count(stk)> 1


select * from ZirveStok2024 where stk = '10403'

GO
 
--select * into ZirveStok2024 from  
 zirvegenel.. VW_StokPerformansListesi_2024 on VW_StokPerformansListesi_2024.stk = StokKodu