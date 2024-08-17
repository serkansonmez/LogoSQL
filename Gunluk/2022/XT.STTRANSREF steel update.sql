select 
'update PlanlamaDetay SET SttransRef=' + cast(XT.STTRANSREF as varchar(200)) + ' where Id = '  +  cast(detay.Id as varchar(200)) ,

detay.Id, pm.Id ,XT.ELDEKIVARYANTREF,GETDATE(),NULL,NULL,XT.STTRANSREF FROM TIGER3.DBO.VW_122_01_SIPARIS_FORMU  FRM 
LEFT JOIN  TIGER3.dbo.LG_XT001001_122 XT ON XT.PARLOGREF = FRM.LOGICALREF 
left join EmySteelDB.dbo.PlanlamaMaster pm on pm.OrflineRef = XT.PARLOGREF
left join EmySteelDB.dbo.PlanlamaDetay detay on detay.LogoVaryantRef =  XT.ELDEKIVARYANTREF and   pm.Id  = detay.PlanlamaMasterId
WHERE SiparisTarihi>'20221127' and ELDEKIVARYANTREF is not null   and detay.Id is not null 


select * from TIGER3.dbo.LG_XT001001_122
select * from EmySteelDB.dbo.PlanlamaDetay