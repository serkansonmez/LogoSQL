DECLARE @RC int
DECLARE @pYil smallint
DECLARE @pAy tinyint
DECLARE @pGun tinyint
DECLARE @StartDate date = getdate() -- '2023-06-23' -- Baþlangýç tarihi
DECLARE @EndDate date = @StartDate      -- Bugünün tarihi
DECLARE @CurrentDate date = @StartDate

WHILE @CurrentDate <= @EndDate
BEGIN
    -- Tarih bilgilerini güncelle
    SET @pYil = YEAR(@CurrentDate)
    SET @pAy = MONTH(@CurrentDate)
    SET @pGun = DAY(@CurrentDate)

   BEGIN TRY
		EXECUTE @RC = [dbo].[UPR_GetDovizKurlari_MerkezBankasi] 
		   @pYil
		  ,@pAy
		  ,@pGun
	END TRY
	BEGIN CATCH
		-- Hata bilgilerini logla
		INSERT INTO ErrorLog (ErrorNumber, ErrorMessage, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorTime)
		VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), GETDATE());
    
		-- Hata mesajýný döndür
		THROW;
	END CATCH

    -- Bir sonraki güne geç
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
END
-- select * from ErrorLog