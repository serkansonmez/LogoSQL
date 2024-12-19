alter FUNCTION dbo.fnYilAyGun
(
    @BaslangicTarihi DATETIME,
    @BitisTarihi DATETIME
)
RETURNS varchar(100)
AS
BEGIN
    DECLARE @Yil INT
    DECLARE @Ay INT
    DECLARE @Gun INT
    DECLARE @Sonuc VARCHAR(100)

    -- Y�l fark�n� hesapla
    SET @Yil = DATEDIFF(YEAR, @BaslangicTarihi, @BitisTarihi)

    -- E�er ba�lang�� tarihi ile biti� tarihi ayn� ayda de�ilse, g�n ve ay farklar�n� hesaba kat
    IF MONTH(@BaslangicTarihi) > MONTH(@BitisTarihi) OR 
       (MONTH(@BaslangicTarihi) = MONTH(@BitisTarihi) AND DAY(@BaslangicTarihi) > DAY(@BitisTarihi))
    BEGIN
        SET @Yil = @Yil - 1
    END

    -- Ay fark�n� hesapla
    SET @Ay = DATEDIFF(MONTH, @BaslangicTarihi, @BitisTarihi) - (@Yil * 12)

    -- G�n hesaplama
    SET @Gun = DAY(@BitisTarihi) - DAY(@BaslangicTarihi)

    -- E�er g�n negatifse, bir ay geri git
    IF @Gun < 0
    BEGIN
        SET @Ay = @Ay - 1  -- Ay� bir azalt
        -- Ge�mi� ay�n son g�n�n� al ve g�n fark�n� hesapla
        SET @Gun = DAY(EOMONTH(DATEADD(MONTH, -1, @BitisTarihi))) + DAY(@BitisTarihi) - DAY(@BaslangicTarihi)
    END

    -- Sonucu olu�tur
    IF (@Yil < 1)
    BEGIN
        SET @Yil = 0
    END
    IF (@Ay < 1)
    BEGIN
        SET @Ay = 0
    END
    IF (@Gun < 1)
    BEGIN
        SET @Gun = 0
    END
    
    SET @Sonuc = (' ' + CAST(@Yil AS VARCHAR(4)) + ' Y�l ' + CAST(@Ay AS VARCHAR(2)) + ' Ay ' + CAST(@Gun AS VARCHAR(2)) + ' G�n')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 Y�l', '')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 Ay', '')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 G�n', '')

    RETURN @Sonuc
END
