-- exec SP_DespatchAdviceGunlukSevkiyatPlaniUpdate

create PROCEDURE SP_DespatchAdviceGunlukSevkiyatPlaniUpdate
AS
BEGIN
    SET NOCOUNT ON;

    -- TeslimatDurumu 'Ba�lamad�' olmayan kay�tlar� belirle
    DECLARE @GunlukSevkiyatPlaniId INT, @IrsaliyeNo NVARCHAR(50), @DespatchAdviceID INT;

    DECLARE cur CURSOR FOR
    SELECT tblDevamEden.ID, tblDevamEden.IrsaliyeNo 
    FROM VW_GunlukSevkiyatPlaniValeo tblDevamEden 
	left join VW_GunlukSevkiyatPlaniValeo tblBaslamamis on tblBaslamamis.IrsaliyeNo = tblDevamEden.IrsaliyeNo and tblBaslamamis.TeslimatDurumu = 'Ba�lamad�' 
    WHERE tblDevamEden.TeslimatDurumu <> 'Ba�lamad�' and tblBaslamamis.Id is not null

    OPEN cur;
    FETCH NEXT FROM cur INTO @GunlukSevkiyatPlaniId, @IrsaliyeNo;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 'Ba�lamad�' olan kay�tlar i�inde ayn� irsaliye numaras�n� bul
        SELECT TOP 1 @DespatchAdviceID = ID 
        FROM VW_GunlukSevkiyatPlaniValeo 
        WHERE TeslimatDurumu = 'Ba�lamad�' AND IrsaliyeNo = @IrsaliyeNo;

        -- E�er e�le�en bir kay�t bulunduysa g�ncelle
        IF @DespatchAdviceID IS NOT NULL
        BEGIN
            UPDATE DespatchAdvice
            SET GunlukSevkiyatPlaniId = @GunlukSevkiyatPlaniId
            WHERE ID = @DespatchAdviceID;
        END

        FETCH NEXT FROM cur INTO @GunlukSevkiyatPlaniId, @IrsaliyeNo;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;
