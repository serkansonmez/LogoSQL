ALTER view VW_TabloMasrafMerkezi as 
--SELECT LOGICALREF as Id,RATES4 as MasrafMerkezi,* FROM TIGER2_DB..LG_119_FINTABLEITEM  where Rates4 <> '' and ITEMCODE LIKE 'F%' 

SELECT LOGICALREF as Id,  tblGrup2.RATES4 + '->' + TblMasraf.RATES4 as MasrafMerkezi  FROM TIGER2_DB..LG_119_FINTABLEITEM TblMasraf
left join (select ITEMCODE, RATES4 FROM TIGER2_DB..LG_119_FINTABLEITEM WHERE ITEMCODE LIKE 'F%' AND len(ITEMCODE) = 7) tblGrup2 on 
tblGrup2.ITEMCODE = SUBSTRING(TblMasraf.ITEMCODE,1,7)
--left join (select ITEMCODE, RATES4 FROM TIGER2_DB..LG_119_FINTABLEITEM WHERE ITEMCODE LIKE 'F%' AND len(ITEMCODE) = 4) tblGrup1 on 
--tblGrup1.ITEMCODE = SUBSTRING(TblMasraf.ITEMCODE,1,4)
where TblMasraf.Rates4 <> '' and TblMasraf.ITEMCODE LIKE 'F%' and len(TblMasraf.ITEMCODE) = 10

--select * from VW_TabloMasrafMerkezi where MasrafMerkezi like 'oth%'