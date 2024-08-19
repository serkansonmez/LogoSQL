SELECT 
case when LH_001_LAWCHG.SSKDISCLAW  =0  then
'Kanun türü yoktur.'
else 
isnull(VW_IndirimKanunlariListesi.EXP,'Kanun türü yoktur.') end , 

'UPDATE LH_001_EDOCMLIST SET SSKDISCLAW='''+ case when LH_001_LAWCHG.SSKDISCLAW  =0  then
'Kanun türü yoktur.'
else 
isnull(VW_IndirimKanunlariListesi.EXP,'Kanun türü yoktur.') end
+ ''' WHERE LREF=' + CAST(LH_001_EDOCMLIST.LREF AS VARCHAR(6)),
LH_001_EDOCMLIST.* FROM LH_001_EDOCMLIST
left JOIN VW_PERSONEL_SICIL_001 on LH_001_EDOCMLIST.IDTCNO = VW_PERSONEL_SICIL_001.TCKIMLIKNO
left JOIN LH_001_LAWCHG ON LH_001_LAWCHG.PERREF = VW_PERSONEL_SICIL_001.LH_001_PERSONREF AND ENDDATE IS NULL
left JOIN VW_IndirimKanunlariListesi ON VW_IndirimKanunlariListesi.NR = LH_001_LAWCHG.SSKDISCLAW  
 
 

--select * from LH_001_EDOCMLIST




 