DECLARE @RC int
DECLARE @pYil smallint
DECLARE @pAy tinyint
DECLARE @pGun tinyint
DECLARE @StartDate date = '2022-01-01' -- Ba�lang�� tarihi
DECLARE @EndDate date = GETDATE()      -- Bug�n�n tarihi
DECLARE @CurrentDate date = @StartDate

WHILE @CurrentDate <= @EndDate
BEGIN
    -- Tarih bilgilerini g�ncelle
    SET @pYil = YEAR(@CurrentDate)
    SET @pAy = MONTH(@CurrentDate)
    SET @pGun = DAY(@CurrentDate)

    -- Stored Procedure'i �al��t�r
    EXECUTE @RC = [dbo].[UPR_GetDovizKurlari_MerkezBankasi] 
       @pYil
      ,@pAy
      ,@pGun

    -- Bir sonraki g�ne ge�
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate)
END
