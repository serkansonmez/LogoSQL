SELECT
LOGICALREF,
CODE AS BANKA_KODU,
DEFINITION_ AS BANKA_ADI,
ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 1)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_23
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 1)), 0) AS OCAK_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_22
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 2)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_21
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 2)), 0) AS �UBAT_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_20
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 3)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_19
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 3)), 0) AS MART_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_18
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 4)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_17
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 4)), 0) AS N�SAN_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_16
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 5)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_15
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 5)), 0) AS MAYIS_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_14
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 6)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_13
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 6)), 0) AS HAZ�RAN_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_12
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 7)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_11
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 7)), 0) AS TEMMUZ_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_10
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 8)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_9
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 8)), 0) AS A�USTOS_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_8
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 9)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_7
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 9)), 0) AS EYL�L_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_6
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 10)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_5
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 10)), 0) AS EK�M_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_4
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 11)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_3
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 11)), 0) AS KASIM_BAK�YE, ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_2
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 0) AND (MONTH(DATE_) = 12)), 0) - ISNULL
((SELECT SUM(TRNET) AS Expr1
FROM dbo.LG_424_01_BNFLINE AS LG_424_01_BNFLINE_1
WHERE (BNACCREF = BNF.LOGICALREF) AND (SIGN = 1) AND (MONTH(DATE_) = 12)), 0) AS ARALIK_BAK�YE
FROM dbo.LG_424_BANKACC AS BNF 
WHERE DEFINITION_ LIKE 'GAR%'