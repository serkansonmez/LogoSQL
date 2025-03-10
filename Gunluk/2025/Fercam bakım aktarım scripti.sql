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
    1 AS RowCreatedBy, -- Kullan�c� ID
    GETDATE() AS RowCreatedTime,
    1 AS RowUpdatedBy, -- Kullan�c� ID
    GETDATE() AS RowUpdatedTime,
    
    -- Tarih ve saat alanlar�n� birle�tirerek BildirimTarihSaati olu�turuluyor
    CONVERT(DATETIME, A.[ARIZA B�LD�R�M TAR�H�] + ' ' + ISNULL(A.[ARIZA B�LD�R�M SAAT�],'00:00:00'), 120) AS BildirimTarihSaati,
    
    CASE 
        WHEN A.[ ARIZA/ BAKIM] = 'ARIZA' THEN 1 
        WHEN A.[ ARIZA/ BAKIM] = 'BAKIM' THEN 2 
        ELSE NULL 
    END AS BakimKategoriId,
    
    isnull(B.Id,18) AS BolumId,
    isnull(I.IsIstasyonlariId,1) AS IsIstasyonlariId,
    
    -- M�dahale tarihi ve saati birle�tirilerek MudahaleTarihSaati olu�turuluyor
    CONVERT(DATETIME, A.[ARIZA/BAKIM M�DAHALE TAR�H�] + ' ' + A.[ARIZA/BAKIM M�DAHALE SAAT�], 120) AS MudahaleTarihSaati,
    
    K.Id AS BakimArizaKodlariId,
    A.[ARIZA/BAKIM A�IKLAMASI] AS ArizaBakimAciklamasi,
    
    -- Giderme tarihi ve saati birle�tirilerek ArizaGidermeTarihSaati olu�turuluyor
    CONVERT(DATETIME, A.[ARIZA/BAKIM M�DAHALE TAR�H�] + ' ' + A.[ARIZA/BAKIM G�DERME SAAT�], 120) AS ArizaGidermeTarihSaati,
    
    A.[YAPILAN ��LEM] AS YapilanIslem,
    A.[A�IKLAMA] AS Aciklama,
    case when A.DURUM LIKE 'ARIZA%' then 3 else  D.Id  end AS BakimIslemDurumuId,
	case when A.[BAKIM OPERAT�R�] LIKE '%SORUKLU%' then '276' else ''  end + ',' +
	case when A.[BAKIM OPERAT�R�] LIKE '%NEVZAT%' then '273' else ''  end + ',' +
	case when A.[BAKIM OPERAT�R�] LIKE '%SARI%' then '316' else ''  end
   -- U.UserId AS BakimiYapanUserId

FROM ArizaBakimTakipExcel A
LEFT JOIN Bolum B ON SUBSTRING( A.B�L�M ,1,5)        =  SUBSTRING( B.BolumAdi,1,5) COLLATE Turkish_CI_AS  
LEFT JOIN IsIstasyonlari I ON replace(A.[MAK�NE KODU],'-','') = I.IstasyonKodu collate Turkish_CI_AS 
LEFT JOIN BakimArizaKodlari K ON replace(A.[ARIZA KODU],'-','')  collate Turkish_CI_AS  = K.ArizaKodu     collate Turkish_CI_AS 
LEFT JOIN BakimIslemDurumu D ON  replace(A.DURUM,'ARIZA G�DER�LD�.','TAMAMLANDI') collate Turkish_CI_AS = D.DurumTanimi  collate Turkish_CI_AS 
LEFT JOIN Users U ON A.[BAKIM OPERAT�R�] = U.UserName collate Turkish_CI_AS ;


--SELECT * FROM Personel where Adi like 'NEVZAT' 273
--SELECT * FROM Personel where Adi like 'AR�F' 276
--SELECT * FROM Personel where Adi like 'H_LM_' 316
--SELECT * FROM Personel where Soyadi like 'sor%' 28
-- SELECT * FROM Bolum where BolumAdi like 'SER�GRAF%'
--select * from IsIstasyonlari

--SELECT  * FROM ArizaBakimTakipExcel A WHERE 