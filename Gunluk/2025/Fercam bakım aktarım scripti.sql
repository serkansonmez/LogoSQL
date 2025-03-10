INSERT INTO BakimArizaHareket (
    RowCreatedBy,
    RowCreatedTime,
    RowUpdatedBy,
    RowUpdatedTime,
    BildirimTarihSaati,
    BakimKategoriId,
    BolumId,
    IsIstasyonlariId,
    MudahaleTarihSaati,
    BakimArizaKodlariId,
    ArizaBakimAciklamasi,
    ArizaGidermeTarihSaati,
    YapilanIslem,
    Aciklama,
    BakimIslemDurumuId,
    BakimiYapanUserId
)

SELECT 
    1 AS RowCreatedBy, -- Kullanýcý ID
    GETDATE() AS RowCreatedTime,
    1 AS RowUpdatedBy, -- Kullanýcý ID
    GETDATE() AS RowUpdatedTime,
    
    -- Tarih ve saat alanlarýný birleþtirerek BildirimTarihSaati oluþturuluyor
    CONVERT(DATETIME, A.[ARIZA BÝLDÝRÝM TARÝHÝ] + ' ' + ISNULL(A.[ARIZA BÝLDÝRÝM SAATÝ],'00:00:00'), 120) AS BildirimTarihSaati,
    
    CASE 
        WHEN A.[ ARIZA/ BAKIM] = 'ARIZA' THEN 1 
        WHEN A.[ ARIZA/ BAKIM] = 'BAKIM' THEN 2 
        ELSE NULL 
    END AS BakimKategoriId,
    
    isnull(B.Id,18) AS BolumId,
    isnull(I.IsIstasyonlariId,1) AS IsIstasyonlariId,
    
    -- Müdahale tarihi ve saati birleþtirilerek MudahaleTarihSaati oluþturuluyor
    CONVERT(DATETIME, A.[ARIZA/BAKIM MÜDAHALE TARÝHÝ] + ' ' + A.[ARIZA/BAKIM MÜDAHALE SAATÝ], 120) AS MudahaleTarihSaati,
    
    K.Id AS BakimArizaKodlariId,
    A.[ARIZA/BAKIM AÇIKLAMASI] AS ArizaBakimAciklamasi,
    
    -- Giderme tarihi ve saati birleþtirilerek ArizaGidermeTarihSaati oluþturuluyor
    CONVERT(DATETIME, A.[ARIZA/BAKIM MÜDAHALE TARÝHÝ] + ' ' + A.[ARIZA/BAKIM GÝDERME SAATÝ], 120) AS ArizaGidermeTarihSaati,
    
    A.[YAPILAN ÝÞLEM] AS YapilanIslem,
    A.[AÇIKLAMA] AS Aciklama,
    case when A.DURUM LIKE 'ARIZA%' then 3 else  D.Id  end AS BakimIslemDurumuId,
	case when A.[BAKIM OPERATÖRÜ] LIKE '%SORUKLU%' then '276' else ''  end + ',' +
	case when A.[BAKIM OPERATÖRÜ] LIKE '%NEVZAT%' then '273' else ''  end + ',' +
	case when A.[BAKIM OPERATÖRÜ] LIKE '%SARI%' then '316' else ''  end
   -- U.UserId AS BakimiYapanUserId

FROM ArizaBakimTakipExcel A
LEFT JOIN Bolum B ON SUBSTRING( A.BÖLÜM ,1,5)        =  SUBSTRING( B.BolumAdi,1,5) COLLATE Turkish_CI_AS  
LEFT JOIN IsIstasyonlari I ON replace(A.[MAKÝNE KODU],'-','') = I.IstasyonKodu collate Turkish_CI_AS 
LEFT JOIN BakimArizaKodlari K ON replace(A.[ARIZA KODU],'-','')  collate Turkish_CI_AS  = K.ArizaKodu     collate Turkish_CI_AS 
LEFT JOIN BakimIslemDurumu D ON  replace(A.DURUM,'ARIZA GÝDERÝLDÝ.','TAMAMLANDI') collate Turkish_CI_AS = D.DurumTanimi  collate Turkish_CI_AS 
LEFT JOIN Users U ON A.[BAKIM OPERATÖRÜ] = U.UserName collate Turkish_CI_AS ;


--SELECT * FROM Personel where Adi like 'NEVZAT' 273
--SELECT * FROM Personel where Adi like 'ARÝF' 276
--SELECT * FROM Personel where Adi like 'H_LM_' 316
--SELECT * FROM Personel where Soyadi like 'sor%' 28
-- SELECT * FROM Bolum where BolumAdi like 'SERÝGRAF%'
--select * from IsIstasyonlari

--SELECT  * FROM ArizaBakimTakipExcel A WHERE 