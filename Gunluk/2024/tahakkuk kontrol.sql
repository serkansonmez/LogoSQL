USE [GezenWeb_Default_v1]
GO

/****** Object:  View [dbo].[VW_PersonelTahakkuk]    Script Date: 21.10.2024 11:14:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- select CalismaGunu,CalismaGunuSaati,  * from VW_PersonelTahakkuk where Ad  like 'gülþah%' and MaasAy  = 7
 ALTER view [dbo].[VW_PersonelTahakkuk] as 
select DISTINCT --TOP 10000000 
10000000 + Puan.siraNo as Id, Puan.Ayindex As MaasAy,Puan.Yil As MaasYil,Pers.personelno as [perno],Ad,Pers.AdSoyad,Pers.ssno as [SSnoAsil],
firma.subea as SubeAd,
firma.Edit2 as FirmaAd,
CASE Us 
  WHEN 'AYLIK' THEN (Au/Primgunu)
  WHEN 'GUNLUK' THEN (Au/Primgunu)
  WHEN 'SAATLÝK' THEN (Primgunu*ttunis.Gm)
  ELSE 0 
END as GunlukBrutUcret ,
(Geneltatil+Dinitatil)   As GenelTatil2,
 (Netu-Asgari_gecim_ind_tut)   As NetUcret,
 (fm1+fm2+fm3)   As VergiIadesi,
(Netu+Veriade) As OdenecekTutar,
(Vrgi+Puan.Gelirindirim)   As ToplamVergiIstisnasi,
( Bt+Isskk+Iisk-Puan.Sskindirim) As ToplamMaliyet,
(Calismagunu *ttunis.Gm)  AS CalismaGunuSaati,
(Haftasonu *ttunis.Gm) AS HaftaTatiliSaati,
((Geneltatil+Dinitatil)*ttunis.Gm )AS GenelTatilSaati,
(Ucretliizin*ttunis.Gm) AS UcretliIzinSaati,
(Ucretsizizin*ttunis.Gm) As UcretsizIzinSaati,
(Sihhiizin*ttunis.Gm) As SihhiIzinSaati,
(Yillikizin*ttunis.Gm) As YillikIzinSaati,
(Mazeretgunu*ttunis.Gm) As MazeretsizSaati,
Pers.Vatno,Igt,Ict,cinsiyet,Us,Ts,Pgk,Pers.Fsk as [FskAsil],Maas,Kanun=isNull(ssk.Kanunno,isNull(Puan.Kanunno,Pers.Kanun)),Sino,Puan.*,cast(Pers.Hesapno as varchar(30)) as Hesapno,Pers.Bankaadi,Pers.Subeadi,Pers.Subekodu, 
Pers.Grupkodu as GrupKodu2,Pers.Gorevi as Gorevi2,Puan.Meslekgrubu as Meslekgrubu2,Puan.Meslegi as Meslegi2,
Pers.Bulvar, Pers.Cadde, Pers.Sokak, Pers.Diskapino, Pers.Ickapino, Pers.Mahalle, Pers.Il, Pers.Ilce, Pers.Alankodutel, Pers.Tel, Pers.mg, Pers.Iban from [ÝHSAN_GEZEN_GENEL]..perbilgi as Pers 
left join [ÝHSAN_GEZEN_GENEL]..puanbil as Puan on Puan.personelno=Pers.personelno
left join zirvegenel..FirmalarListesi firma on firma.subeno= pers.Fsk and firma.klavuz='ÝHSAN_GEZEN'
left join (select Personelno, Yil, Ayindex, Puantajno, Kanunno=max(Kanunno) from [ÝHSAN_GEZEN_GENEL]..Ssk_tesvik 

group by Personelno, Yil, Ayindex, Puantajno) as ssk on ssk.Personelno=Pers.Personelno and ssk.Ayindex=Puan.Ayindex and ssk.Puantajno=Puan.Puantajno and ssk.Yil=Puan.Yil
left join zirvegenel..ttunis on ttunis.Ayindex = Puan.Ayindex and  ttunis.Yil = Puan.Yil 
where   
 -- (Puan.Puantajno = 1) 
 
  -- ttunis.Gm>0 and
 
  Au>0 and Puan.Yil>=2024



UNION ALL



select DISTINCT --TOP 10000000 
20000000 + Puan.siraNo as Id, Puan.Ayindex As MaasAy,Puan.Yil As MaasYil,Pers.personelno as [perno],Ad,pers.AdSoyad,Pers.ssno as [SSnoAsil],
firma.subea as SubeAd,
firma.Edit2 as FirmaAd,
CASE Us 
  WHEN 'AYLIK' THEN (Au/Primgunu)
  WHEN 'GUNLUK' THEN (Au/Primgunu)
  WHEN 'SAATLÝK' THEN (Primgunu*ttunis.Gm)
  ELSE 0 
END as GunlukBrutUcret ,
(Geneltatil+Dinitatil)   As GenelTatil2,
 (Netu-Asgari_gecim_ind_tut)   As NetUcret,
 (fm1+fm2+fm3)   As VergiIadesi,
(Netu+Veriade) As OdenecekTutar,
(Vrgi+Puan.Gelirindirim)   As ToplamVergiIstisnasi,
( Bt+Isskk+Iisk-Puan.Sskindirim) As ToplamMaliyet,
(Calismagunu *ttunis.Gm)  AS CalismaGunuSaati,
(Haftasonu *ttunis.Gm) AS HaftaTatiliSaati,
((Geneltatil+Dinitatil)*ttunis.Gm )AS GenelTatilSaati,
(Ucretliizin*ttunis.Gm) AS UcretliIzinSaati,
(Ucretsizizin*ttunis.Gm) As UcretsizIzinSaati,
(Sihhiizin*ttunis.Gm) As SihhiIzinSaati,
(Yillikizin*ttunis.Gm) As YillikIzinSaati,
(Mazeretgunu*ttunis.Gm) As MazeretsizSaati,
Pers.Vatno,Igt,Ict,cinsiyet,Us,Ts,Pgk,Pers.Fsk as [FskAsil],Maas,Kanun=isNull(ssk.Kanunno,isNull(Puan.Kanunno,Pers.Kanun)),Sino,Puan.*,cast(Pers.Hesapno as varchar(30)) as Hesapno,Pers.Bankaadi,Pers.Subeadi,Pers.Subekodu, 
Pers.Grupkodu as GrupKodu2,Pers.Gorevi as Gorevi2,Puan.Meslekgrubu as Meslekgrubu2,Puan.Meslegi as Meslegi2,
Pers.Bulvar, Pers.Cadde, Pers.Sokak, Pers.Diskapino, Pers.Ickapino, Pers.Mahalle, Pers.Il, Pers.Ilce, Pers.Alankodutel, Pers.Tel, Pers.mg, Pers.Iban from [GEZEN_GENEL_HÝZMETLER_TEMÝZLÝK_ÝÞLERÝ_LTD ÞTÝ_GENEL]..perbilgi as Pers 
left join [GEZEN_GENEL_HÝZMETLER_TEMÝZLÝK_ÝÞLERÝ_LTD ÞTÝ_GENEL]..puanbil as Puan on Puan.personelno=Pers.personelno
left join zirvegenel..FirmalarListesi firma on firma.subeno= pers.Fsk and firma.klavuz='GEZEN_GENEL_HÝZMETLER_TEMÝZLÝK_ÝÞLERÝ_LTD ÞTÝ'
left join (select Personelno, Yil, Ayindex, Puantajno, Kanunno=max(Kanunno) from [GEZEN_GENEL_HÝZMETLER_TEMÝZLÝK_ÝÞLERÝ_LTD ÞTÝ_GENEL]..Ssk_tesvik 
group by Personelno, Yil, Ayindex, Puantajno) as ssk on ssk.Personelno=Pers.Personelno and ssk.Ayindex=Puan.Ayindex and ssk.Puantajno=Puan.Puantajno and ssk.Yil=Puan.Yil
left join zirvegenel..ttunis on ttunis.Ayindex = Puan.Ayindex and  ttunis.Yil = Puan.Yil 
where   
 -- (Puan.Puantajno = 1) 
 
 --  ttunis.Gm>0 and 
    
 Au>0 and Puan.Yil>=2024





UNION ALL



select DISTINCT --TOP 10000000 
30000000 + Puan.siraNo as Id, Puan.Ayindex As MaasAy,Puan.Yil As MaasYil,Pers.personelno as [perno],Ad,pers.AdSoyad,Pers.ssno as [SSnoAsil],
firma.subea as SubeAd,
firma.Edit2 as FirmaAd,
CASE Us 
  WHEN 'AYLIK' THEN (Au/Primgunu)
  WHEN 'GUNLUK' THEN (Au/Primgunu)
  WHEN 'SAATLÝK' THEN (Primgunu*ttunis.Gm)
  ELSE 0 
END as GunlukBrutUcret ,
(Geneltatil+Dinitatil)   As GenelTatil2,
 (Netu-Asgari_gecim_ind_tut)   As NetUcret,
 (fm1+fm2+fm3)   As VergiIadesi,
(Netu+Veriade) As OdenecekTutar,
(Vrgi+Puan.Gelirindirim)   As ToplamVergiIstisnasi,
( Bt+Isskk+Iisk-Puan.Sskindirim) As ToplamMaliyet,
(Calismagunu *ttunis.Gm)  AS CalismaGunuSaati,
(Haftasonu *ttunis.Gm) AS HaftaTatiliSaati,
((Geneltatil+Dinitatil)*ttunis.Gm )AS GenelTatilSaati,
(Ucretliizin*ttunis.Gm) AS UcretliIzinSaati,
(Ucretsizizin*ttunis.Gm) As UcretsizIzinSaati,
(Sihhiizin*ttunis.Gm) As SihhiIzinSaati,
(Yillikizin*ttunis.Gm) As YillikIzinSaati,
(Mazeretgunu*ttunis.Gm) As MazeretsizSaati,
Pers.Vatno,Igt,Ict,cinsiyet,Us,Ts,Pgk,Pers.Fsk as [FskAsil],Maas,Kanun=isNull(ssk.Kanunno,isNull(Puan.Kanunno,Pers.Kanun)),Sino,Puan.*,cast(Pers.Hesapno as varchar(30)) as Hesapno,Pers.Bankaadi,Pers.Subeadi,Pers.Subekodu, 
Pers.Grupkodu as GrupKodu2,Pers.Gorevi as Gorevi2,Puan.Meslekgrubu as Meslekgrubu2,Puan.Meslegi as Meslegi2,
Pers.Bulvar, Pers.Cadde, Pers.Sokak, Pers.Diskapino, Pers.Ickapino, Pers.Mahalle, Pers.Il, Pers.Ilce, Pers.Alankodutel, Pers.Tel, Pers.mg, Pers.Iban from [ÝHSAN_GEZEN_ÖZEL_GÜVENLÝK_LTD_ÞTÝ_GENEL]..perbilgi as Pers 
left join [ÝHSAN_GEZEN_ÖZEL_GÜVENLÝK_LTD_ÞTÝ_GENEL]..puanbil as Puan on Puan.personelno=Pers.personelno
left join zirvegenel..FirmalarListesi firma on firma.subeno= pers.Fsk and firma.klavuz='ÝHSAN_GEZEN_ÖZEL_GÜVENLÝK_LTD_ÞTÝ'
left join (select Personelno, Yil, Ayindex, Puantajno, Kanunno=max(Kanunno) from [ÝHSAN_GEZEN_ÖZEL_GÜVENLÝK_LTD_ÞTÝ_GENEL]..Ssk_tesvik 
group by Personelno, Yil, Ayindex, Puantajno) as ssk on ssk.Personelno=Pers.Personelno and ssk.Ayindex=Puan.Ayindex and ssk.Puantajno=Puan.Puantajno and ssk.Yil=Puan.Yil
left join zirvegenel..ttunis on ttunis.Ayindex = Puan.Ayindex and  ttunis.Yil = Puan.Yil 
where   
 -- (Puan.Puantajno = 1) 
 
  -- ttunis.Gm>0 and 
   
  Au>0 and Puan.Yil>=2024



--order by FskAsil,Vatno,MaasYil desc,MaasAy desc


GO


