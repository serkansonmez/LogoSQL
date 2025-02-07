USE [TIGER3_STEEL]
GO

/****** Object:  View [dbo].[EMY_119_01_ORFLINE_BEKLEYEN]    Script Date: 25.05.2021 15:42:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create VIEW [dbo].[EMY_119_01_ORFLINE_BEKLEYEN] AS
SELECT
    LGMAIN.LOGICALREF, LGMAIN.ORDFICHEREF, LGMAIN.STOCKREF, LGMAIN.CLIENTREF, LGMAIN.LINENO_, LGMAIN.AMOUNT,LGMAIN.SHIPPEDAMOUNT, (LGMAIN.AMOUNT-LGMAIN.SHIPPEDAMOUNT) AS SEVKKALAN,LGMAIN.PRICE, 
	CASE WHEN (LGMAIN.AMOUNT - LGMAIN.SHIPPEDAMOUNT) > 0 THEN  Round( ISNULL((AMOUNT - SHIPPEDAMOUNT) * PRICE,0),2)*1.18 ELSE 0 END AS KDV_DAHIL_KAPANMAMIS_SIP_TUTAR,
	LGMAIN.TOTAL, LGMAIN.DATE_, LGMAIN.LINETYPE, LGMAIN.TRCODE,   
 CASE WHEN LGMAIN.LINETYPE IN (4) THEN SRVCARD.CODE WHEN LGMAIN.LINETYPE IN (2,3) THEN DECARDS.CODE WHEN LGMAIN.LINETYPE NOT IN (2,3,4) THEN ITEM.CODE ELSE '' END AS CODE,
 CASE WHEN LGMAIN.LINETYPE IN (4) THEN SRVCARD.DEFINITION_ WHEN LGMAIN.LINETYPE IN (2,3) THEN DECARDS.DEFINITION_ WHEN LGMAIN.LINETYPE NOT IN (2,3,4) THEN ITEM.NAME ELSE '' END AS LINEEXP
FROM
    LG_119_01_ORFLINE LGMAIN WITH(NOLOCK)
    LEFT OUTER JOIN LG_119_ITEMS ITEM WITH(NOLOCK) ON LGMAIN.STOCKREF = ITEM.LOGICALREF AND LGMAIN.LINETYPE NOT IN (2,3,4)
    LEFT OUTER JOIN lg_119_SRVCARD SRVCARD WITH(NOLOCK) ON LGMAIN.STOCKREF = SRVCARD.LOGICALREF AND LGMAIN.LINETYPE IN (4)
    LEFT OUTER JOIN LG_119_DECARDS DECARDS WITH(NOLOCK) ON LGMAIN.STOCKREF = DECARDS.LOGICALREF AND LGMAIN.LINETYPE IN (2,3)
	WHERE LGMAIN.TRCODE=1
GO


