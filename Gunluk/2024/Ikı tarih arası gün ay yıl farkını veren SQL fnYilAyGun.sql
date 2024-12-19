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

    -- Yýl farkýný hesapla
    SET @Yil = DATEDIFF(YEAR, @BaslangicTarihi, @BitisTarihi)

    -- Eðer baþlangýç tarihi ile bitiþ tarihi ayný ayda deðilse, gün ve ay farklarýný hesaba kat
    IF MONTH(@BaslangicTarihi) > MONTH(@BitisTarihi) OR 
       (MONTH(@BaslangicTarihi) = MONTH(@BitisTarihi) AND DAY(@BaslangicTarihi) > DAY(@BitisTarihi))
    BEGIN
        SET @Yil = @Yil - 1
    END

    -- Ay farkýný hesapla
    SET @Ay = DATEDIFF(MONTH, @BaslangicTarihi, @BitisTarihi) - (@Yil * 12)

    -- Gün hesaplama
    SET @Gun = DAY(@BitisTarihi) - DAY(@BaslangicTarihi)

    -- Eðer gün negatifse, bir ay geri git
    IF @Gun < 0
    BEGIN
        SET @Ay = @Ay - 1  -- Ayý bir azalt
        -- Geçmiþ ayýn son gününü al ve gün farkýný hesapla
        SET @Gun = DAY(EOMONTH(DATEADD(MONTH, -1, @BitisTarihi))) + DAY(@BitisTarihi) - DAY(@BaslangicTarihi)
    END

    -- Sonucu oluþtur
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
    
    SET @Sonuc = (' ' + CAST(@Yil AS VARCHAR(4)) + ' Yýl ' + CAST(@Ay AS VARCHAR(2)) + ' Ay ' + CAST(@Gun AS VARCHAR(2)) + ' Gün')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 Yýl', '')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 Ay', '')
    SET @Sonuc = REPLACE(@Sonuc, ' 0 Gün', '')

    RETURN @Sonuc
END
