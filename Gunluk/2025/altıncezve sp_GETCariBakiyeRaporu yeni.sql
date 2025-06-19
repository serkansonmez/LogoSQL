ALTER PROCEDURE dbo.sp_GetCariBakiyeRaporu
    @TigerFirmaNo INT,
    @TigerDonemNo INT,
    @GoFirmaNo INT,
    @GoDonemNo INT,
    @BaslangicTarihi DATE = NULL,
    @BitisTarihi DATE = NULL,
    @ContainsText NVARCHAR(200) = NULL,
    @SortExpression NVARCHAR(200) = NULL,
    @Skip INT = 0,
    @Take INT = 20
AS
BEGIN
    SET NOCOUNT ON;

    -- Varsayýlan tarihler
    IF @BaslangicTarihi IS NULL SET @BaslangicTarihi = '1900-01-01'
    IF @BitisTarihi IS NULL SET @BitisTarihi = '9999-12-31'

    -- Geçici tablolarý oluþtur
    IF OBJECT_ID('tempdb..#TigerCari') IS NOT NULL DROP TABLE #TigerCari;
    IF OBJECT_ID('tempdb..#GoCari') IS NOT NULL DROP TABLE #GoCari;
    IF OBJECT_ID('tempdb..#FinalResults') IS NOT NULL DROP TABLE #FinalResults;

    CREATE TABLE #TigerCari (
        LOGICALREF INT,
        CODE NVARCHAR(25),
        DEFINITION_ NVARCHAR(250),
        TCKNO NVARCHAR(20),
        TAXNR NVARCHAR(20),
        DEBIT FLOAT,
        CREDIT FLOAT
    );

    CREATE TABLE #GoCari (
        CODE NVARCHAR(25),
        DEBIT FLOAT,
        CREDIT FLOAT
    );

    CREATE TABLE #FinalResults (
        RowNum INT IDENTITY(1,1),
        LOGICALREF INT,
        TigerCode NVARCHAR(25),
        TigerName NVARCHAR(250),
        TCKNO NVARCHAR(20),
        TAXNR NVARCHAR(20),
        TigerBakiye FLOAT,
        TigerBakiyeTuru CHAR(1),
        GoBakiye FLOAT,
        GoBakiyeTuru CHAR(1)
    );

    DECLARE @SQL NVARCHAR(MAX);

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
        ON CLF.CLIENTREF = CLC.LOGICALREF 
        AND CLF.DATE_ BETWEEN @BaslangicTarihi AND @BitisTarihi
    GROUP BY 
        CLC.LOGICALREF,
        CLC.CODE,
        CLC.DEFINITION_,
        CLC.TCKNO,
        CLC.TAXNR
    ';

    EXEC sp_executesql @SQL, 
        N'@BaslangicTarihi DATE, @BitisTarihi DATE',
        @BaslangicTarihi, @BitisTarihi;

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
        ON CLF.CLIENTREF = CLC.LOGICALREF 
        AND CLF.DATE_ BETWEEN @BaslangicTarihi AND @BitisTarihi
    GROUP BY CLC.CODE
    ';

    EXEC sp_executesql @SQL, 
        N'@BaslangicTarihi DATE, @BitisTarihi DATE',
        @BaslangicTarihi, @BitisTarihi;

    -----------------------------
    -- 3. Final Sorgu ve Filtreleme
    -----------------------------
    SET @SQL = '
    INSERT INTO #FinalResults (
        LOGICALREF, TigerCode, TigerName, TCKNO, TAXNR, 
        TigerBakiye, TigerBakiyeTuru, GoBakiye, GoBakiyeTuru
    )
    SELECT 
        PERF.LOGICALREF,
        PERF.CODE,
        PERF.DEFINITION_,
        PERF.TCKNO,
        PERF.TAXNR,
        CASE 
            WHEN LEFT(PERF.CODE, 3) = ''120'' THEN ROUND(PERF.DEBIT - PERF.CREDIT, 2)
            ELSE ROUND(PERF.CREDIT - PERF.DEBIT, 2)
        END,
        CASE 
            WHEN LEFT(PERF.CODE, 3) = ''120'' THEN ''B''
            ELSE ''A''
        END,
        CASE 
            WHEN LEFT(PERF.CODE, 3) = ''120'' THEN ROUND(GO.DEBIT - GO.CREDIT, 2)
            ELSE ROUND(GO.CREDIT - GO.DEBIT, 2)
        END,
        CASE 
            WHEN LEFT(PERF.CODE, 3) = ''120'' THEN ''B''
            ELSE ''A''
        END
    FROM #TigerCari PERF
    LEFT JOIN #GoCari GO ON GO.CODE = PERF.CODE
    WHERE (PERF.DEBIT > 0 OR PERF.CREDIT > 0) 
      AND PERF.LOGICALREF IS NOT NULL
      AND (@ContainsText IS NULL OR 
           PERF.CODE LIKE ''%'' + @ContainsText + ''%'' OR 
           PERF.DEFINITION_ LIKE ''%'' + @ContainsText + ''%'' OR
           PERF.TCKNO LIKE ''%'' + @ContainsText + ''%'' OR
           PERF.TAXNR LIKE ''%'' + @ContainsText + ''%'')
    ';

    EXEC sp_executesql @SQL, 
        N'@ContainsText NVARCHAR(200)',
        @ContainsText;

    -----------------------------
    -- 4. Sýralama ve Sayfalama
    -----------------------------
    -- Varsayýlan sýralama
    IF @SortExpression IS NULL OR @SortExpression = ''
        SET @SortExpression = 'TigerCode ASC';

    SET @SQL = '
    SELECT 
        LOGICALREF,
        TigerCode,
        TigerName,
        TCKNO,
        TAXNR,
        TigerBakiye,
        TigerBakiyeTuru,
        GoBakiye,
        GoBakiyeTuru
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (ORDER BY ' + @SortExpression + ') AS RowNum
        FROM #FinalResults
    ) AS Results
    WHERE RowNum BETWEEN @Skip + 1 AND @Skip + @Take
    ORDER BY RowNum;

    -- Toplam kayýt sayýsý
    SELECT COUNT(*) AS TotalCount FROM #FinalResults;
    ';

    EXEC sp_executesql @SQL, 
        N'@Skip INT, @Take INT',
        @Skip, @Take;

    -- Temizle
    DROP TABLE #TigerCari;
    DROP TABLE #GoCari;
    DROP TABLE #FinalResults;
END