---- Geçici tablo oluþtur
--CREATE TABLE TeknikResimKontrol (
--    LOGICALREF INT,
--    TeknikResimYolu NVARCHAR(255),
--    TeknikResimVarMi BIT
--);
-- exec SP_TeknikResimKontrolInsert
ALTER PROCEDURE SP_TeknikResimKontrolInsert as 
begin
truncate table TeknikResimKontrol
-- TeknikResim yolunu oluþtur ve kontrol et
DECLARE @DosyaYolu NVARCHAR(255), @DosyaVarMi INT, @LOGICALREF INT;

DECLARE DosyaKontrolCursor CURSOR FOR
SELECT 
    ORFLINE.LOGICALREF,
    '\\192.168.2.252\logo\UYGULAMALAR\TIGER3E\EMY\IMAGE\' + ITEMS.CODE + '.JPG' AS TeknikResimYolu
FROM 
    dbo.LG_024_01_ORFLINE AS ORFLINE
    INNER JOIN dbo.LG_024_ITEMS AS ITEMS ON ORFLINE.STOCKREF = ITEMS.LOGICALREF;

OPEN DosyaKontrolCursor;
FETCH NEXT FROM DosyaKontrolCursor INTO @LOGICALREF, @DosyaYolu;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Dosya var mý kontrol et
    EXEC master.dbo.xp_fileexist @DosyaYolu, @DosyaVarMi OUTPUT;

    -- Sonucu geçici tabloya ekle
    INSERT INTO TeknikResimKontrol (LOGICALREF, TeknikResimYolu, TeknikResimVarMi)
    VALUES (@LOGICALREF, @DosyaYolu, CASE WHEN @DosyaVarMi = 1 THEN 1 ELSE 0 END);

    FETCH NEXT FROM DosyaKontrolCursor INTO @LOGICALREF, @DosyaYolu;
END;

CLOSE DosyaKontrolCursor;
DEALLOCATE DosyaKontrolCursor;

end

select * from  TeknikResimKontrol