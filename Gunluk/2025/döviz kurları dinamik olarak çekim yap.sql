DECLARE @RC int
DECLARE @pYil smallint
DECLARE @pAy tinyint
DECLARE @pGun tinyint
DECLARE @StartDate date = '2022-01-01' -- Baþlangýç tarihi
DECLARE @EndDate date = GETDATE()      -- Bugünün tarihi
DECLARE @CurrentDate date = @StartDate

WHILE @CurrentDate <= @EndDate
BEGIN
    -- Tarih bilgilerini güncelle
    SET @pYil = YEAR(@CurrentDate)
    SET @pAy = MONTH(@CurrentDate)
    SET @pGun = DAY(@CurrentDate)

    -- Stored Procedure'i çalýþtýr
    EXECUTE @RC = [dbo].[UPR_GetDovizKurlari_MerkezBankasi] 
       @pYil
      ,@pAy
      ,@pGun

    -- Bir sonraki güne geç
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
END
