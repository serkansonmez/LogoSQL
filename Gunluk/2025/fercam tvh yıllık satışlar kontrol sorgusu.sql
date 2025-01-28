drop table #temp

CREATE TABLE #temp (
    SatirReferans INT,
    CariStatusu NVARCHAR(50),
    CariKodu NVARCHAR(50),
    CariUnvani NVARCHAR(255),
    CariOzelKodu NVARCHAR(50),
    CariOzelKodu5 NVARCHAR(50),
    CariYetkiKodu NVARCHAR(50),
    VergiDairesi NVARCHAR(255),
    VergiNo NVARCHAR(50),
    MalzemeKodu NVARCHAR(50),
    MalzemeAciklamasi NVARCHAR(255),
    MalzemeOzelKodu NVARCHAR(50),
    MalzemeOzelKod2 NVARCHAR(50),
    MalzemeOzelKod3 NVARCHAR(50),
    MalzemeOzelKod4 NVARCHAR(50),
    MalzemeOzelKod5 NVARCHAR(50),
    MalzemeGrupKodu NVARCHAR(50),
    MalzemeYetkiKodu NVARCHAR(50),
    FisTuru NVARCHAR(255),
    FisTarihi DATETIME,
    FisNo NVARCHAR(50),
    MuhasebeDurumu NVARCHAR(50),
    FaturaDurumu NVARCHAR(50),
    FaturaNo NVARCHAR(50),
    FisAyi NVARCHAR(50),
    Miktar INT,
    Kdv DECIMAL(18, 2),
    KdvHaric DECIMAL(18, 2),
    KdvTutari DECIMAL(18, 2),
    SatirTipi NVARCHAR(50),
    SaticiKodu NVARCHAR(50),
    SaticiAdi NVARCHAR(255),
    Maliyet DECIMAL(18, 2),
    SatisFiyatFarki DECIMAL(18, 2),
    Kar DECIMAL(18, 2),
    FisYili INT,
    Sehir NVARCHAR(255)
);
 


 INSERT INTO #temp
EXEC EMY_RAPOR_SATIS_ANALIZ '','022','01','20220101','20221231','%120.02.T001%','%%';

INSERT INTO #temp
EXEC EMY_RAPOR_SATIS_ANALIZ '','023','01','20230101','20231231','%120.02.T001%','%%';

INSERT INTO #temp
EXEC EMY_RAPOR_SATIS_ANALIZ '','024','01','20240101','20241231','%120.02.T001%','%%';

INSERT INTO #temp
EXEC EMY_RAPOR_SATIS_ANALIZ '','025','01','20250101','20251231','%120.02.T001%','%%';

 select *,ForexBuying as EuroKur,round(KdvHaric / ForexBuying,2) as EuroKdvHaric  from #temp
 left join FercamB2B_Default_v1..DOVIZKURLARI on FisTarihi = Tarih and  crossorder = 9
 --where Tarih is null

