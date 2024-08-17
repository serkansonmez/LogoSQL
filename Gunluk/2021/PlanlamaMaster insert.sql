insert EmySteelDB.DBO.PlanlamaMaster
SELECT LOGICALREF,ORDFICHEREF,1 as PlanlamaDurumId, NULL as TeslimTarihi,null  as VariantRef, null as RowUpdatedBy
,null as RowUpdatedTime
,0 as IsEmriDurum
,'' IsEmriNo
,null as IsEmriTarih
,null as Aciklama,

 TIGER3_STEEL.DBO.VW_120_01_SIPARIS_FORMU .ItemRef
 ,0 ,0, '' Kalite, 0 as TalasFarki
FROM TIGER3_STEEL.DBO.VW_120_01_SIPARIS_FORMU  
LEFT JOIN EmySteelDB.DBO.PlanlamaMaster ON PlanlamaMaster.OrflineRef = LOGICALREF
WHERE EmySteelDB.DBO.PlanlamaMaster.Id is null -- SiparisTarihi between '20210201' and   '20210301'

--select * from     PlanlamaMaster

--update     PlanlamaMaster set PlanlamaDurumId=2 where PlanlamaDurumId = 1

