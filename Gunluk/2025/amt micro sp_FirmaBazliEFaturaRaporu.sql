alter view VW_MikroFirmalar as 
select DB_Guid,DB_KOD,DB_isim ,'MikroDB_V16_' + DB_KOD as DBTamIsmi  from MikroDB_V16..VERI_TABANLARI where DB_isim not LIKE '%DENEME%'



CREATE PROCEDURE sp_FirmaBazliEFaturaRaporu
    @BaslangicTarihi DATE,
    @BitisTarihi DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DBName NVARCHAR(128),
            @DBIsim NVARCHAR(128),
            @SQL NVARCHAR(MAX),
            @FinalSQL NVARCHAR(MAX) = '';

    DECLARE db_cursor CURSOR FOR
    SELECT DBTamIsmi, DB_isim
    FROM VW_MikroFirmalar;

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @DBName, @DBIsim;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = '
        SELECT 
            NEWID() AS KayitId,
            ''' + @DBIsim + ''' AS DB_isim,
            cha_belge_tarih AS BelgeTarihi,
            CASE 
                WHEN cha_evrak_tip in (55,56,61,63,68) THEN ''TEVKIFAT''
                WHEN MAX(cha_cinsi) = 8 THEN ''SATIS''
                ELSE ''Temel''
            END AS FaturaTuru,
            CASE 
                WHEN MAX(cha_tip) IN (6,7) THEN ''Temel''
                WHEN MAX(cha_tip) IN (0,1,2,3,4) THEN ''Ticari''
                ELSE ''Diðer''
            END AS FaturaTipi,
            CAST(MAX(cha_create_date) AS date) AS EvrakTarihi,
            cha_evrakno_seri AS EvrakSeri,
            cha_evrakno_sira AS EvrakSira,
            cha_belge_no AS EfaturaId,
            MAX(CARI_HESAPLAR.cari_unvan1) AS CariUnvani,
            SUM(cha_meblag) AS Yekun,
            CASE WHEN MAX(cha_d_cins) = 0 THEN ''TL'' END AS DovizCinsi
        FROM [' + @DBName + '].dbo.CARI_HESAP_HAREKETLERI WITH (NOLOCK, INDEX = NDX_CARI_HESAP_HAREKETLERI_00)
        LEFT JOIN [' + @DBName + '].dbo.CARI_HESAP_HAREKETLERI_EK WITH (NOLOCK) 
            ON chaek_related_uid = cha_Guid
        LEFT JOIN [' + @DBName + '].dbo.E_FATURA_DETAYLARI WITH (NOLOCK) 
            ON E_FATURA_DETAYLARI.efd_fat_uid = cha_Guid
        LEFT JOIN [' + @DBName + '].dbo.CARI_HESAPLAR WITH (NOLOCK) 
            ON CARI_HESAPLAR.cari_kod = cha_kod
        WHERE cha_belge_tarih BETWEEN @BaslangicTarihi AND @BitisTarihi
        GROUP BY 
            cha_belge_no,
            cha_evrakno_seri,
            cha_evrakno_sira,
            cha_belge_tarih,
            cha_evrak_tip
        ';

        SET @FinalSQL = @FinalSQL + @SQL + ' UNION ALL ';
        FETCH NEXT FROM db_cursor INTO @DBName, @DBIsim;
    END;

    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    -- Son UNION ALL'ý temizle
    SET @FinalSQL = LEFT(@FinalSQL, LEN(@FinalSQL) - 10);

    -- Dinamik SQL parametreli çaðýrma
    EXEC sp_executesql @FinalSQL,
        N'@BaslangicTarihi DATE, @BitisTarihi DATE',
        @BaslangicTarihi = @BaslangicTarihi,
        @BitisTarihi = @BitisTarihi;
END
