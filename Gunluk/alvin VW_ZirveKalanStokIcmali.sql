--select * from VW_ZirveKalanStokIcmali
alter view VW_ZirveKalanStokIcmali as 
select 
TblStkAdet.REF as Referans,
 TblStkAdet.STK as StokKodu,
TblStkAdet.STA as StokAdi,
tblOzelKod1.ACIKLAMA as StokGrubu, 
TblStkAdet.STB as Birim,
ROUND(TblStkAdet.STGM,2) AS GirenMiktar,
ROUND(TblStkAdet.STCM,2) AS CikanMiktar,
ROUND(TblStkAdet.STGM,2) - ROUND(TblStkAdet.STCM,2) as ZirveKalanMiktar,

TblStkAdet.BIRIM2 as Birim2, 
(ROUND(TblStkAdet.STGM,2) - ROUND(TblStkAdet.STCM,2) ) * TblStkAdet.ANABROR2 as KalanMiktarBirim2 ,

ceiling(sum(miktar) / case when TblStkAdet.ANABROR2 <> 0 then TblStkAdet.ANABROR2 else 1 end )  as BekleyenIslerMiktar,
ROUND(TblStkAdet.STGM,2) - ROUND(TblStkAdet.STCM,2) - ceiling(sum(miktar) / case when TblStkAdet.ANABROR2 <> 0 then TblStkAdet.ANABROR2 else 1 end ) as TahminiKalanMiktar,
case when max(Ercomdbfiyat.Fiyat1) is not null then max(Ercomdbfiyat.Fiyat1) 
       else max(BeyazListe.Fiyat1) end    as ListeFiyati,
 
 
(ROUND(TblStkAdet.STGM,2) - ROUND(TblStkAdet.STCM,2) - ceiling(sum(miktar) / case when TblStkAdet.ANABROR2 <> 0 then TblStkAdet.ANABROR2 else 1 end ) )  *  
																						case when max(Ercomdbfiyat.Fiyat1) is not null then max(Ercomdbfiyat.Fiyat1) 
																							   else max(BeyazListe.Fiyat1) end  *    TblStkAdet.ANABROR2      as TahminiMaliyet
from  [ÝREN_PVC_2023T]..LISTESTOKLAR_2023() TblStkAdet -- where stk like '%10116.0003'


 


LEFT JOIN  AlvinB2B_Default_v1.. VW_ErcomMaliyetAnalizi ON VW_ErcomMaliyetAnalizi.StokKodu = replace(substring(TblStkAdet.STK,8,11),'.','') 
left join AlvinB2B_Default_v1..ErcomEslesmeyenKartlar on VW_ErcomMaliyetAnalizi.StokKodu = ErcomEslesmeyenKartlar.ErcomKodu
LEFT JOIN [ÝREN_PVC_2023T]..STOKGEN TblStk ON SUBSTRING(TblStk.stk,8,5) + SUBSTRING(TblStk.stk,14,4)  = case when ErcomEslesmeyenKartlar.ZirveKodu is not null then replace(ErcomEslesmeyenKartlar.ZirveKodu,'.','') else  StokKodu end
LEFT JOIN  [ÝREN_PVC_2023T]..Degerler tblOzelKod1 wIth(nolock) ON TblStk.OZELKOD1 = tblOzelKod1.KOD and tblOzelKod1.ALANADI = 'OZELKOD1'

left join  AlvinB2B_Default_v1..Ercomdbfiyat on ListeNo = 214 and Ercomdbfiyat.StokKodu = replace(substring(TblStkAdet.STK,8,11),'.','') 
left join  AlvinB2B_Default_v1..Ercomdbfiyat BeyazListe on BeyazListe.ListeNo = 214 and BeyazListe.StokKodu = substring(TblStkAdet.STK,8,5)  
where --ROUND(TblStkAdet.STGM,2) - ROUND(TblStkAdet.STCM,2) <> 0 AND 
UretimDurumu = 'Beklemede'     
--and TblStkAdet.STK = '150.01.10116.0003'
group by TblStkAdet.REF , TblStkAdet.STK,TblStkAdet.STA,TblStkAdet.STB,TblStkAdet.STGM,TblStkAdet.STCM,TblStkAdet.BIRIM2,TblStkAdet.ANABROR2,tblOzelKod1.ACIKLAMA
