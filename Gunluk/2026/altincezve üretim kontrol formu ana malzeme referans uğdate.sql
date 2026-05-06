-- 1. Önce mevcut durumu kontrol edelim
SELECT 
    U.UretimKontrolFormuId,
    U.UrunAdi,
    V.AnaUrunAdi,
    U.UrunPartiNo,
    U.PolineRef
FROM dbo.UretimKontrolFormu U
INNER JOIN VW_UretimEmriSatirlari_26 V
    ON U.PolineRef = V.IsEmriReferans
    AND U.UrunPartiNo = V.UretimEmriNo
WHERE V.Yil = 2026
    AND V.SatirTipi = 'Girdi'
    AND U.UrunAdi <> V.AnaUrunAdi
ORDER BY U.KayitTarihi;

-- 2. Güncelleme sorgusu
UPDATE U
SET U.UrunAdi = V.AnaUrunAdi
FROM dbo.UretimKontrolFormu U
INNER JOIN (
    SELECT DISTINCT
        IsEmriReferans,
        UretimEmriNo,
        AnaUrunAdi
    FROM VW_UretimEmriSatirlari_26 
    WHERE Yil = 2026
        AND SatirTipi = 'Girdi'
) V
    ON U.PolineRef = V.IsEmriReferans
    AND U.UrunPartiNo = V.UretimEmriNo
WHERE EXISTS (
    SELECT 1
    FROM VW_UretimEmriSatirlari_26 V2
    WHERE V2.IsEmriReferans = U.PolineRef
        AND V2.UretimEmriNo = U.UrunPartiNo
        AND V2.Yil = 2026
        AND V2.SatirTipi = 'Girdi'
);

-- 3. Güncelleme sonrasý kontrol
SELECT 
    U.UretimKontrolFormuId,
    U.UrunAdi,
    V.AnaUrunAdi,
    U.UrunPartiNo,
    U.PolineRef,
    CASE 
        WHEN U.UrunAdi = V.AnaUrunAdi THEN 'Eþleþiyor'
        ELSE 'Farklý'
    END AS Durum
FROM dbo.UretimKontrolFormu U
INNER JOIN VW_UretimEmriSatirlari_26 V
    ON U.PolineRef = V.IsEmriReferans
    AND U.UrunPartiNo = V.UretimEmriNo
WHERE V.Yil = 2026
    AND V.SatirTipi = 'Girdi'
ORDER BY U.KayitTarihi;