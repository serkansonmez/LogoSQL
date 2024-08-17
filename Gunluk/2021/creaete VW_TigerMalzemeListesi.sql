 
 
alter view [dbo].[VW_TigerMalzemeListesi] as 
SELECT  
LOGICALREF AS MalzemeReferans ,
CARDTYPE as MalzemeTuru,

CASE WHEN  CARDTYPE = 1 THEN 'Ticari Mal ' WHEN CARDTYPE = 2 THEN 'Karma Koli' WHEN CARDTYPE = 3 THEN 'Depozitolu Mal' WHEN CARDTYPE = 4 THEN 'Sabit K�ymet' WHEN CARDTYPE = 10 THEN 'Ham Madde' WHEN CARDTYPE = 11 THEN 'Yar� Mamul' WHEN CARDTYPE = 12 THEN 'Mamul' WHEN CARDTYPE = 13 THEN 'T�ketim Mal�' WHEN CARDTYPE = 20 THEN 'Genel Malzeme S�n�f�' ELSE '' END 
  as MalzemeTurAdi,    
CODE AS MalzemeKodu ,
 NAME as MalzemeAdi,

 SPECODE As OzelKod,
 SPECODE2 As OzelKod2,
 
 VAT as VergiOrani

FROM  [LG_110_ITEMS]   
where CARDTYPE <> 22

--SELECT * FROM L_CAPIUSER
GO


