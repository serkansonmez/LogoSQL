--DROP TABLE #TEMP_ORDERFICHE


DECLARE @LGSETREF INT=1
DECLARE @STARTDATE DATETIME='2018-01-01'
DECLARE @ENDDATE DATETIME='2019-12-31'

DECLARE @ORDFICHEREF INT
DECLARE @ORFLINEREF INT
DECLARE @CLIENTREF INT
DECLARE @SHIPINFOREF INT
DECLARE @BRANCH SMALLINT
DECLARE @SOURCEINDEX SMALLINT
DECLARE @ITEMREF INT
DECLARE @VARIANTREF INT
DECLARE @USREF INT
DECLARE @UOMREF INT
DECLARE @AMOUNT FLOAT
DECLARE @CONVFACT1 FLOAT
DECLARE @CONVFACT2 FLOAT

CREATE TABLE #TEMP_ORDERFICHE(LOGICALREF INT,STFICHEREF INT,FICHENO VARCHAR(20),CLIENTCODE VARCHAR(20),CLIENTNAME VARCHAR(500),BRANCHNAME VARCHAR(50),WHOUSENAME VARCHAR(50),ORDFICHEREF INT)

DECLARE ORFICHE_CURCOR CURSOR FOR
SELECT  ORF.LOGICALREF,ORF.CLIENTREF,ORF.SHIPINFOREF, ORF.BRANCH,ORF.SOURCEINDEX,
ORFL.LOGICALREF,ORFL.STOCKREF,ORFL.VARIANTREF,ORFL.USREF,ORFL.UOMREF,(ORFL.AMOUNT - ORFL.SHIPPEDAMOUNT) [AMOUNT],ORFL.UINFO1,ORFL.UINFO2
FROM [SSONMEZ].[GO3DB].[DBO].LG_221_01_ORFICHE ORF
INNER JOIN [SSONMEZ].[GO3DB].[DBO].LG_221_01_ORFLINE ORFL ON ORF.LOGICALREF = ORFL.ORDFICHEREF
LEFT OUTER JOIN ORDERLINE ORDL ON ORFL.LOGICALREF = ORDL.LGORFLINEREF
WHERE ORF.TRCODE = 1 AND ORF.[STATUS]=4 AND ORF.CANCELLED=0
AND ORFL.LINETYPE IN (0,1) AND ORFL.AMOUNT > ORFL.SHIPPEDAMOUNT AND ORFL.CANCELLED=0 AND ORFL.CLOSED=0 AND ORFL.[STATUS]=4 AND ORFL.STOCKREF IS NOT NULL
AND ORF.DATE_>=@STARTDATE AND ORF.DATE_<=@ENDDATE AND ORDL.LOGICALREF IS NULL
GROUP BY ORF.LOGICALREF, ORF.DATE_,ORF.TIME_,ORF.CLIENTREF,ORF.SHIPINFOREF, ORF.BRANCH,ORF.SOURCEINDEX,
ORFL.LOGICALREF,ORFL.STOCKREF,ORFL.VARIANTREF,ORFL.USREF,ORFL.UOMREF,ORFL.AMOUNT,ORFL.SHIPPEDAMOUNT,ORFL.UINFO1,ORFL.UINFO2
ORDER BY ORF.DATE_,ORF.TIME_

OPEN ORFICHE_CURCOR
FETCH NEXT FROM ORFICHE_CURCOR INTO @ORDFICHEREF,@CLIENTREF,@SHIPINFOREF,@BRANCH,@SOURCEINDEX,@ORFLINEREF,@ITEMREF,@VARIANTREF,@USREF,@UOMREF,@AMOUNT,@CONVFACT1,@CONVFACT2
WHILE @@FETCH_STATUS =0
BEGIN
DECLARE @ONHAND FLOAT=0
DECLARE @ORDERAMOUNT FLOAT=0

IF (@VARIANTREF=0)
BEGIN
SELECT @ONHAND=CAST(CAST(SUM(ISNULL(ONHAND,0))*(@CONVFACT1/@CONVFACT2) AS NUMERIC(28,6)) AS FLOAT) FROM [SSONMEZ].[GO3DB].[DBO].LV_221_01_STINVTOT WHERE STOCKREF=@ITEMREF AND VARIANTREF=0 AND INVENNO=@SOURCEINDEX

END
ELSE
BEGIN
  SELECT @ONHAND=CAST(CAST(SUM(ISNULL(ONHAND,0))*(@CONVFACT1/@CONVFACT2) AS NUMERIC(28,6)) AS FLOAT)  FROM [SSONMEZ].[GO3DB].[DBO].LV_221_01_VRNTINVTOT WHERE STOCKREF=@ITEMREF AND VARIANTREF=@VARIANTREF AND INVENNO=@SOURCEINDEX
END

SELECT @ORDERAMOUNT=CAST(CAST(ISNULL(SUM(ORDL.AMOUNT*(ORDL.CONVFACT2/ORDL.CONVFACT1)),0)*(@CONVFACT1/@CONVFACT2) AS NUMERIC(28,6)) AS FLOAT)
FROM ORDERFICHE ORDF
INNER JOIN ORDERLINE ORDL ON ORDF.LOGICALREF = ORDL.ORDERFICHEREF
WHERE ORDF.TRCODE IN (8) AND ORDF.[STATUS] IN (0,1,2,4,5,6,7) AND ORDF.SOURCEINDEX = @SOURCEINDEX AND ORDL.ITEMREF = @ITEMREF AND ORDL.VARIANTREF = @VARIANTREF

SET @ONHAND = @ONHAND-@ORDERAMOUNT
IF (@ONHAND>0 AND @ONHAND>=@AMOUNT)
BEGIN

DECLARE @STFICHEREF INT=0
                DECLARE @ORDERFICHEREF INT=0
DECLARE @IOCODE INT=4
DECLARE @TRCODE INT=8

SELECT @ORDERFICHEREF = LOGICALREF,@STFICHEREF=STFICHEREF FROM #TEMP_ORDERFICHE WHERE ORDFICHEREF = @ORDFICHEREF
IF (ISNULL(@ORDERFICHEREF,0)=0)
BEGIN
DECLARE @CLIENTCODE VARCHAR(20)
DECLARE @CLIENTNAME VARCHAR(500)
DECLARE @BRANCHNAME VARCHAR(50)
DECLARE @WHOUSENAME VARCHAR(50)

DECLARE @TODAY DATETIME =GETDATE()
DECLARE @FICHENO VARCHAR(20)
DECLARE @LASTFICHENO INT
DECLARE @MODULEREF INT=116
DECLARE @TERMINALMODULEREF SMALLINT=116
DECLARE @USERREF INT

DECLARE @AUTOTRANSFERPARAMETERREF INT=33
DECLARE @AUTOTRANSFER BIT
DECLARE @ORDERCONTROLPARAMETERREF INT
DECLARE @ORDERCONTROL BIT
DECLARE @PACKINGPARAMETERREF INT
DECLARE @PACKING BIT
DECLARE @LINEUNITPARAMETERREF INT
DECLARE @TRANSFERUNIT INT
                 
SELECT @AUTOTRANSFER=ISNULL(CONVERT(BIT,VALUE),0) FROM ORDER_PARAMETER WHERE PARAMETERREF = @AUTOTRANSFERPARAMETERREF

--CREATE FICHENO
EXEC PRO_FICHENO_CREATE @MODULEREF,@LASTFICHENO OUTPUT
SET @FICHENO = SUBSTRING ('000000',0,7-LEN(@LASTFICHENO)) + CONVERT(VARCHAR,@LASTFICHENO)

--INSERT ORDERFICHE
INSERT INTO ORDERFICHE (FICHENO,DATE_,DISPATCHNO,TRCODE,IOCODE,[STATUS],BRANCH,SOURCEINDEX,DESTBRANCH,DESTINDEX,CLIENTREF,SHIPINFOREF,TRANSREF,LGSETREF,NOTES,SHIPTYPE,AUTOTRANSFER)
VALUES (@FICHENO,@TODAY,NULL,@TRCODE,@IOCODE,0,@BRANCH,@SOURCEINDEX,NULL,NULL,@CLIENTREF,@SHIPINFOREF,NULL,@LGSETREF,NULL,2,@AUTOTRANSFER)
SELECT @ORDERFICHEREF=@@IDENTITY

--INSERT ORDERFICHE TERMINALS
INSERT INTO ORDERFICHE_TERMINAL (ORDERFICHEREF,TERMINALREF)
SELECT @ORDERFICHEREF,T.LOGICALREF
FROM TERMINAL_ROLE_MODULE TRM
INNER JOIN TERMINAL T ON TRM.TERMINALROLEREF = T.TERMINALROLEREF
INNER JOIN TERMINAL_BRANCH TB ON TRM.TERMINALROLEREF = TB.TERMINALROLEREF AND TB.BRANCH = @BRANCH AND TB.ISSOURCE=1
INNER JOIN TERMINAL_WHOUSE TS ON TRM.TERMINALROLEREF = TS.TERMINALROLEREF AND TS.WHOUSE = @SOURCEINDEX AND TS.ISSOURCE=1
WHERE TRM.TERMINALMODULEREF =@TERMINALMODULEREF

--INSERT STFICHE
INSERT INTO STFICHE (ORDERFICHEREF,CNTFICHEREF,CLIENTREF,SHIPINFOREF,QUEUENR,TRCODE,IOCODE,BRANCH,SOURCEINDEX,DESTBRANCH,DESTINDEX,LGFICHEREF,ISTRANSFERED,ISORDERCLIENT)
VALUES (@ORDERFICHEREF,NULL,@CLIENTREF,@SHIPINFOREF,NULL,@TRCODE,@IOCODE,@BRANCH,@SOURCEINDEX,NULL,NULL,NULL,0,1)
SELECT @STFICHEREF=@@IDENTITY

--INSERT LOG
SELECT @USERREF = LOGICALREF FROM [USER] WHERE ISSYSTEM=1
INSERT INTO RECORD_LOG (MODULEREF,RECORDID,IDENTITYINFO,USERREF,TERMINALREF,PROCESSDATE,[TYPE],[DESCRIPTION])
VALUES (@MODULEREF,@ORDERFICHEREF,'Fi� Numaras�:'+' '+@FICHENO,@USERREF,NULL,GETDATE(),4,NULL)

--TEMP INSERT
SELECT @CLIENTCODE = CODE,@CLIENTNAME = DEFINITION_ FROM [SSONMEZ].[GO3DB].[DBO].LG_221_CLCARD WHERE LOGICALREF=@CLIENTREF
SELECT @BRANCHNAME = [NAME] FROM [SSONMEZ].[GO3DB].[DBO].L_CAPIDIV WHERE FIRMNR=221 AND NR=@BRANCH
SELECT @WHOUSENAME = [NAME] FROM [SSONMEZ].[GO3DB].[DBO].L_CAPIWHOUSE WHERE FIRMNR=221 AND NR=@SOURCEINDEX

INSERT INTO #TEMP_ORDERFICHE(LOGICALREF,STFICHEREF,FICHENO,CLIENTCODE,CLIENTNAME,BRANCHNAME,WHOUSENAME,ORDFICHEREF)
VALUES (@ORDERFICHEREF,@STFICHEREF,@FICHENO,@CLIENTCODE,@CLIENTNAME,@BRANCHNAME,@WHOUSENAME,@ORDFICHEREF)
END

                --INSERT ORDERLINE
                INSERT INTO ORDERLINE(ORDERFICHEREF,STFICHEREF,CLIENTREF,TRCODE,IOCODE,BRANCH,SOURCEINDEX,ITEMREF,VARIANTREF,AMOUNT,USREF,UOMREF,CONVFACT1,CONVFACT2,LGORFLINEREF,LGSHIPINFOREF,LGORFICHEREF,PROCESSDATE,LGSETREF)
                SELECT @ORDERFICHEREF,@STFICHEREF,@CLIENTREF,@TRCODE,@IOCODE,@BRANCH,@SOURCEINDEX,@ITEMREF,@VARIANTREF,@AMOUNT,@USREF,@UOMREF,@CONVFACT1,@CONVFACT2,@ORFLINEREF,@SHIPINFOREF,@ORDFICHEREF,GETDATE(),@LGSETREF
END
FETCH NEXT FROM ORFICHE_CURCOR INTO @ORDFICHEREF,@CLIENTREF,@SHIPINFOREF,@BRANCH,@SOURCEINDEX,@ORFLINEREF,@ITEMREF,@VARIANTREF,@USREF,@UOMREF,@AMOUNT,@CONVFACT1,@CONVFACT2
END
CLOSE ORFICHE_CURCOR
DEALLOCATE ORFICHE_CURCOR

SELECT * FROM #TEMP_ORDERFICHE
DROP TABLE #TEMP_ORDERFICHE