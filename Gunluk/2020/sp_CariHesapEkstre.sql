USE [TIGER3]
GO

/****** Object:  StoredProcedure [dbo].[sp_CariHesapEkstre]    Script Date: 19.10.2020 21:52:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_CariHesapEkstre]
@CariKodu AS VARCHAR(200), 
@BaslangicTarihi AS DATETIME, 
@BitisTarihi AS DATETIME
AS 

DECLARE
@Sign AS INT,
@Amount AS FLOAT,
@Amount_A AS FLOAT,
@Amount_B AS FLOAT,
@RowCount AS INT,
@Counter AS INT = 1,
@Logicalref AS INT,
@Balance AS FLOAT,
@CariID AS INT,
@CheckBalance AS FLOAT
SET @CariID = (SELECT LOGICALREF FROM LG_002_CLCARD WHERE CODE = @CariKodu)
DELETE [eflow].[dbo].[BalanceControl]
INSERT INTO eflow.dbo.BalanceControl
(RowID,Sign,Amount,LogicalRef,ClientRef)
(SELECT 
ROW_NUMBER() OVER(ORDER BY CLF.DATE_, CLF.CAPIBLOCK_CREADEDDATE) AS ID,
CLF.SIGN,
CLF.AMOUNT,
CLF.LOGICALREF,
CLF.CLIENTREF
FROM LG_002_01_CLFLINE CLF
WHERE CLF.CLIENTREF=@CariID AND CLF.CANCELLED=0)

SET @RowCount = (SELECT Count(RowID) From eflow.dbo.BalanceControl WHERE ClientRef =@CariID)

WHILE (@Counter<@RowCount+1)
BEGIN
SET @Sign = (SELECT Sign From eflow.dbo.BalanceControl WHERE ClientRef =@CariID And RowID=@Counter)
SET @Amount = (SELECT ISNULL(Amount,0) From eflow.dbo.BalanceControl WHERE ClientRef =@CariID And RowID=@Counter)
IF @Sign = 0
BEGIN

UPDATE eflow.dbo.BalanceControl 
SET Amount_A=0, Amount_B=ISNULL(@Amount,0)
WHERE ClientRef = @CariID And RowID = @Counter

SET @CheckBalance=(ISNULL((SELECT SUM(ISNULL(Amount_A,0)) From eflow.dbo.BalanceControl WHERE ClientRef=@CariID),0) - (ISNULL((SELECT SUM(ISNULL(Amount_B,0)) From eflow.dbo.BalanceControl WHERE ClientRef =@CariID),0)))

IF @CheckBalance < 0
SET @Balance =  @CheckBalance
ELSE IF @CheckBalance > 0
SET @Balance = @CheckBalance 
ELSE
SET @Balance =  @CheckBalance

UPDATE eflow.dbo.BalanceControl 
SET Balance =  ISNULL(@Balance,0) 
WHERE ClientRef = @CariID And RowID = @Counter

END 
ELSE 
BEGIN

UPDATE eflow.dbo.BalanceControl
SET Amount_B=0, Amount_A=ISNULL(@Amount,0)
WHERE ClientRef = @CariID And RowID = @Counter

SET @CheckBalance=(ISNULL((SELECT SUM(ISNULL(Amount_A,0)) From eflow.dbo.BalanceControl WHERE ClientRef=@CariID) ,0) - (ISNULL((SELECT SUM(ISNULL(Amount_B,0)) From eflow.dbo.BalanceControl WHERE ClientRef =@CariID),0) ))--ISNULL(@Amount_B,0)) 

IF @CheckBalance < 0
SET @Balance =  @CheckBalance 
ELSE IF @CheckBalance > 0
SET @Balance =  @CheckBalance 
ELSE
SET @Balance = @CheckBalance

UPDATE eflow.dbo.BalanceControl
SET Balance= ISNULL(@Balance,0) 
WHERE ClientRef = @CariID And RowID = @Counter

END
SET @Counter = @Counter+1
END

SELECT 
CONVERT(VARCHAR, CTRNS.DATE_, 103) AS 'Fiþ Tarihi',
CTRNS.TRANNO AS 'Fiþ No',
CASE
WHEN CTRNS.TRCODE = 1 THEN 'Nakit tahsilat'
WHEN CTRNS.TRCODE = 2 THEN 'Nakit ödeme'
WHEN CTRNS.TRCODE = 3 THEN 'Borç dekontu'
WHEN CTRNS.TRCODE = 4 THEN 'Alacak dekontu'
WHEN CTRNS.TRCODE = 5 THEN 'Virman iþlemi'
WHEN CTRNS.TRCODE = 6 THEN 'Kur farký iþlemi'
WHEN CTRNS.TRCODE = 12 THEN 'Özel iþlem'
WHEN CTRNS.TRCODE = 14 THEN 'Devir fiþi'
WHEN CTRNS.TRCODE = 20 THEN 'Gelen havale'
WHEN CTRNS.TRCODE = 21 THEN 'Gönderilen havale'
WHEN CTRNS.TRCODE = 31 THEN 'Mal alým faturasý'
WHEN CTRNS.TRCODE = 32 THEN 'Perakende satýþ iade faturasý'
WHEN CTRNS.TRCODE = 33 THEN 'Toptan satýþ iade faturasý'
WHEN CTRNS.TRCODE = 34 THEN 'Alýnan hizmet faturasý'
WHEN CTRNS.TRCODE = 35 THEN 'Nakit tahsilat'
WHEN CTRNS.TRCODE = 36 THEN 'Alým iade faturasý'
WHEN CTRNS.TRCODE = 37 THEN 'Perakende satýþ faturasý'
WHEN CTRNS.TRCODE = 38 THEN 'Toptan satýþ faturasý'
WHEN CTRNS.TRCODE = 39 THEN 'Verilen hizmet faturasý'
WHEN CTRNS.TRCODE = 40 THEN 'Verilen proforma faturasý'
WHEN CTRNS.TRCODE = 41 THEN 'Verilen vade farký faturasý'
WHEN CTRNS.TRCODE = 42 THEN 'Alýnan vade farký faturasý'
WHEN CTRNS.TRCODE = 43 THEN 'Alýnan fiyat farký faturasý'
WHEN CTRNS.TRCODE = 44 THEN 'Verilen fiyat farký faturasý'
WHEN CTRNS.TRCODE = 46 THEN 'Alýnan serbes meslek makbuzu'
WHEN CTRNS.TRCODE = 56 THEN '56:Müstahsil makbuzu'
WHEN CTRNS.TRCODE = 61 THEN 'Çek giriþi'
WHEN CTRNS.TRCODE = 62 THEN 'Senet giriþi'
WHEN CTRNS.TRCODE = 63 THEN 'Çek çýkýþ cari hesaba'
WHEN CTRNS.TRCODE = 64 THEN 'Senet çýkýþ cari hesaba'
WHEN CTRNS.TRCODE = 70 THEN 'Kredi kartý fiþi'
WHEN CTRNS.TRCODE = 71 THEN 'Kredi kartý iade fiþi'
WHEN CTRNS.TRCODE = 72 THEN 'Firma kredi kartý fiþi'
WHEN CTRNS.TRCODE = 73 THEN 'Firma kredi kartý iade fiþi'
END AS 'Fiþ Türü',
--CLNTC.DEFINITION_ AS 'Ünvan',
CASE WHEN CLFIC.GENEXP1 IS NULL THEN ''
ELSE
CLFIC.GENEXP1 END AS 'Açýklama',
BC.Amount_B AS 'Borç',
BC.Amount_A AS 'Alacak',
CONVERT(VARCHAR,BC.Balance) AS 'Bakiye',
CASE 
WHEN BC.Balance<0
THEN 'B'
WHEN BC.BALANCE>0 
THEN 'A'
WHEN BC.Balance<0
THEN ''
END AS 'A\B'
FROM 
LG_002_01_CLFLINE CTRNS WITH(NOLOCK)
LEFT OUTER JOIN LG_002_PAYPLANS PAYPL WITH(NOLOCK) ON (CTRNS.PAYDEFREF = PAYPL.LOGICALREF)     -- Ödeme Hareketleri
LEFT OUTER JOIN LG_002_01_CLFICHE CLFIC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = CLFIC.LOGICALREF)  -- Cari Hesap Fiþleri
LEFT OUTER JOIN LG_002_01_INVOICE INVFC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = INVFC.LOGICALREF)  -- Satýn Alma Hareketleri
LEFT OUTER JOIN LG_002_01_CSROLL RLFIC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = RLFIC.LOGICALREF)   -- Çek Senet Hareketleri
LEFT OUTER JOIN LG_002_01_EMFICHE GLFIC WITH(NOLOCK) ON (CTRNS.ACCFICHEREF = GLFIC.LOGICALREF) -- Muhasebe Fiþleri
LEFT OUTER JOIN LG_002_CLCARD CLNTC WITH(NOLOCK) ON (CTRNS.CLIENTREF = CLNTC.LOGICALREF)	   -- Cari Hesap Kartlarý
LEFT OUTER JOIN LG_002_PURCHOFFER POFFER WITH(NOLOCK) ON (CTRNS.OFFERREF = POFFER.LOGICALREF)
LEFT OUTER JOIN [eflow].[dbo].[BalanceControl] BC WITH(NOLOCK) ON (CTRNS.LOGICALREF=BC.Logicalref and CTRNS.CLIENTREF = BC.ClientRef) -- Bakiye
WHERE 
(CTRNS.BRANCH IN (0))
AND (CTRNS.CANCELLED=0) 
AND (CTRNS.DEPARTMENT IN (0)) 
AND (CTRNS.TRCODE IN (31, 32, 33, 34, 36, 37, 38, 39, 43, 44, 56, 1, 2, 3, 4, 5, 6, 12, 14, 41, 42, 45, 46, 70, 71, 72, 73, 20, 21, 24, 25, 28, 29, 30, 61, 62, 63, 64, 75,81, 82)) 
AND (CTRNS.CLIENTREF = @CariID) 
AND (CTRNS.DATE_  >= @BaslangicTarihi AND CTRNS.DATE_  <=  @BitisTarihi)

ORDER BY 
 CTRNS.DATE_, CTRNS.CAPIBLOCK_CREADEDDATE 
GO


