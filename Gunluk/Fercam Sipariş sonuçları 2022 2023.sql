-- Geçici tablo 1

CREATE TABLE #TempTable1 (
    CariKod VARCHAR(50),
    CariUnvan VARCHAR(255),
    SiparisHaftasi INT,
    SiparisTarihi DATETIME,
    Status VARCHAR(50),
    SiparisNo  VARCHAR(50),
    MalzemeKodu VARCHAR(50),
    MalzemeAdi VARCHAR(255),
    MalzemeGrupKodu VARCHAR(50),
    Ozekod3 VARCHAR(50),
    SipMiktari INT,
    SevkMiktari INT,
    Kalan INT,
    SatirAciklamasi VARCHAR(MAX),
    TeslimTarihi DATETIME,
    Fiyat DECIMAL(18, 6),
    KalanTutar DECIMAL(18, 6),
    MusteriKodu VARCHAR(50),
    TeslimAy INT
);

-- Geçici tablo 2
CREATE TABLE #TempTable2 (
    CariKod VARCHAR(50),
    CariUnvan VARCHAR(255),
    SiparisHaftasi INT,
    SiparisTarihi DATETIME,
    Status VARCHAR(50),
    SiparisNo  VARCHAR(50),
    MalzemeKodu VARCHAR(50),
    MalzemeAdi VARCHAR(255),
    MalzemeGrupKodu VARCHAR(50),
    Ozekod3 VARCHAR(50),
    SipMiktari INT,
    SevkMiktari INT,
    Kalan INT,
    SatirAciklamasi VARCHAR(MAX),
    TeslimTarihi DATETIME,
    Fiyat DECIMAL(18, 6),
    KalanTutar DECIMAL(18, 6),
    MusteriKodu VARCHAR(50),
    TeslimAy INT
);

-- Ýlk yýlýn verilerini #TempTable1'e yerleþtir
INSERT INTO #TempTable1
EXECUTE [dbo].DP_RAPOR_SATIS_SIPARIS '','023','01','20230101','20231231','%120%','%%';

-- Ýkinci yýlýn verilerini #TempTable2'ye yerleþtir
INSERT INTO #TempTable2
EXECUTE [dbo].DP_RAPOR_SATIS_SIPARIS '','022','01','20220101','20221231','%120%','%%';

-- Geçici tablolarý birleþtir
SELECT 2023 as Yil, * FROM #TempTable1
UNION ALL
SELECT 2022 as Yil, * FROM #TempTable2;

-- Geçici tablolarý temizle
DROP TABLE #TempTable1;
DROP TABLE #TempTable2;
