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
CONVERT(VARCHAR, CTRNS.DATE_, 103) AS 'Fi� Tarihi',
CTRNS.TRANNO AS 'Fi� No',
CASE
WHEN CTRNS.TRCODE = 1 THEN 'Nakit tahsilat'
WHEN CTRNS.TRCODE = 2 THEN 'Nakit �deme'
WHEN CTRNS.TRCODE = 3 THEN 'Bor� dekontu'
WHEN CTRNS.TRCODE = 4 THEN 'Alacak dekontu'
WHEN CTRNS.TRCODE = 5 THEN 'Virman i�lemi'
WHEN CTRNS.TRCODE = 6 THEN 'Kur fark� i�lemi'
WHEN CTRNS.TRCODE = 12 THEN '�zel i�lem'
WHEN CTRNS.TRCODE = 14 THEN 'Devir fi�i'
WHEN CTRNS.TRCODE = 20 THEN 'Gelen havale'
WHEN CTRNS.TRCODE = 21 THEN 'G�nderilen havale'
WHEN CTRNS.TRCODE = 31 THEN 'Mal al�m faturas�'
WHEN CTRNS.TRCODE = 32 THEN 'Perakende sat�� iade faturas�'
WHEN CTRNS.TRCODE = 33 THEN 'Toptan sat�� iade faturas�'
WHEN CTRNS.TRCODE = 34 THEN 'Al�nan hizmet faturas�'
WHEN CTRNS.TRCODE = 35 THEN 'Nakit tahsilat'
WHEN CTRNS.TRCODE = 36 THEN 'Al�m iade faturas�'
WHEN CTRNS.TRCODE = 37 THEN 'Perakende sat�� faturas�'
WHEN CTRNS.TRCODE = 38 THEN 'Toptan sat�� faturas�'
WHEN CTRNS.TRCODE = 39 THEN 'Verilen hizmet faturas�'
WHEN CTRNS.TRCODE = 40 THEN 'Verilen proforma faturas�'
WHEN CTRNS.TRCODE = 41 THEN 'Verilen vade fark� faturas�'
WHEN CTRNS.TRCODE = 42 THEN 'Al�nan vade fark� faturas�'
WHEN CTRNS.TRCODE = 43 THEN 'Al�nan fiyat fark� faturas�'
WHEN CTRNS.TRCODE = 44 THEN 'Verilen fiyat fark� faturas�'
WHEN CTRNS.TRCODE = 46 THEN 'Al�nan serbes meslek makbuzu'
WHEN CTRNS.TRCODE = 56 THEN '56:M�stahsil makbuzu'
WHEN CTRNS.TRCODE = 61 THEN '�ek giri�i'
WHEN CTRNS.TRCODE = 62 THEN 'Senet giri�i'
WHEN CTRNS.TRCODE = 63 THEN '�ek ��k�� cari hesaba'
WHEN CTRNS.TRCODE = 64 THEN 'Senet ��k�� cari hesaba'
WHEN CTRNS.TRCODE = 70 THEN 'Kredi kart� fi�i'
WHEN CTRNS.TRCODE = 71 THEN 'Kredi kart� iade fi�i'
WHEN CTRNS.TRCODE = 72 THEN 'Firma kredi kart� fi�i'
WHEN CTRNS.TRCODE = 73 THEN 'Firma kredi kart� iade fi�i'
END AS 'Fi� T�r�',
--CLNTC.DEFINITION_ AS '�nvan',
CASE WHEN CLFIC.GENEXP1 IS NULL THEN ''
ELSE
CLFIC.GENEXP1 END AS 'A��klama',
BC.Amount_B AS 'Bor�',
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
LEFT OUTER JOIN LG_002_PAYPLANS PAYPL WITH(NOLOCK) ON (CTRNS.PAYDEFREF = PAYPL.LOGICALREF)     -- �deme Hareketleri
LEFT OUTER JOIN LG_002_01_CLFICHE CLFIC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = CLFIC.LOGICALREF)  -- Cari Hesap Fi�leri
LEFT OUTER JOIN LG_002_01_INVOICE INVFC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = INVFC.LOGICALREF)  -- Sat�n Alma Hareketleri
LEFT OUTER JOIN LG_002_01_CSROLL RLFIC WITH(NOLOCK) ON (CTRNS.SOURCEFREF = RLFIC.LOGICALREF)   -- �ek Senet Hareketleri
LEFT OUTER JOIN LG_002_01_EMFICHE GLFIC WITH(NOLOCK) ON (CTRNS.ACCFICHEREF = GLFIC.LOGICALREF) -- Muhasebe Fi�leri
LEFT OUTER JOIN LG_002_CLCARD CLNTC WITH(NOLOCK) ON (CTRNS.CLIENTREF = CLNTC.LOGICALREF)	   -- Cari Hesap Kartlar�
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


