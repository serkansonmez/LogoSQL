-- exec SP_UpdateGTIPCode_25
alter PROCEDURE SP_UpdateGTIPCode_25
AS
BEGIN
    -- Hata kontrolü için TRY-CATCH bloðu
    BEGIN TRY
        -- Geçici tablo oluþturuluyor
        CREATE TABLE #TempQry (
            QRY NVARCHAR(MAX)
        )

        -- Dinamik sorgu ile QRY sütunu oluþturulup geçici tabloya aktarýlýyor
        INSERT INTO #TempQry (QRY)
        SELECT 
            'UPDATE LG_025_01_ORFLINE SET GTIPCODE=''' + ITM.GTIPCODE + ''' WHERE LOGICALREF=' + CAST(ORF.LOGICALREF AS VARCHAR(20)) AS QRY
        FROM LG_025_01_ORFLINE ORF
        LEFT JOIN LG_025_ITEMS ITM ON ITM.LOGICALREF = ORF.STOCKREF
        WHERE ORF.GTIPCODE <> ITM.GTIPCODE AND LEN(ORF.GTIPCODE) > 1

        -- Geçici tablodaki her bir sorguyu döngüyle çalýþtýrýyoruz
        DECLARE @DynamicSQL NVARCHAR(MAX)

        DECLARE cur CURSOR FOR 
        SELECT QRY FROM #TempQry

        OPEN cur
        FETCH NEXT FROM cur INTO @DynamicSQL

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Dinamik SQL sorgusunu yürütüyoruz
             EXEC sp_executesql @DynamicSQL
		  -- select @DynamicSQL
            FETCH NEXT FROM cur INTO @DynamicSQL
        END

        CLOSE cur
        DEALLOCATE cur

        -- Geçici tablo siliniyor
        DROP TABLE #TempQry
    END TRY
    BEGIN CATCH
        -- Hata durumunda iþlem
        PRINT 'Bir hata oluþtu.'
        PRINT ERROR_MESSAGE()
    END CATCH
END
