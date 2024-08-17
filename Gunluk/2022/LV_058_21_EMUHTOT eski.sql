USE [TIGER2_DB]
GO

/****** Object:  View [dbo].[LV_058_21_EMUHTOT]    Script Date: 6.10.2022 11:41:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[LV_058_21_EMUHTOT] AS
WITH TOTTAB AS (SELECT 1 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT AS DEBIT,
                 CREDIT AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV1 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT <> 0 OR CREDIT <> 0
          UNION ALL
          SELECT 1 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 TRCURR AS TRCURR,
                 DEBIT_LC AS DEBIT,
                 CREDIT_LC AS CREDIT,
                 DEBITRESRV AS DEBITRESRV,
                 CREDITRESRV AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV2 WITH(NOEXPAND,NOLOCK)
           WHERE DEBITRESRV <> 0 OR DEBITRESRV <> 0
          UNION ALL
          SELECT 2 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT_RC AS DEBIT,
                 CREDIT_RC AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV1 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT_RC <> 0 OR CREDIT_RC <> 0
          UNION ALL
          SELECT 2 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 TRCURR AS TRCURR,
                 DEBIT_LC AS DEBIT,
                 CREDIT_LC AS CREDIT,
                 DEBITRESRV_RC AS DEBITRESRV,
                 CREDITRESRV AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV2 WITH(NOEXPAND,NOLOCK)
           WHERE DEBITRESRV_RC <> 0
          UNION ALL
          SELECT 3 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT_AMNT AS DEBIT,
                 CREDIT_AMNT AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV1 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT_AMNT <> 0 OR CREDIT_AMNT <> 0
          UNION ALL
          SELECT 4 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT AS DEBIT,
                 CREDIT AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV3 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT <> 0 OR CREDIT <> 0
          UNION ALL
          SELECT 5 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT_RC AS DEBIT,
                 CREDIT_RC AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV3 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT_RC <> 0 OR CREDIT_RC <> 0
          UNION ALL
          SELECT 7 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 0 AS TRCURR,
                 DEBIT_EMU AS DEBIT,
                 CREDIT_EMU AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV1 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT_EMU <> 0 OR CREDIT_EMU <> 0
          UNION ALL
          SELECT 8 AS TOTTYPE,
                 MONTH_ AS MONTH_,
                 YEAR_ AS YEAR_,
                 ACCOUNTREF AS ACCOUNTREF,
                 BRANCH AS BRANCH,
                 DEPARTMENT AS DEPARTMENT,
                 TRCURR AS TRCURR,
                 DEBIT_LC AS DEBIT,
                 CREDIT_LC AS CREDIT,
                 0 AS DEBITRESRV,
                 0 AS CREDITRESRV
            FROM LV_058_21_EMUHTOTV1 WITH(NOEXPAND,NOLOCK)
           WHERE DEBIT_LC <> 0 OR CREDIT_LC <> 0)
SELECT   1 LOGICALREF,
         ACC.ACCOUNTREF,
         0 TRANCOUNT,
         TAB.TOTTYPE TOTTYPE,
         TAB.MONTH_,
         SUM(TAB.DEBIT) DEBIT,
         SUM(TAB.CREDIT) CREDIT,
         0 DEBITREM,
         0 CREDITREM,
         0 DEBITINFL,
         0 CREDITINFL,
         TAB.YEAR_,
         TAB.BRANCH,
         TAB.DEPARTMENT,
         SUM(TAB.DEBITRESRV) DEBITRESRV,
         SUM(TAB.CREDITRESRV) CREDITRESRV,
         TAB.TRCURR CURRTYP
FROM TOTTAB TAB,
LG_058_EMUHACCSUBACCASGN AS ACC
WHERE ACC.SUBACCOUNTREF = TAB.ACCOUNTREF
AND TAB.TOTTYPE NOT IN (4,5)
GROUP BY ACC.ACCOUNTREF,
         TAB.TOTTYPE,
         TAB.MONTH_,
         TAB.YEAR_,
         TAB.BRANCH,
         TAB.DEPARTMENT,
         TAB.TRCURR
UNION ALL
SELECT   1 LOGICALREF,
         TAB.ACCOUNTREF,
         0 TRANCOUNT,
         TAB.TOTTYPE TOTTYPE,
         TAB.MONTH_,
         SUM(TAB.DEBIT) DEBIT,
         SUM(TAB.CREDIT) CREDIT,
         0 DEBITREM,
         0 CREDITREM,
         0 DEBITINFL,
         0 CREDITINFL,
         TAB.YEAR_,
         TAB.BRANCH,
         TAB.DEPARTMENT,
         SUM(TAB.DEBITRESRV) DEBITRESRV,
         SUM(TAB.CREDITRESRV) CREDITRESRV,
         TAB.TRCURR CURRTYP
FROM TOTTAB TAB
WHERE TAB.TOTTYPE IN (4,5)
GROUP BY TAB.ACCOUNTREF,
         TAB.TOTTYPE,
         TAB.MONTH_,
         TAB.YEAR_,
         TAB.BRANCH,
         TAB.DEPARTMENT,
         TAB.TRCURR
GO


