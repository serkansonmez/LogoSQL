CREATE FUNCTION fn_LogoDatetoSystemDate (@DEGER INT) 
RETURNS datetime
AS
BEGIN
DECLARE @GUN VARCHAR(2), @AY VARCHAR(2), @YIL VARCHAR(4)
DECLARE @SONUC datetime
SELECT
@GUN=CAST((CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)-(CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)/256*256)) AS VARCHAR(3))
SELECT
@AY=CAST(((CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)-(65536*(CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)/65536)))-(CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)-(CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)/256*256)))/256 AS VARCHAR(3))
SELECT
@YIL=CAST((CONVERT(INT,CONVERT(BINARY,@DEGER,2),0)/65536) AS VARCHAR(6))
SET @GUN=CASE WHEN LEN(@GUN)<2 THEN '0'+@GUN ELSE @GUN END
SET @AY=CASE WHEN LEN(@AY)<2 THEN '0'+@AY ELSE @AY END
SONUC:
IF @DEGER<>0
BEGIN
SET @SONUC=CONVERT(DATETIME, @YIL + '-' + @AY + '-' + @GUN + ' 00:00:00', 102)
END
IF @DEGER=0
SET @SONUC= NULL
RETURN @SONUC
END