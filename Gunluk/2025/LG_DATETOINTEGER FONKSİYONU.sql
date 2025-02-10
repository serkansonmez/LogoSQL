select dbo.fn_LogoDatetoSystemDate(date_),  dbo.[LG_DATETOINTEGER](EDATE),* from LG_EXCHANGE_025 where EDATE = '20250129' 


SELECT * FROM FercamB2B_Default_v1..DOVIZKURLARI WHERE Tarih ='20250129'


 
CREATE FUNCTION [dbo].[LG_DATETOINTEGER] (@Tarih DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @YYYY INT = YEAR(@Tarih)
    DECLARE @MM   INT = MONTH(@Tarih)
    DECLARE @DD   INT = DAY(@Tarih)

    RETURN (@YYYY * 65536) + (@MM * 256) + @DD
END