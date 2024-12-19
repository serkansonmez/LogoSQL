--create view VW_PersonelAylikPuantaj as 
SELECT
    YEAR(Tarih) AS Yil,
    MONTH(Tarih) AS Ay,
    VW_Pdks_PersonelCalismaDetay.Adi,
    VW_Pdks_PersonelCalismaDetay.Soyadi,
    SUM(farkSaat) AS CalismaSaat,
    SUM(farkDakika) AS CalismaDakika,
    CONCAT(FLOOR((SUM(farkSaat) * 60 + SUM(farkDakika)) / 60), ':', (SUM(farkSaat) * 60 + SUM(farkDakika)) % 60) AS ToplamCalismaSaat,
    AktifCalisilanSaat,
    HaftaSonuSaat,
	ResmiTatilSaat,
    FLOOR((SUM(farkSaat) * 60 + SUM(farkDakika)) / 60) + 
        CASE 
            WHEN (SUM(farkDakika) % 60) BETWEEN 0 AND 14 THEN 0
            WHEN (SUM(farkDakika) % 60) BETWEEN 15 AND 44 THEN 0.5
            WHEN (SUM(farkDakika) % 60) BETWEEN 45 AND 59 THEN 1
            ELSE 0
        END +
    HaftaSonuSaat + ResmiTatilSaat AS Toplam
	,TblSaglikRaporu.Gun as SaglikRaporGun
	,TblSaglikRaporu.Gun * 7.5 as SaglikRaporSaat
    ,TblYillikIzin.Gun as YillikIzinGun
	,TblYillikIzin.Gun * 7.5 as YillikIzinSaat
	,TblUcretsizIzin.Gun as UcretsizIzinGun
	,TblUcretsizIzin.Gun * 7.5 as UcretsizIzinSaat
	,TblDevamsizlik.Gun as DevamsizlikGun
	,TblDevamsizlik.Gun * 7.5 as DevamsizlikSaat
	,TblUcretliIzin.Gun as UcretliIzinGun
	,TblUcretliIzin.Gun * 7.5 as UcretliIzinSaat
FROM VW_Pdks_PersonelCalismaDetay
LEFT JOIN IkAylikCalismaParametresi ON YEAR(Tarih) = IkAylikCalismaParametresi.Yil AND MONTH(Tarih) = IkAylikCalismaParametresi.Ay
LEFT JOIN (select PersonelId, TatilId,YEAR(Tarih) As Yil,month(Tarih) as Ay ,count(*)  as Gun,Adi,Soyadi,TatilAdi from VW_Pdks_PersonelIzin  where TatilId = 6 
 
group by PersonelId, TatilId,YEAR(Tarih),month(Tarih),Adi,Soyadi,TatilAdi) TblSaglikRaporu on TblSaglikRaporu.PersonelId =VW_Pdks_PersonelCalismaDetay.PersonelId and YEAR(Tarih)=TblSaglikRaporu.Yil and month(Tarih)=TblSaglikRaporu.Ay

LEFT JOIN (select PersonelId, TatilId,YEAR(Tarih) As Yil,month(Tarih) as Ay ,count(*)  as Gun,Adi,Soyadi,TatilAdi from VW_Pdks_PersonelIzin  where TatilId = 5 
group by PersonelId, TatilId,YEAR(Tarih),month(Tarih),Adi,Soyadi,TatilAdi) TblYillikIzin on TblYillikIzin.PersonelId =VW_Pdks_PersonelCalismaDetay.PersonelId and YEAR(Tarih)=TblYillikIzin.Yil and month(Tarih)=TblYillikIzin.Ay


LEFT JOIN (select PersonelId, TatilId,YEAR(Tarih) As Yil,month(Tarih) as Ay ,count(*)  as Gun,Adi,Soyadi,TatilAdi from VW_Pdks_PersonelIzin  where TatilId = 3
group by PersonelId, TatilId,YEAR(Tarih),month(Tarih),Adi,Soyadi,TatilAdi) TblUcretsizIzin on TblUcretsizIzin.PersonelId =VW_Pdks_PersonelCalismaDetay.PersonelId and YEAR(Tarih)=TblUcretsizIzin.Yil and month(Tarih)=TblUcretsizIzin.Ay

LEFT JOIN (select PersonelId, TatilId,YEAR(Tarih) As Yil,month(Tarih) as Ay ,count(*)  as Gun,Adi,Soyadi,TatilAdi from VW_Pdks_PersonelIzin  where TatilId = 16
group by PersonelId, TatilId,YEAR(Tarih),month(Tarih),Adi,Soyadi,TatilAdi) TblDevamsizlik on TblDevamsizlik.PersonelId =VW_Pdks_PersonelCalismaDetay.PersonelId and YEAR(Tarih)=TblDevamsizlik.Yil and month(Tarih)=TblDevamsizlik.Ay

LEFT JOIN (select PersonelId, TatilId,YEAR(Tarih) As Yil,month(Tarih) as Ay ,count(*)  as Gun,Adi,Soyadi,TatilAdi from VW_Pdks_PersonelIzin  where TatilId = 2
group by PersonelId, TatilId,YEAR(Tarih),month(Tarih),Adi,Soyadi,TatilAdi) TblUcretliIzin on TblUcretliIzin.PersonelId =VW_Pdks_PersonelCalismaDetay.PersonelId and YEAR(Tarih)=TblUcretliIzin.Yil and month(Tarih)=TblUcretliIzin.Ay


WHERE VW_Pdks_PersonelCalismaDetay.Adi like '%%' AND MONTH(Tarih) = 6
GROUP BY YEAR(Tarih), MONTH(Tarih), VW_Pdks_PersonelCalismaDetay.Adi, VW_Pdks_PersonelCalismaDetay.Soyadi, AktifCalisilanSaat, HaftaSonuSaat, ResmiTatilSaat,TblSaglikRaporu.Gun,
TblYillikIzin.Gun,TblUcretsizIzin.Gun,TblDevamsizlik.Gun,TblUcretliIzin.Gun


	 -- select * from IkAylikCalismaParametresi



	--select * from  [VW_Pdks_PersonelIzin]