USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_ONAY_TALEPLERI_LISTESI_HAREKET]    Script Date: 10.10.2020 21:53:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 








ALTER View [dbo].[VW_ONAY_TALEPLERI_LISTESI_HAREKET] AS
select 
Talep.id as OnayNo,
Talep.Tarih ,
Kullanicilar.AdiSoyadi as TalepEden,
Talep.TalepKonusu ,
[OnayGruplari].Adi as OnayGrubu,
OnayIslemleri.DurumKodu,
[OnayDurumKodlari].Aciklama as Durum,
Onaylayan.AdiSoyadi as Onaylayan,
OnayIslemleri.Tarih as OnayTarihi,
OnayIslemleri.Aciklama as OnayAciklama,
CAST(OnayIslemleri.AdimSiraNo AS VARCHAR(2)) + '/' + (select CAST(Max(OnayCount.AdimSiraNo)AS VARCHAR(2)) from OnayIslemleri  OnayCount where OnayCount.OnayDokumanId = Talep.id )  as SiraNo,
OnayIslemleri.id as OnayIslemleriId,
--[OnayMekanizmaAdimlari].Kime,
(select top 1 Kullanicilar.EMail from OnayMekanizmaAdimlari tblOnaySira 
left join OnayGruplari on OnayGruplari.id = tblOnaySira.OnaylayanGrubuId
left join Kullanicilar on Kullanicilar.Id = OnayGruplari.KullaniciId 
where tblOnaySira.OnayMekanizmaId = OnayIslemleri.OnayMekanizmaId and tblOnaySira.AdimSiraNo>[OnayMekanizmaAdimlari].AdimSiraNo order by AdimSiraNo) as Kime,

[OnayMekanizmaAdimlari].Bilgi,
[OnayMekanizmaAdimlari].Gizli,
CAST(CHECKSUM(Talep.id ,OnayIslemleri.id) AS VARCHAR(255)) as Csum,
Onaylayacak.Id as OnaylayacakId,
Onaylayacak.AdiSoyadi as OnaylayacakAdiSoyadi,
Onaylayacak.ParolaHash as OnaylayacakParola,
OnayIslemleri.BankaTemsilcisiId as BankaTemsilcisiId,
case when [OnayMekanizmaAdimlari].Aciklama is null then '' else [OnayMekanizmaAdimlari].Aciklama end as RotaAciklama,
case when OnayIslemleri.DeadlineDate is null then '19000101' else OnayIslemleri.DeadlineDate end as DeadlineDate,
Onaylayacak.GsmNo,
Onaylayacak.GsmOperator,
[OnayMekanizmaAdimlari].SmsGonder,
OnayTurleri.TurAdi as RotaTuru,
isnull (Talep.TalepTutari,0) as TalepTutari
,Onaylayan.eMail as OnaylayanEmail
,Onaylayan.Id as OnaylayanKullaniciId
,year(Talep.Tarih) as Yil 
,month(Talep.Tarih) as Ay

from OnayTalepleri Talep with (NOLOCK)
 LEFT OUTER JOIN   (select  * from OnayIslemleri with (NOLOCK)  ) as OnayIslemleri ON OnayIslemleri.OnayDokumanId = Talep.id
 LEFT OUTER JOIN Kullanicilar with (NOLOCK) on Kullanicilar.Id = TalepYapanId
 LEFT OUTER JOIN [OnayMekanizmaAdimlari] ON OnayIslemleri.OnayMekanizmaAdimlariId =  [OnayMekanizmaAdimlari].id
 LEFT OUTER JOIN [OnayGruplari] ON OnayGruplari.id =  [OnayMekanizmaAdimlari].OnaylayanGrubuId
 LEFT OUTER JOIN [OnayDurumKodlari] ON [OnayDurumKodlari].DurumKodu =  OnayIslemleri.DurumKodu
 LEFT OUTER JOIN Kullanicilar Onaylayacak with (NOLOCK) on Onaylayacak.Id = [OnayGruplari].KullaniciId
 LEFT OUTER JOIN Kullanicilar Onaylayan with (NOLOCK) on Onaylayan.Id = KaydedenKullaniciId
  LEFT OUTER JOIN OnayMekanizmalari ON [OnayMekanizmalari].id =[OnayMekanizmaAdimlari].[OnayMekanizmaId] 
   LEFT OUTER JOIN OnayTurleri ON [OnayMekanizmalari].OnayTurId =OnayTurleri.Id 
 where not(CAST(CHECKSUM(Talep.id ,OnayIslemleri.id) AS VARCHAR(255)) in (8562,8548) and OnayIslemleri.Tarih is not null)  
 
 and Talep.RowDeleted = '0'
--and CAST(CHECKSUM(Talep.id ,OnayIslemleri.id) AS VARCHAR(255)) = 33032
--5997-VolkanKocakiray














GO


