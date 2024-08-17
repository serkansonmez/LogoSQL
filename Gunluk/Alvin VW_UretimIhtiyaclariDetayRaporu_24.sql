USE [AlvinB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_UretimIhtiyaclariDetayRaporu_24]    Script Date: 16.04.2024 10:47:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--   SELECT  * FROM AlvinB2B_Default_v1.. [VW_UretimIhtiyaclariDetayRaporu_24]  where TeklifSiparisNo = 'Y420326' 

 --ALTER  view [dbo].[VW_UretimIhtiyaclariDetayRaporu_24] as 
select  DISTINCT ROW_NUMBER() OVER (ORDER BY  VW_ErcomMaliyetAnalizi.StokAdi  ASC ) AS Id,VW_ErcomMaliyetAnalizi.StokKodu,VW_ErcomMaliyetAnalizi.StokAdi,round(sum(Miktar),2) as Miktar,Birim, 
round(sum(ToplamFiyat),2) as ToplamFiyat   
 ,SUBSTRING(TblStk.STK,8,5) AS GrupKodu,SUBSTRING(TblStk.stk,14,4) as RenkKodu
 ,tblOzelKod1.ACIKLAMA AS GrupAdi
 ,round(max(TblStkAdet.STGM),2) as StokGirenMiktar
 ,round(max(TblStkAdet.STCM),2) as StokCikanMiktar
 --,round(max(TblStkAdet.BAKIYE),2) as StokBakiye
 ,round(max(TblStkAdet.STGM) - max(TblStkAdet.STCM) ,2) as StokBakiye
  ,round(max(TblStkAdet.STGT),2) as StokGirenTutar
    ,round(max(TblStkAdet.STCT),2) as StokCikanTutar
	,ErcomEslesmeyenKartlar.ZirveKodu as EslesmeTablosuZirveKodu
	,TblStk.STK AS ZirveStokKodu
     ,TblStk.STA AS ZirveStokAdi
	 ,UretimDurumu
	 ,VW_ErcomMaliyetAnalizi.TeklifSiparisNo
	 ,VW_ErcomMaliyetAnalizi.CARIUNVAN AS CariUnvan
	 ,ErcomStok.StandartBoy --6.5 as  StandartBoy
	 ,VW_ErcomMaliyetAnalizi.PozNo
	 ,case when Birim = 'mtül' then CEILING(round(sum(Miktar),2) / ErcomStok.StandartBoy ) else sum(Miktar) end as  BoyAdet
	 ,round(max(TblStkAdet.STGM) - max(TblStkAdet.STCM) ,2) - round(sum(Miktar),2) as KalanMtul
	 ,round((round(max(TblStkAdet.STGM) - max(TblStkAdet.STCM) ,2) - round(sum(Miktar),2)) / 6.5,2) as KalanBoy
	 ,TedarikciFirmaAdi
	 ,VW_ErcomMaliyetAnalizi.AktaranKullanici
--tblOzelKod1.ACIKLAMA as OZELKOD1ACIKLAMA 
from VW_ErcomMaliyetAnalizi 
left join ErcomEslesmeyenKartlar WITH(NOLOCK) on VW_ErcomMaliyetAnalizi.StokKodu = ErcomEslesmeyenKartlar.ErcomKodu
LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStk ON     case  when TedarikciFirmaAdi = 'asaþpen' then stk else  
													  SUBSTRING(stk,8,5) + SUBSTRING(stk,14,4) end = 
													 case  when TedarikciFirmaAdi = 'asaþpen' then StokKodu
														   when ErcomEslesmeyenKartlar.ZirveKodu is not null then replace(ErcomEslesmeyenKartlar.ZirveKodu,'.','') 
														 else  StokKodu end
														 
--LEFT JOIN [ÝREN_PVC_2024T]..STOK_TOPLAM_OC() TblStkAdet ON TblStkAdet.STOKREF  = TblStk.REF
LEFT JOIN [ÝREN_PVC_2024T]..LISTESTOKLAR_2024() TblStkAdet ON TblStkAdet.REF  = TblStk.REF
LEFT JOIN  [ÝREN_PVC_2024T]..Degerler tblOzelKod1 wIth(nolock) ON TblStk.OZELKOD1 = tblOzelKod1.KOD and tblOzelKod1.ALANADI = 'OZELKOD1'
-- LEFT JOIN [ÝREN_PVC_2024T]..LISTESTOKLAR_2024() TblStkAdet ON TblStkAdet.REF  = TblStk.REF
 left join ErcomStok WITH(NOLOCK) ON ErcomStok.StokKodu = VW_ErcomMaliyetAnalizi.StokKodu
 --where VW_ErcomMaliyetAnalizi.TeklifSiparisNo = 'Y420326' 
group by VW_ErcomMaliyetAnalizi.StokKodu,VW_ErcomMaliyetAnalizi.StokAdi, Birim ,TblStk.STK ,tblOzelKod1.ACIKLAMA,ErcomEslesmeyenKartlar.ZirveKodu   ,TblStk.STA  ,tblStk.STK,UretimDurumu,VW_ErcomMaliyetAnalizi.TeklifSiparisNo,VW_ErcomMaliyetAnalizi.CARIUNVAN , VW_ErcomMaliyetAnalizi.PozNo,ErcomStok.StandartBoy,TedarikciFirmaAdi,VW_ErcomMaliyetAnalizi.AktaranKullanici
--order by VW_ErcomMaliyetAnalizi.StokKodu, sum(ToplamFiyat)  desc   202651
GO


