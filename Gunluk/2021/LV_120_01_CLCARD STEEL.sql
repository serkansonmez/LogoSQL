USE [TIGER3_STEEL]
GO

/****** Object:  View [dbo].[LV_120_01_CLCARD]    Script Date: 9.04.2021 18:29:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[LV_120_01_CLCARD] AS
SELECT
      LGMAIN.LOGICALREF, LGMAIN.CODE, LGMAIN.DEFINITION_, LGMAIN.CITY, LGMAIN.COUNTRY, LGMAIN.ACTIVE, LGMAIN.CARDTYPE, LGMAIN.SPECODE, LGMAIN.TRADINGGRP,
   LGMAIN.CYPHCODE, LGMAIN.INCHARGE, LGMAIN.SPECODE2, LGMAIN.SPECODE3, LGMAIN.SPECODE4, LGMAIN.SPECODE5, LGMAIN.TAXOFFICE, LGMAIN.TAXNR, LGMAIN.TCKNO,
   --LGMAIN.EMAILADDR
   LG_XT003_120.FIRMASAHIBIMAIL as EMAILADDR
   , LGMAIN.TELNRS1, LGMAIN.TELNRS2, LGMAIN.ORGLOGICREF, LGMAIN.WFLOWCRDREF,LGMAIN.PURCHBRWS, LGMAIN.SALESBRWS, LGMAIN.FINBRWS, LGMAIN.WFLOWCRD,
      (SELECT SUM(B.DEBIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=1 AND B.CARDREF=LGMAIN.LOGICALREF) AS DEBIT,
      (SELECT SUM(B.CREDIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=1 AND B.CARDREF=LGMAIN.LOGICALREF) AS CREDIT,
      (SELECT SUM(B.DEBIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=2 AND B.CARDREF=LGMAIN.LOGICALREF) AS DEBIT_RD,
      (SELECT SUM(B.CREDIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=2 AND B.CARDREF=LGMAIN.LOGICALREF) AS CREDIT_RD
FROM
     LV_120_CLCARD LGMAIN
	 LEFT JOIN LG_XT003_120 ON PARLOGREF = LGMAIN.LOGICALREF 
WHERE
     LGMAIN.CARDTYPE NOT IN (4,22) AND LGMAIN.LOWLEVELCODES1 <> '0'
UNION ALL
SELECT
      LGMAIN.LOGICALREF, LGMAIN.CODE, LGMAIN.DEFINITION_, LGMAIN.CITY, LGMAIN.COUNTRY, LGMAIN.ACTIVE, LGMAIN.CARDTYPE, LGMAIN.SPECODE, LGMAIN.TRADINGGRP,
   LGMAIN.CYPHCODE, LGMAIN.INCHARGE, LGMAIN.SPECODE2, LGMAIN.SPECODE3, LGMAIN.SPECODE4, LGMAIN.SPECODE5, LGMAIN.TAXOFFICE, LGMAIN.TAXNR, LGMAIN.TCKNO,
   --LGMAIN.EMAILADDR
    LG_XT003_120.FIRMASAHIBIMAIL  as EMAILADDR
   , LGMAIN.TELNRS1, LGMAIN.TELNRS2, LGMAIN.ORGLOGICREF, LGMAIN.WFLOWCRDREF,LGMAIN.PURCHBRWS, LGMAIN.SALESBRWS, LGMAIN.FINBRWS, LGMAIN.WFLOWCRD,
      (SELECT SUM(B.DEBIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=1 AND B.CARDREF=LGMAIN.LOGICALREF) AS DEBIT,
      (SELECT SUM(B.CREDIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=1 AND B.CARDREF=LGMAIN.LOGICALREF) AS CREDIT,
      (SELECT SUM(B.DEBIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=2 AND B.CARDREF=LGMAIN.LOGICALREF) AS DEBIT_RD,
      (SELECT SUM(B.CREDIT) FROM LV_120_01_GNTOTCL B WHERE B.TOTTYP=2 AND B.CARDREF=LGMAIN.LOGICALREF) AS CREDIT_RD
FROM
     LV_120_CLCARD LGMAIN
	 LEFT JOIN LG_XT003_120 ON PARLOGREF = LGMAIN.LOGICALREF 
WHERE
     LGMAIN.CARDTYPE NOT IN (4,22) AND LGMAIN.LOWLEVELCODES1=0
GO


