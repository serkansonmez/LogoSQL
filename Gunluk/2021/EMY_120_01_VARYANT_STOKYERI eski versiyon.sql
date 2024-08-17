USE [STEEL]
GO

/****** Object:  View [dbo].[EMY_120_01_VARYANT_STOKYERI]    Script Date: 20.12.2021 21:46:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






 
  --ALTER VIEW [dbo].[EMY_120_01_VARYANT_STOKYERI] AS 
SELECT *, 
case WHEN  tblVaryant.STOKYERI  = 'A1' THEN MAINAMOUNT ELSE 0 END STOKYERI1 ,
case WHEN  tblVaryant.STOKYERI  = 'A2' THEN MAINAMOUNT ELSE 0 END STOKYERI2 ,
case WHEN  tblVaryant.STOKYERI  = 'A3' THEN MAINAMOUNT ELSE 0 END STOKYERI3 ,
case WHEN  tblVaryant.STOKYERI  = 'STOK YER4' THEN MAINAMOUNT ELSE 0 END STOKYERI4 ,
case WHEN  tblVaryant.STOKYERI  = 'STOK YER5' THEN MAINAMOUNT ELSE 0 END STOKYERI5 ,
case WHEN  tblVaryant.STOKYERI  = 'STOK YER6' THEN MAINAMOUNT ELSE 0 END STOKYERI6 ,
case WHEN  tblVaryant.STOKYERI  = 'STOK YER7' THEN MAINAMOUNT ELSE 0 END STOKYERI7 ,
case WHEN  tblVaryant.STOKYERI  = 'STOK YER8' THEN MAINAMOUNT ELSE 0 END STOKYERI8 ,
CODE AS MALZEMEKODU,
NAME AS MALZEMEADI
from
(

select LG_120_01_SLTRANS.STTRANSREF,LG_120_01_SLTRANS.STFICHEREF, LG_120_01_SLTRANS.ITEMREF,LG_120_01_SLTRANS.VARIANTREF,
LG_120_VARIANT.CODE AS VARYANTKODU 

--,REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 1)) AS X_
--,REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 2)) AS Y_
--,REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 3)) AS Z_

,REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 1)) AS X_
	 
,case when REVERSE(PARSENAME(REPLACE(REVERSE(ITM.code), ',', '.'), 3)) = 'CP' then 
   '0'  
 else 
	REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 2))  end AS Y_
,case when REVERSE(PARSENAME(REPLACE(REVERSE(ITM.code), ',', '.'), 3)) = 'CP' then 
   REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 2))  
 else 
	REVERSE(PARSENAME(REPLACE(REVERSE( LG_120_VARIANT.CODE), 'X', '.'), 3))  end  AS Z_

,LG_120_LOCATION.CODE as STOKYERI,MAINAMOUNT ,REMAMOUNT,INVENNO,

REVERSE(PARSENAME(REPLACE(REVERSE(ITM.code), ',', '.'), 2)) as KaliteKodu
,REVERSE(PARSENAME(REPLACE(REVERSE(ITM.code), ',', '.'), 3)) as Kalite   
,ITM.CODE ,ITM.NAME, ISNULL(EMY_120_01_REZERV_VARYANTLAR.SEVKKALAN,0)  AS REZERVMIKTAR

 
from LG_120_01_SLTRANS 
LEFT JOIN LG_120_LOCATION ON LG_120_LOCATION.LOGICALREF = LG_120_01_SLTRANS.LOCREF
LEFT JOIN LG_120_VARIANT ON LG_120_VARIANT.LOGICALREF = LG_120_01_SLTRANS.VARIANTREF
left JOIN LG_120_ITEMS  ITM ON ITM.LOGICALREF = LG_120_VARIANT.ITEMREF
LEFT JOIN EMY_120_01_REZERV_VARYANTLAR ON EMY_120_01_REZERV_VARYANTLAR.ELDEKIVARYANTREF = LG_120_VARIANT.LOGICALREF

) tblVaryant
  LEFT JOIN  EmySteelDB.dbo.IsEmriDetay  IsEmriDetay ON  tblVaryant.VARIANTREF = IsEmriDetay.LogoVaryantRef
  LEFT JOIN EmySteelDB.dbo.PlanlamaMaster  PlanlamaMaster on IsEmriDetay.PlanlamaMasterId = PlanlamaMaster.Id
where OrflineRef =53899

GO


