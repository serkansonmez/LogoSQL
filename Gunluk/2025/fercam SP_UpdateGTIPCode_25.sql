-- exec SP_UpdateGTIPCode_25
alter PROCEDURE SP_UpdateGTIPCode_25
AS
BEGIN
    -- Hata kontrol� i�in TRY-CATCH blo�u
    BEGIN TRY
        -- Ge�ici tablo olu�turuluyor
        CREATE TABLE #TempQry (
            QRY NVARCHAR(MAX)
        )

        -- Dinamik sorgu ile QRY s�tunu olu�turulup ge�ici tabloya aktar�l�yor
        INSERT INTO #TempQry (QRY)
        SELECT 
            'UPDATE LG_025_01_ORFLINE SET GTIPCODE=''' + ITM.GTIPCODE + ''' WHERE LOGICALREF=' + CAST(ORF.LOGICALREF AS VARCHAR(20)) AS QRY
        FROM LG_025_01_ORFLINE ORF
        LEFT JOIN LG_025_ITEMS ITM ON ITM.LOGICALREF = ORF.STOCKREF
        WHERE ORF.GTIPCODE <> ITM.GTIPCODE AND LEN(ORF.GTIPCODE) > 1

        -- Ge�ici tablodaki her bir sorguyu d�ng�yle �al��t�r�yoruz
        DECLARE @DynamicSQL NVARCHAR(MAX)

        DECLARE cur CURSOR FOR 
        SELECT QRY FROM #TempQry

        OPEN cur
        FETCH NEXT FROM cur INTO @DynamicSQL

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Dinamik SQL sorgusunu y�r�t�yoruz
             EXEC sp_executesql @DynamicSQL
		  -- select @DynamicSQL
            FETCH NEXT FROM cur INTO @DynamicSQL
        END

        CLOSE cur
        DEALLOCATE cur

        -- Ge�ici tablo siliniyor
        DROP TABLE #TempQry
    END TRY
    BEGIN CATCH
        -- Hata durumunda i�lem
        PRINT 'Bir hata olu�tu.'
        PRINT ERROR_MESSAGE()
    END CATCH
END
