WITH PivotCTE AS (
    SELECT
        TahakkukYil,
        TahakkukAy,
        DovizCinsi,
        BankaAdi,
		 BankaAdi as  BankaAdi2,
        KalanTL,
        KalanEuro
    FROM [dbo].[VW_BankaKredileri_23]
)
SELECT
    TahakkukYil,
    TahakkukAy,
    [AKBANK_KalanTL],
    [DENIZ_BANK_KalanTL],
    [GARANTI_BANKASI_KalanTL],
    [HALK_BANKASI_KalanTL],
    [KOC_FINANSMAN_KalanTL],
    [KUVEYT_TURK_KalanTL],
    [T_IS_BANKASI_KalanTL],
    [TURK_EKONOMI_BANKASI_KalanTL],
    [TURK_EXIM_BANK_KalanTL],
    [VAKIF_BANK_KalanTL],
    [YAPI_KREDI_KalanTL],
    [AKBANK_KalanEuro],
    [DENIZ_BANK_KalanEuro],
    [GARANTI_BANKASI_KalanEuro],
    [HALK_BANKASI_KalanEuro],
    [KOC_FINANSMAN_KalanEuro],
    [KUVEYT_TURK_KalanEuro],
    [T_IS_BANKASI_KalanEuro],
    [TURK_EKONOMI_BANKASI_KalanEuro],
    [TURK_EXIM_BANK_KalanEuro],
    [VAKIF_BANK_KalanEuro],
    [YAPI_KREDI_KalanEuro]
FROM PivotCTE
PIVOT (
    SUM(KalanTL) FOR BankaAdi IN ([AKBANK_KalanTL], [DENIZ_BANK_KalanTL], [GARANTI_BANKASI_KalanTL], [HALK_BANKASI_KalanTL], [KOC_FINANSMAN_KalanTL], [KUVEYT_TURK_KalanTL], [T_IS_BANKASI_KalanTL], [TURK_EKONOMI_BANKASI_KalanTL], [TURK_EXIM_BANK_KalanTL], [VAKIF_BANK_KalanTL], [YAPI_KREDI_KalanTL])
) AS PivotTableTL
PIVOT (
    SUM(KalanEuro) FOR BankaAdi2 IN ([AKBANK_KalanEuro], [DENIZ_BANK_KalanEuro], [GARANTI_BANKASI_KalanEuro], [HALK_BANKASI_KalanEuro], [KOC_FINANSMAN_KalanEuro], [KUVEYT_TURK_KalanEuro], [T_IS_BANKASI_KalanEuro], [TURK_EKONOMI_BANKASI_KalanEuro], [TURK_EXIM_BANK_KalanEuro], [VAKIF_BANK_KalanEuro], [YAPI_KREDI_KalanEuro])
) AS PivotTableEuro
ORDER BY TahakkukYil, TahakkukAy;
