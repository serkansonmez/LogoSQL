alter PROCEDURE dbo.sp_GetCariBakiyeRaporu
    @TigerFirmaNo INT,
    @TigerDonemNo INT,
    @GoFirmaNo INT,
    @GoDonemNo INT,
    @BaslangicTarihi DATE,
    @BitisTarihi DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Geçici tablolarý oluþtur
    IF OBJECT_ID('tempdb..#TigerCari') IS NOT NULL DROP TABLE #TigerCari;
    IF OBJECT_ID('tempdb..#GoCari') IS NOT NULL DROP TABLE #GoCari;

    CREATE TABLE #TigerCari (
        LOGICALREF INT,
        CODE NVARCHAR(25),
        DEFINITION_ NVARCHAR(250),
        TCKNO NVARCHAR(20),
        TAXNR NVARCHAR(20),
        DEBIT FLOAT,
        CREDIT FLOAT
    )

    CREATE TABLE #GoCari (
        CODE NVARCHAR(25),
        DEBIT FLOAT,
        CREDIT FLOAT
    )

    DECLARE @SQL NVARCHAR(MAX)

    -----------------------------
    -- 1. Tiger Tarafý
    -----------------------------
    SET @SQL = '
    INSERT INTO #TigerCari
    SELECT 
        CLC.LOGICALREF,
        CLC.CODE,
        CLC.DEFINITION_,
        CLC.TCKNO,
        CLC.TAXNR,
        ISNULL(SUM(CASE WHEN CLF.SIGN = 0 THEN CLF.AMOUNT ELSE 0 END), 0) AS DEBIT,
        ISNULL(SUM(CASE WHEN CLF.SIGN = 1 THEN CLF.AMOUNT ELSE 0 END), 0) AS CREDIT
    FROM CEZVE..LG_' + CAST(@TigerFirmaNo AS NVARCHAR) + '_CLCARD CLC
    LEFT JOIN CEZVE..LG_' + CAST(@TigerFirmaNo AS NVARCHAR) + '_0' + CAST(@TigerDonemNo AS NVARCHAR) + '_CLFLINE CLF 
        ON CLF.CLIENTREF = CLC.LOGICALREF AND CLF.DATE_ BETWEEN @BaslangicTarihi AND @BitisTarihi
    GROUP BY 
        CLC.LOGICALREF,
        CLC.CODE,
        CLC.DEFINITION_,
        CLC.TCKNO,
        CLC.TAXNR
    '

    EXEC sp_executesql @SQL, 
        N'@BaslangicTarihi DATE, @BitisTarihi DATE',
        @BaslangicTarihi, @BitisTarihi

    -----------------------------
    -- 2. GO3 Tarafý
    -----------------------------
    SET @SQL = '
    INSERT INTO #GoCari
    SELECT 
        CLC.CODE,
        ISNULL(SUM(CASE WHEN CLF.SIGN = 0 THEN CLF.AMOUNT ELSE 0 END), 0) AS DEBIT,
        ISNULL(SUM(CASE WHEN CLF.SIGN = 1 THEN CLF.AMOUNT ELSE 0 END), 0) AS CREDIT
    FROM GO3DB..LG_' + CAST(@GoFirmaNo AS NVARCHAR) + '_CLCARD CLC
    LEFT JOIN GO3DB..LG_' + CAST(@GoFirmaNo AS NVARCHAR) + '_0' + CAST(@GoDonemNo AS NVARCHAR) + '_CLFLINE CLF 
        ON CLF.CLIENTREF = CLC.LOGICALREF AND CLF.DATE_ BETWEEN @BaslangicTarihi AND @BitisTarihi
    GROUP BY CLC.CODE
    '

    EXEC sp_executesql @SQL, 
        N'@BaslangicTarihi DATE, @BitisTarihi DATE',
        @BaslangicTarihi, @BitisTarihi

    -----------------------------
    -- 3. Final Sorgu
    -----------------------------
    SELECT 
        PERF.LOGICALREF,
        PERF.CODE AS TigerCode,
        PERF.DEFINITION_ AS TigerName,
        PERF.TCKNO,
        PERF.TAXNR,

        CASE 
            WHEN LEFT(PERF.CODE, 3) = '120' THEN ROUND(PERF.DEBIT - PERF.CREDIT, 2)
            ELSE ROUND(PERF.CREDIT - PERF.DEBIT, 2)
        END AS TigerBakiye,

        CASE 
            WHEN LEFT(PERF.CODE, 3) = '120' THEN 'B'
            ELSE 'A'
        END AS TigerBakiyeTuru,

        CASE 
            WHEN LEFT(PERF.CODE, 3) = '120' THEN ROUND(GO.DEBIT - GO.CREDIT, 2)
            ELSE ROUND(GO.CREDIT - GO.DEBIT, 2)
        END AS GoBakiye,

        CASE 
            WHEN LEFT(PERF.CODE, 3) = '120' THEN 'B'
            ELSE 'A'
        END AS GoBakiyeTuru

    FROM #TigerCari PERF
    LEFT JOIN #GoCari GO ON GO.CODE = PERF.CODE
    WHERE (PERF.DEBIT > 0 OR PERF.CREDIT > 0) AND PERF.LOGICALREF IS NOT NULL

    -- Temizle
    DROP TABLE #TigerCari
    DROP TABLE #GoCari
END
