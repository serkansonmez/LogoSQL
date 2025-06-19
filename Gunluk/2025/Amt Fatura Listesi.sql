USE [Amt365_Default_v1]
GO

/****** Object:  View [dbo].[VW_EFaturaListesi]    Script Date: 09.06.2025 11:04:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--ALTER view [dbo].[VW_EFaturaListesi] as 
SELECT 
     NEWID() AS KayitId,
            'ASC Mimarlýk' AS FirmaAdi,
    cha_belge_tarih AS BelgeTarihi,
   CHEVRAK.CHEvrUzunIsim AS FaturaTuru,
   tblTip.EFatTipIsim as FaturaTipi,
    CAST(MAX(cha_create_date) AS date) AS EvrakTarihi,
    cha_evrakno_seri AS EvrakSeri,
    cha_evrakno_sira AS EvrakSira,
    cha_belge_no AS EfaturaId,
    MAX(CARI_HESAPLAR.cari_unvan1) AS CariUnvani,
    SUM(cha_meblag) AS Yekun,
    CASE WHEN MAX(cha_d_cins) = 0 THEN 'TL' END AS DovizCinsi
	, cha_ebelge_turu
	,cha_evrak_tip
FROM MikroDB_V16_ASC..CARI_HESAP_HAREKETLERI WITH (NOLOCK, INDEX = NDX_CARI_HESAP_HAREKETLERI_00)
LEFT JOIN MikroDB_V16_ASC..CARI_HESAP_HAREKETLERI_EK WITH (NOLOCK) 
    ON chaek_related_uid = cha_Guid
LEFT JOIN MikroDB_V16_ASC..E_FATURA_DETAYLARI WITH (NOLOCK) 
    ON MikroDB_V16_ASC..E_FATURA_DETAYLARI.efd_fat_uid = cha_Guid
LEFT JOIN MikroDB_V16_ASC..CARI_HESAPLAR WITH (NOLOCK) 
    ON CARI_HESAPLAR.cari_kod = cha_kod
left join MikroDB_V16_ASC..vw_EFatura_Tip_Isimleri tblTip on tblTip.EFatTipNo = cha_ebelge_turu 
LEFT OUTER JOIN MikroDB_V16_ASC..vw_Cari_Hareket_Evrak_Isimleri CHEVRAK ON CHEvrNo=cha_evrak_tip
 WHERE cha_belge_tarih BETWEEN '20250601' AND '20250609' --and len(cha_belge_no) > 1

GROUP BY 
    cha_belge_no,
    cha_evrakno_seri,
    cha_evrakno_sira,
    cha_belge_tarih,
	cha_evrak_tip ,
	 cha_ebelge_turu,
	 EFatTipIsim,
	 cha_evrak_tip,
	 CHEvrUzunIsim
--ORDER BY CAST(MAX(cha_create_date) AS date)
GO
--select * from  MikroDB_V16_ASC..vw_EFatura_Tip_Isimleri

