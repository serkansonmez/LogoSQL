SELECT ROW_NUMBER() OVER (ORDER BY TBLGenelListe.YIL,TBLGenelListe.AY) ID, 

TBLGenelListe.*,
CASE WHEN TBLGenelListe.M2 > 0 THEN ROUND(TBLGenelListe.TOTAL / TBLGenelListe.M2 ,2) ELSE 0 END  AS ORTALAMAFIYAT 
,FinansButce.m2 as ButceM2,
FinansButce.Toplam as ButceToplam,
FinansButce.DovizToplam as ButceDovizToplam,
FinansButce.OrtalamaFiyat as ButceOrtalamaFiyat

,TBLGenelListe.M2 - FinansButce.m2 as SapmaM2,
TBLGenelListe.TOTAL - FinansButce.Toplam as SapmaToplam,
TBLGenelListe.DOVIZTUTAR - FinansButce.DovizToplam as SapmaDovizToplam,
CASE WHEN TBLGenelListe.M2 > 0 THEN  ROUND(TBLGenelListe.TOTAL / TBLGenelListe.M2 ,2)  ELSE 0 END  - FinansButce.OrtalamaFiyat as SapmaOrtalamaFiyat
FROM (select * from TempResults
 ) TBLGenelListe
      left join FercamB2B_Default_v1..RaporSablonlari   on RaporSablonlari.Kod1 = TBLGenelListe.Kod1 and RaporSablonlari.Kod2 = TBLGenelListe.Kod2
	 left join FercamB2B_Default_v1..FinansButce  FinansButce on FinansButce.Yil = TBLGenelListe.YIL AND  FinansButce.Ay = TBLGenelListe.AY 
	 AND  FinansButce.RaporSablonlariId = RaporSablonlari.RaporSablonlariId