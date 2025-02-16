select referans,PaketlemeCesidi,count(PaketlemeCesidi) from KasaOlculeriExcel group by referans,PaketlemeCesidi having count(PaketlemeCesidi)>1

--select  * from KasaOlculeriExcel where Referans = 'F.081.00.114'

select * from Kasa

select DISTINCT LOGICALREF,UretimEmriNo,SiparisTarihi,FirmaKodu,FirmaAdi,MalzemeKodu, FirinPlanlanan,SiparisAdet,FirinPlanlanan from VW_UretimPlanlama  where MalzemeKodu =   '10 006'


select  * from KasaOlculeriExcel where Referans = '10 006'

select * from TIGER..LG_025_CLCARD WHERE NAME LIKE '%%'

select * from TIGER..LG_025_VARIANT
LEFT JOIN TIGER..LG_025_ITEMS ON LG_025_ITEMS.LOGICALREF = LG_025_VARIANT.ITEMREF
WHERE LG_025_VARIANT.NAME = '10 006' AND LG_025_VARIANT.NAME2 LIKE '%MÜLLER%' AND LG_025_ITEMS.CODE = '10 006' 