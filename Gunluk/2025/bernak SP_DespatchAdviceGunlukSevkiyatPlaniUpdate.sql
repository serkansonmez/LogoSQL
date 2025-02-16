-- exec SP_DespatchAdviceGunlukSevkiyatPlaniUpdate

create PROCEDURE SP_DespatchAdviceGunlukSevkiyatPlaniUpdate
AS
BEGIN
    SET NOCOUNT ON;

    -- TeslimatDurumu 'Baþlamadý' olmayan kayýtlarý belirle
    DECLARE @GunlukSevkiyatPlaniId INT, @IrsaliyeNo NVARCHAR(50), @DespatchAdviceID INT;

    DECLARE cur CURSOR FOR
    SELECT tblDevamEden.ID, tblDevamEden.IrsaliyeNo 
    FROM VW_GunlukSevkiyatPlaniValeo tblDevamEden 
	left join VW_GunlukSevkiyatPlaniValeo tblBaslamamis on tblBaslamamis.IrsaliyeNo = tblDevamEden.IrsaliyeNo and tblBaslamamis.TeslimatDurumu = 'Baþlamadý' 
    WHERE tblDevamEden.TeslimatDurumu <> 'Baþlamadý' and tblBaslamamis.Id is not null

    OPEN cur;
    FETCH NEXT FROM cur INTO @GunlukSevkiyatPlaniId, @IrsaliyeNo;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 'Baþlamadý' olan kayýtlar içinde ayný irsaliye numarasýný bul
        SELECT TOP 1 @DespatchAdviceID = ID 
        FROM VW_GunlukSevkiyatPlaniValeo 
        WHERE TeslimatDurumu = 'Baþlamadý' AND IrsaliyeNo = @IrsaliyeNo;

        -- Eðer eþleþen bir kayýt bulunduysa güncelle
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
