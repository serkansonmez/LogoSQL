DECLARE @AramaMetni varchar(30) = '%9%'
declare @IlkTarih datetime = '20220101'
declare @SonTarih datetime = '20220301'
select DISTINCT Talep.OnayDokumanId as OnayNo,
Talep.Tarih ,
Kullanicilar.AdiSoyadi as TalepEden,
Talep.TalepKonusu ,
[OnayGruplari].Adi as OnayGrubu,
Talep.DurumKodu,
[OnayDurumKodlari].Aciklama as Durum,
cast((select CAST(Max(OnayCount.AdimSiraNo)AS VARCHAR(2)) from OnayIslemleri   OnayCount with(nolock) where  OnayCount.DurumKodu in('ONY','DEN','RED','STK','SAT','TED') and  OnayCount.OnayDokumanId = Talep.OnayDokumanId  )  as varchar(2)) + '/' +    cast(Talep.AdimSiraNo as varchar(2))
as SiraNo,
Talep.id as OnayIslemleriId,
[OnayMekanizmaAdimlari].Kime,
[OnayMekanizmaAdimlari].Bilgi,
[OnayMekanizmaAdimlari].Gizli,
Talep.AdimSiraNo,
--cast(pwdencrypt(OnayIslemleri.id) as varchar(255)) as Csum
--CAST(CHECKSUM(OnayIslemleri.id) AS VARCHAR(255)) as Csum,
CAST(CHECKSUM(Talep.OnayDokumanId ,Talep.id) AS VARCHAR(255)) as Csum,
Onaylayacak.id as OnaylayacakId,
Onaylayacak.AdiSoyadi as OnaylayacakAdiSoyadi,
Onaylayacak.ParolaHash as OnaylayacakParola,
Kullanicilar.id as TalepEdenId,
Talep.Tarih as OnaylamaTarih,
Talep.OnayDurumu,
OnayBolgeSube.BolgeSubeAdi as SubeAdi,

isnull (Talep.TalepTutari,0) as TalepTutari,

case when len(isnull(OnayMekanizmalari.FirmaAdi COLLATE DATABASE_DEFAULT,''))>3 then OnayMekanizmalari.FirmaAdi COLLATE DATABASE_DEFAULT else Firmalar.Adi end as Firma,
OnayTurleri.TurAdi as RotaTuru,
OnayMekanizmalari.Adi as RotaAdi,
round(OnayMekanizmalari.AltLimit/100,0) as AltLimit,
round(OnayMekanizmalari.UstLimit/100,0) as UstLimit,
Kullanicilar.ParolaHash  as ParolaHash,
BankaTemsilcisi.BankaAdi 
,OnayTurleri.Id as OnayTurleriId
,YEAR(Talep.Tarih) as Yil
,month(Talep.Tarih) as Ay
,Talep.VW_TigerDovizTurleriId
,VW_TigerDovizTurleri.CURCODE as DovizCinsi
,VW_TigerDovizTurleri.CURNAME as DovizAciklama
 from (
select DISTINCT
q1.id, OnayDokumanId,DokumanTakipNo,OnayMekanizmaId,AdimSiraNo,DurumKodu,OnayTalepleri.RowUpdatedBy AS KaydedenKullaniciId,Aciklama,OnayTalepleri.Tarih,OnayMekanizmaAdimlariId,BankaTemsilcisiId,
case when DurumKodu in('ONY','DEN','RED','STK','SAT') then 'Rota Tamamlanmýþ' else 'Onay Aþamasýnda' end as OnayDurumu
,OnayTalepleri.TalepKonusu,OnayTalepleri.TalepTutari,OnayTalepleri.VW_TigerDovizTurleriId from OnayIslemleri q1 with(Nolock)  
left join OnayTalepleri with(Nolock)  on OnayTalepleri.id = q1.OnayDokumanId
LEFT JOIN  Kullanici_Yetkileri ON YetkiTurleriId=1 and OnayTalepleri.RowUpdatedBy =YetkiTableId  
where q1.id in 
(select top 1 id from  OnayIslemleri q2 with(Nolock) where q2.OnayDokumanId = q1.OnayDokumanId order by q2.AdimSiraNo desc)
and OnayTalepleri.RowDeleted = '0' and ((cast(q1.OnayDokumanId as varchar(30)) + TalepKonusu) like  @AramaMetni  ) and OnayTalepleri.Tarih between @IlkTarih and @SonTarih
and  Kullanici_Yetkileri.id is not null and  KullaniciId= 32
 
)  as Talep
LEFT OUTER JOIN Kullanicilar with (NOLOCK) on Kullanicilar.id = Talep.KaydedenKullaniciId
 LEFT OUTER JOIN [OnayMekanizmaAdimlari] with (NOLOCK) ON Talep.OnayMekanizmaAdimlariId =  [OnayMekanizmaAdimlari].id
 LEFT OUTER JOIN [OnayGruplari] with (NOLOCK) ON OnayGruplari.id =  [OnayMekanizmaAdimlari].OnaylayanGrubuId
 LEFT OUTER JOIN Kullanicilar  Onaylayacak with (NOLOCK) on Onaylayacak.id = [OnayGruplari].KullaniciId
 LEFT OUTER JOIN [OnayDurumKodlari] with (NOLOCK) ON [OnayDurumKodlari].DurumKodu COLLATE DATABASE_DEFAULT =  Talep.DurumKodu COLLATE DATABASE_DEFAULT
 LEFT OUTER JOIN OnayMekanizmalari with (NOLOCK) ON [OnayMekanizmalari].id =[OnayMekanizmaAdimlari].[OnayMekanizmaId] 
 LEFT OUTER JOIN OnayBolgeSube with (NOLOCK) ON [OnayMekanizmalari].OnayBolgeSubeId =OnayBolgeSube.Id 
  LEFT OUTER JOIN OnayTurleri with (NOLOCK) ON [OnayMekanizmalari].OnayTurId =OnayTurleri.Id 
  LEFT OUTER JOIN Firmalar with (NOLOCK) ON Firmalar.No =OnayMekanizmalari.FirmaKodu
  LEFT OUTER JOIN BankaTemsilcisi with (NOLOCK) ON BankaTemsilcisi.Id =Talep.BankaTemsilcisiId
   LEFT OUTER JOIN VW_TigerDovizTurleri with (NOLOCK) ON VW_TigerDovizTurleri.CURTYPE =Talep.VW_TigerDovizTurleriId
where  TALEP.DurumKodu='ONY'   
  order by Tarih desc , OnayDokumanId desc