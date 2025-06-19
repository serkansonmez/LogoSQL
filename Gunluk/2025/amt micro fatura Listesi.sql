SELECT 
    efi.*,
    efd.efd_pozisyon,
    cha.* -- Ýhtiyacýnýza göre spesifik alanlarý seçin
FROM 
    E_FATURA_ISLEMLERI efi WITH(NOLOCK)
LEFT JOIN 
    E_FATURA_DETAYLARI efd WITH(NOLOCK) ON efd.efd_fat_uid = efi.efi_uuid
LEFT JOIN 
    CARI_HESAP_HAREKETLERI cha WITH(NOLOCK) ON cha.cha_Guid = efd.efd_fat_uid
WHERE 
    efi.efi_evrak_tipi = 0 -- Fatura tipine göre filtreleme
     AND efi.efi_create_date  BETWEEN '20250501' AND '20250528' -- Tarih aralýðý