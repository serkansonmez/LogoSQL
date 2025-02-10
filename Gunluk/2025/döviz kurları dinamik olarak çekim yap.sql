DECLARE @RC int
DECLARE @pYil smallint
DECLARE @pAy tinyint
DECLARE @pGun tinyint
DECLARE @StartDate date = getdate() -- '2023-06-23' -- Ba�lang�� tarihi
DECLARE @EndDate date = @StartDate      -- Bug�n�n tarihi
DECLARE @CurrentDate date = @StartDate

WHILE @CurrentDate <= @EndDate
BEGIN
    -- Tarih bilgilerini g�ncelle
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
    
		-- Hata mesaj�n� d�nd�r
		THROW;
	END CATCH

    -- Bir sonraki g�ne ge�
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
END
-- select * from ErrorLog