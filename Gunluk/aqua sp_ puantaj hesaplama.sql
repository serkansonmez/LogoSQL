USE [PodyumSoft_Default_v1]
GO
/****** Object:  StoredProcedure [dbo].[UpdatePuantajForLongHours]    Script Date: 29.06.2024 14:07:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UpdatePuantajForLongHours]
AS
BEGIN
    -- Declare variables
    DECLARE @Yil INT;
    DECLARE @Ay INT;
    DECLARE @PersonelId INT;
    DECLARE @Gun INT;
    
    -- Cursor to loop through the records where FarkSaat is greater than 5
    DECLARE PuantajCursor CURSOR FOR
    SELECT 
        YEAR(GirisTarihSaat) AS Yil,
        MONTH(GirisTarihSaat) AS Ay,
        PersonelId,
        DAY(GirisTarihSaat) AS Gun
    FROM 
        VW_GunlukPuantajListesi
    WHERE 
        FarkSaat > 5;
    
    -- Open cursor
    OPEN PuantajCursor;
    
    -- Fetch the first row from the cursor
    FETCH NEXT FROM PuantajCursor INTO @Yil, @Ay, @PersonelId, @Gun;
    
    -- Loop through the cursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Update the relevant Gun column in the PersonelPuantaj table
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = N'UPDATE PersonelPuantaj
                    SET Gun' + RIGHT('0' + CAST(@Gun AS NVARCHAR(2)), 2) + ' = 1
                    WHERE Yil = @Yil AND Ay = @Ay AND PersonelId = @PersonelId';
        
        EXEC sp_executesql @SQL, N'@Yil INT, @Ay INT, @PersonelId INT', @Yil, @Ay, @PersonelId;
        
        -- Fetch the next row from the cursor
        FETCH NEXT FROM PuantajCursor INTO @Yil, @Ay, @PersonelId, @Gun;
    END;
    
    -- Close and deallocate the cursor
    CLOSE PuantajCursor;
    DEALLOCATE PuantajCursor;
END;


--select * from PersonelPuantajTurleri