SELECT DISTINCT
    efi.efi_uuid,
    efi.efi_evrakno_seri + CAST(efi.efi_evrakno_sira AS VARCHAR) AS EvrakNo,
    efi.efi_create_date AS Fatura_Tarihi,
    efi.efi_islem_tipi AS Islem_Tipi,
    efi.efi_carikod AS Cari_Kodu,
	 
 --    CARI_HESAPLAR.cari_unvan1 AS Cari_Adi,
    efd.efd_gib_seri,
    efd.efd_gib_sira,
    efd.efd_pozisyon,
    efd.efd_mVkn,
    --ch.TUTAR,
    efi.efi_onaylandi_fl AS Onay_Durumu,
    efi.efi_gonderildi_fl AS Gonderim_Durumu,
    efi.efi_rededildi_fl AS Red_Durumu,
    efi.efi_kabuledildi_fl AS Kabul_Durumu
FROM 
    E_FATURA_ISLEMLERI efi
LEFT JOIN 
    E_FATURA_DETAYLARI efd ON efi.efi_uuid = efd.efd_uuid
LEFT JOIN 
    CARI_HESAP_HAREKETLERI ch ON efi.efi_carikod = ch.cha_kod
--LEFT JOIN CARI_HESAPLAR on CARI_HESAPLAR.cari_Ana_cari_kodu = ch.cha_kod
WHERE 
    efi.efi_create_date >= '2025-05-01' -- Tarih aralýðý isteðe göre deðiþtirilebilir
ORDER BY 
    efi.efi_create_date DESC;
