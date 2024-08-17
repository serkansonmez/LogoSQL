WITH CalculatedData AS (
    SELECT
        0 AS Id,
        TeklifSiparisNo,
        MusterilerId,
        ErcomStokId,
        SUM(Miktar) AS Miktar,
        Birim,
        BirimKg,
        CASE
            WHEN SUM(Miktar) > 0 THEN ROUND(SUM(IskontoToplamFiyat) / SUM(Miktar), 2)
            ELSE SUM(IskontoToplamFiyat)
        END AS BirimFiyat,
        SUM(IskontoToplamFiyat) AS IskontoToplamFiyat,
        MusteriKodu,
        CASE
            WHEN VW_ErcomMaliyetAnalizi.TedarikciFirmaId = 1 THEN TblStk.STA
            ELSE TblStkAsas.STA
        END AS Stokadi,
        CASE
            WHEN VW_ErcomMaliyetAnalizi.TedarikciFirmaId = 1 THEN TblStk.STK
            ELSE TblStkAsas.STK
        END AS StokKodu,
        TeklifNo,
        CASE
            WHEN VW_ErcomMaliyetAnalizi.TedarikciFirmaId = 1 THEN TblStk.P_ID
            ELSE TblStkAsas.P_ID
        END AS P_ID,
        CASE
            WHEN VW_ErcomMaliyetAnalizi.TedarikciFirmaId = 1 THEN TblStk.REF
            ELSE TblStkAsas.REF
        END AS REF,
        sum(VW_ErcomMaliyetAnalizi.Miktar) AS OriginalMiktar
    FROM
        VW_ErcomMaliyetAnalizi
    LEFT JOIN ErcomEslesmeyenKartlar WITH (NOLOCK) ON VW_ErcomMaliyetAnalizi.StokKodu = ErcomEslesmeyenKartlar.ErcomKodu
    LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStk ON SUBSTRING(TblStk.stk, 8, 5) + SUBSTRING(TblStk.stk, 14, 4) = CASE
            WHEN ErcomEslesmeyenKartlar.ZirveKodu IS NOT NULL THEN REPLACE(ErcomEslesmeyenKartlar.ZirveKodu, '.', '')
            ELSE StokKodu
        END
    LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStkAsas WITH (NOLOCK) ON TblStkAsas.stk = CASE
            WHEN ErcomEslesmeyenKartlar.ZirveKodu IS NOT NULL THEN REPLACE(ErcomEslesmeyenKartlar.ZirveKodu, '.', '')
            ELSE StokKodu
        END
    WHERE
        VW_ErcomMaliyetAnalizi.AktifPasif = 1
        AND Birim = 'mtül'
        AND TeklifSiparisNo = '1400096'
        AND ZirveFireRef IS NULL
    GROUP BY
        TeklifSiparisNo,
        MusterilerId,
        ErcomStokId,
        Birim,
        BirimKg,
        MusteriKodu,
        TblStk.STA,
        TblStkAsas.STA,
        TblStk.STK,
        TblStkAsas.STK,
        TeklifNo,
        TblStkAsas.P_ID,
        TblStk.P_ID,
        TblStkAsas.REF,
        TblStk.REF,
        VW_ErcomMaliyetAnalizi.TedarikciFirmaId
)
SELECT
    Id,
    TeklifSiparisNo,
    MusterilerId,
    ErcomStokId,
    ( 6.5 -   (CAST(Miktar AS numeric(18,2)) % 6.5))  Miktar,
    Birim,
    BirimKg,
    BirimFiyat,
    BirimFiyat *  ( 6.5 -   (CAST(Miktar AS numeric(18,2)) % 6.5))  as IskontoToplamFiyat,
    MusteriKodu,
    Stokadi,
    StokKodu,
    TeklifNo,
    P_ID,
    REF 
 --, CAST(Miktar AS numeric(18,2)) % 6.5 AS ModuloResult,
 --( 6.5 -   (CAST(Miktar AS numeric(18,2)) % 6.5)) AS ExpectedResult,
 --  Miktar
FROM
    CalculatedData
ORDER BY
    Id;
