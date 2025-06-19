--  select * from VW_GunlukUretimListesi where Tarih = '20240305' Siralama is not null order by Siralama
alter view VW_GunlukUretimListesi as 
--01.01: Kesim-Setup Adet

SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '01-Setup Adet' AS Aciklama,
    COUNT(DISTINCT OptimizasyonKodu) AS Adet  -- Farkl� kodlar� say
FROM KesimHareket 
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.02: Kesim-Setup Dk
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(BaslangicTarih AS DATE) AS Tarih,
    '02-Setup Dk' AS Aciklama,
    sum(FarkDk) AS Adet  -- Farkl� kodlar� say
FROM VW_DurusHareket WHERE OperasyonTanimiId  =1 AND DurusTurleriId = 157 -- M6-SETUP (AYAR)
GROUP BY CAST(BaslangicTarih AS DATE)
UNION ALL
--01.03: Kesim-Ar�za Dk
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(BaslangicTarih AS DATE) AS Tarih,
    '03-Ar�za Dk' AS Aciklama,
    sum(FarkDk) AS Adet  -- Farkl� kodlar� say
FROM VW_DurusHareket WHERE OperasyonTanimiId  =1 AND DurusTurleriId = 155 -- M4-BAKIM (ARIZA)
GROUP BY CAST(BaslangicTarih AS DATE)
UNION ALL
--01.04: Kesim-Di�er Duru�
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(BaslangicTarih AS DATE) AS Tarih,
    '04-Di�er Duru�' AS Aciklama,
    sum(FarkDk) AS Adet  -- Farkl� kodlar� say
FROM VW_DurusHareket WHERE OperasyonTanimiId  =1 AND DurusTurleriId NOT IN(157, 155,152) -- M4-BAKIM (ARIZA)
GROUP BY CAST(BaslangicTarih AS DATE)
UNION ALL
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '05-Personel Say�s�' AS Aciklama,
    COUNT(DISTINCT PersonelId) AS Adet
FROM (
    SELECT PersonelId1 AS PersonelId, IseBaslangicSaati
    FROM KesimHareket
    WHERE PersonelId1 > 0
    UNION
    SELECT PersonelId2 AS PersonelId, IseBaslangicSaati
    FROM KesimHareket
    WHERE PersonelId2 > 0
) AS Combined
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.06: Kesim-Cnc Adet
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '06-Cnc Adet' AS Aciklama,
    sum(GerceklesenAdet) AS Adet  -- Farkl� kodlar� say
FROM [VW_KesimIsEmriToplamlari] WHERE SUBSTRING(RotaKodu,1,1) = 'B' OR  SUBSTRING(RotaKodu,1,1) = 'D'
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.07: Kesim-Makine Say�s�
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '07-Makine Say�s�' AS Aciklama,
    COUNT(DISTINCT 
        CAST(CAST(IseBaslangicSaati AS DATE) AS VARCHAR(10)) + '-' + 
        CASE 
            WHEN CAST(IseBaslangicSaati AS TIME) >= '07:30:00' AND CAST(IseBaslangicSaati AS TIME) < '15:30:00' THEN '1'  -- 1. vardiya
            WHEN CAST(IseBaslangicSaati AS TIME) >= '15:30:00' AND CAST(IseBaslangicSaati AS TIME) < '23:00:00' THEN '2'  -- 2. vardiya
            ELSE '3'  -- 3. vardiya
        END + '-' +
        CAST(IsIstasyonlariId AS VARCHAR(10))
    ) AS Adet
FROM vw_KesimHareket
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.08: Kesim-Y�ksek Kalite Adet
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '08-Y�ksek Kalite Adet' AS Aciklama,
    SUM(GerceklesenAdet) AS Adet
FROM VW_KesimIsEmriToplamlari
left join TIGER..VW_SIPARIS_URETIM_EMRI_25 tblSiparis ON tblSiparis.UretimEmriNo = VW_KesimIsEmriToplamlari.IsEmriNo
WHERE YuksekKalite = 'YUK.KALITE'
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.09: Kesim-Plaka Adeti
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '09-Plaka Adeti' AS Aciklama,
    COUNT(KesilenPlakaAdet) AS Adet  -- Farkl� kodlar� say
FROM KesimHareket 
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.10: Kesim-Adet
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '10-Adet' AS Aciklama,
    sum(GerceklesenAdet) AS Adet  -- Farkl� kodlar� say
FROM [VW_KesimIsEmriToplamlari] -- WHERE SUBSTRING(RotaKodu,1,1) = 'B' OR  SUBSTRING(RotaKodu,1,1) = 'D'
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.11: Kesim-M2
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '11-M2' AS Aciklama,
    sum(GerceklesenM2) AS Adet  -- Farkl� kodlar� say
FROM [VW_KesimIsEmriToplamlari] -- WHERE SUBSTRING(RotaKodu,1,1) = 'B' OR  SUBSTRING(RotaKodu,1,1) = 'D'
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
--01.12: Kesim-Hata Adet
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(Tarih AS DATE) AS Tarih,
    '12-Hata Adet' AS Aciklama,
    sum(HurdaCamAdet) AS Adet  -- Farkl� kodlar� say
FROM VW_HurdaCamHareket  WHERE OperasyonTanimiId  =1
GROUP BY CAST(Tarih AS DATE)
UNION ALL
--01.13: Kesim-Hata m2
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(Tarih AS DATE) AS Tarih,
    '13-Hata M2' AS Aciklama,
    sum(HurdaCamM2) AS Adet  -- Farkl� kodlar� say
FROM VW_HurdaCamHareket  WHERE OperasyonTanimiId  =1
GROUP BY CAST(Tarih AS DATE)
UNION ALL
--01.14: Kesim-Hedef Sapmas� Adet
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '14-Hedef Sapmas� Adet' AS Aciklama,
    SUM(GerceklesenAdet) - (
        SELECT 
            CAST(LTRIM(RTRIM(REPLACE(REPLACE(ParametreDegeri, CHAR(13), ''), CHAR(10), ''))) AS INT) 
        FROM Parametreler 
        WHERE ParametreTanimi = 'Kesim Hedef Adet'
    ) AS Adet
FROM [VW_KesimIsEmriToplamlari]   
GROUP BY CAST(IseBaslangicSaati AS DATE)
 
UNION ALL
--01.15: Kesim-Kesim Hedef m�
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    CAST(IseBaslangicSaati AS DATE) AS Tarih,
    '15-Kesim Hedef m�' AS Aciklama,
    SUM(GerceklesenM2) - (
								SELECT 
								   CAST(
							REPLACE(
								LTRIM(RTRIM(REPLACE(REPLACE(ParametreDegeri, CHAR(13), ''), CHAR(10), ''))),
								',', '.'
							) AS FLOAT
						) 
        FROM Parametreler 
        WHERE ParametreTanimi = 'Kesim Hedef m�'
    ) AS Adet  --  
FROM [VW_KesimIsEmriToplamlari] -- WHERE SUBSTRING(RotaKodu,1,1) = 'B' OR  SUBSTRING(RotaKodu,1,1) = 'D'
GROUP BY CAST(IseBaslangicSaati AS DATE)
UNION ALL
 --01.16: Kesim-Hata Oran� Sapmas�
 
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    M2.Tarih,
    '16-Hata Oran� Sapmas�' AS Aciklama,
    CASE 
        WHEN (M2.Adet + HataM2.Adet) = 0 THEN 0
        ELSE ROUND(HataM2.Adet / (M2.Adet + HataM2.Adet), 4)
    END AS Adet
FROM 
(
    SELECT CAST(IseBaslangicSaati AS DATE) AS Tarih, SUM(GerceklesenM2) AS Adet
    FROM VW_KesimIsEmriToplamlari
    GROUP BY CAST(IseBaslangicSaati AS DATE)
) M2
LEFT JOIN 
(
    SELECT CAST(Tarih AS DATE) AS Tarih, SUM(HurdaCamM2) AS Adet
    FROM VW_HurdaCamHareket 
    WHERE OperasyonTanimiId = 1
    GROUP BY CAST(Tarih AS DATE)
) HataM2 ON M2.Tarih = HataM2.Tarih
UNION ALL
--01.17: Kesim-Parti B�y�kl���
SELECT 
    '01' AS OperasyonKodu,
    'Kesim' AS OperasyonAdi,
    Plaka.Tarih,
    '17-Parti B�y�kl���' AS Aciklama,
    CASE 
        WHEN Setup.Adet = 0 THEN 0
        ELSE ROUND(CAST(Plaka.Adet AS FLOAT) / Setup.Adet, 2)
    END AS Adet
FROM (
    SELECT CAST(IseBaslangicSaati AS DATE) AS Tarih, COUNT(KesilenPlakaAdet) AS Adet
    FROM KesimHareket 
    GROUP BY CAST(IseBaslangicSaati AS DATE)
) AS Plaka
LEFT JOIN (
    SELECT CAST(IseBaslangicSaati AS DATE) AS Tarih, COUNT(DISTINCT OptimizasyonKodu) AS Adet
    FROM KesimHareket 
    GROUP BY CAST(IseBaslangicSaati AS DATE)
) AS Setup ON Plaka.Tarih = Setup.Tarih
--select * from  VW_KesimHareket


--select * from VW_Optimizasyon order by KesimHareketId

--select * from VW_OptimizasyonToplamlar
--select * from KesimHareket  where cast(IseBaslangicSaati as date) = '2025-05-22'

--select * from VW_DurusHareket where  cast(BaslangicTarih as date) = '2025-05-22' and OperasyonTanimiId  =1