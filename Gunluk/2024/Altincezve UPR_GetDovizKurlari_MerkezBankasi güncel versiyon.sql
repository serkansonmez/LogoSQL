alter PROC [dbo].[UPR_GetDovizKurlari_MerkezBankasi]
    (@pYil SMALLINT, @pAy TINYINT, @pGun TINYINT)
AS
BEGIN
    DECLARE @url AS VARCHAR(8000)
    DECLARE @XmlYilAy NVARCHAR(6), @XmlTarih NVARCHAR(10)
    DECLARE @OBJ AS INT, @RESULT AS INT, @XML AS XML, @HDOC AS INT

    -- Tarih formatlama
    SET @XmlYilAy = RIGHT('0000' + CAST(@pYil AS VARCHAR(4)), 4) + RIGHT('00' + CAST(@pAy AS VARCHAR(2)), 2)
    SET @XmlTarih = RIGHT('00' + CAST(@pGun AS VARCHAR(2)), 2) + RIGHT('00' + CAST(@pAy AS VARCHAR(2)), 2) + RIGHT('0000' + CAST(@pYil AS VARCHAR(4)), 4)

    -- Tarih kontrolü ve URL ayarlama
    IF DATEFROMPARTS(@pYil, @pAy, @pGun) = DATEADD(DD, 0, DATEDIFF(DD, 0, GETDATE())) -- Bugünün tarihi ise
        SET @url = 'https://www.tcmb.gov.tr/kurlar/today.xml'
    ELSE
        SET @url = 'https://www.tcmb.gov.tr/kurlar/' + @XmlYilAy + '/' + @XmlTarih + '.xml'
    
    PRINT @url

    -- OLE Automation baþlatma
    EXEC @RESULT = SP_OACREATE 'MSXML2.XMLHTTP', @OBJ OUT
    EXEC @RESULT = SP_OAMETHOD @OBJ, 'open', NULL, 'GET', @url, FALSE
    EXEC @RESULT = SP_OAMETHOD @OBJ, 'send', NULL, ''

    -- Geçici tablo oluþturma
    IF OBJECT_ID('tempdb..#XML') IS NOT NULL DROP TABLE #XML

    CREATE TABLE #XML (STRXML VARCHAR(MAX))
    INSERT INTO #XML(STRXML)
    EXEC @RESULT = SP_OAGETPROPERTY @OBJ, 'responseXML.xml'

    -- XML'i okuma
    SELECT @XML = STRXML FROM #XML
    DROP TABLE #XML
 
    -- XML hazýrlanmasý
    EXEC SP_XML_PREPAREDOCUMENT @HDOC OUTPUT, @XML

    -- Eski verilerin silinmesi ve yeni verilerin eklenmesi
    DELETE FROM DovizKurlari WHERE Tarih = DATEFROMPARTS(@pYil, @pAy, @pGun)
    INSERT INTO DovizKurlari (Tarih, CrossOrder, Kod, CurrencyCode, UNIT, Isim, CurrencyName, ForexBuying, ForexSelling, BanknoteBuying, BanknoteSelling)
    SELECT DATEFROMPARTS(@pYil, @pAy, @pGun) AS Tarih,
           * FROM OPENXML(@HDOC, 'Tarih_Date/Currency')
                WITH (CrossOrder NVARCHAR(5), Kod VARCHAR(5), CurrencyCode NVARCHAR(5),
                      Unit VARCHAR(50) 'Unit',
                      Isim VARCHAR(100) 'Isim',
                      CurrencyName VARCHAR(100) 'CurrencyName',
                      ForexBuying FLOAT 'ForexBuying',
                      ForexSelling FLOAT 'ForexSelling',
                      BanknoteBuying FLOAT 'BanknoteBuying',
                      BanknoteSelling FLOAT 'BanknoteSelling')
 
    ---- XML belgesini ve OLE Automation nesnesini serbest býrakma
    --IF @HDOC IS NOT NULL
    --BEGIN
        EXEC SP_XML_REMOVEDOCUMENT @HDOC
    --END

    IF @OBJ IS NOT NULL
    BEGIN
        EXEC SP_OADestroy @OBJ
    END
END