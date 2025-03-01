 declare @UserId int =1134
declare @IlkTarih datetime = '20231212'
declare @SonTarih datetime = '20240110'
declare @SiparisDurumu int = -1

-- declare @IlkTarih datetime = '20130101'
--declare @SonTarih datetime = '20181231'
--declare @UserId int = 32
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
Onaylayacak.Id as OnaylayacakId,
Onaylayacak.AdiSoyadi as OnaylayacakAdiSoyadi,
Onaylayacak.ParolaHash as OnaylayacakParola,
Kullanicilar.Id as TalepEdenId,
Talep.Tarih as OnaylamaTarih,
Talep.OnayDurumu,
OnayBolgeSube.BolgeSubeAdi as SubeAdi,

isnull (Talep.TalepTutari,0) as TalepTutari,
Firmalar.SirketAdi  as Firma, 
--case when len(isnull(OnayMekanizmalari.FirmaAdi COLLATE DATABASE_DEFAULT,''))>3 then OnayMekanizmalari.FirmaAdi COLLATE DATABASE_DEFAULT else Firmalar.SirketAdi end as Firma,
OnayTurleri.TurAdi as RotaTuru,
OnayMekanizmalari.Adi as RotaAdi,
round(OnayMekanizmalari.AltLimit/100,0) as AltLimit,
round(OnayMekanizmalari.UstLimit/100,0) as UstLimit,
Kullanicilar.ParolaHash  as ParolaHash,
BankaTemsilcisi.BankaAdi 
,OnayTurleri.Id as OnayTurleriId
,Talep.VW_TigerDovizTurleriId
,VW_TigerDovizTurleri.CURCODE as DovizCinsi
,VW_TigerDovizTurleri.CURNAME as DovizAciklama

, 

CASE 
    
	 
	 
	 WHEN VW_TedarikcilereGidenMailler.Kime is not null then  '5.Tedarikçi Maili Gönderildi' 
	 WHEN len(isnull(VW_LogoyaAktarilanSiparisler.LogoSiparisNo,'')) >4 then  '4.Sipariş Fişi Aktarıldı'
	 WHEN Talep.YoneticiRaporTarihi is not null then  '3.Yönetici Raporu Alındı' 
	  WHEN VW_TeklifGidenMailler.UlasimZamani is not null then  '2.Teklif Maili Gönderildi' 
	   WHEN Talep.DurumKodu = 'RED' then '0.Talep Reddedildi'
	 else '1.Satınalma Başlangıcı'
end


/*
case when (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId and (LogoSiparisAktarildiMi>0 or LogoSiparisAktarildiMi is not null) )>0 and (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId)=
            (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId and (LogoSiparisAktarildiMi>0 or LogoSiparisAktarildiMi is not null)  )
                then 'Aktarım Tamam'
	   when (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId and (LogoSiparisAktarildiMi>0 or LogoSiparisAktarildiMi is not null) )>0 and (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId)>
            (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId and (LogoSiparisAktarildiMi>0 or LogoSiparisAktarildiMi is not null)  )
            then 'Aktarım Yarım' 
        else   'Başlamadı' end 
*/


as SiparisDurumu
,
cast((select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId) as varchar(15)) + '/' +
           cast( (select count(*) from VW_SatinalmaTalepFormuTedarikci where OnayTalepleriId = Talep.OnayDokumanId and (LogoSiparisAktarildiMi>0 or LogoSiparisAktarildiMi is not null)) as varchar(15))  as SiparisAktarim

		   ,isnull(VW_SatinalmaTalepFormuToplamlari.TlTutar,0) as TlTutar
		   ,isnull(VW_SatinalmaTalepFormuToplamlari.UsdTutar,0) as UsdTutar
		   ,isnull(VW_SatinalmaTalepFormuToplamlari.EuroTutar,0) as EuroTutar
		   ,isnull(VW_SatinalmaTalepFormuToplamlari.ChfTutar,0) as ChfTutar
,VW_TedarikcilereGidenMailler.Kime as TedarikciMail
,VW_LogoyaAktarilanSiparisler.LogoSiparisNo
,Talep.YoneticiRaporTarihi
,VW_TigerAmbar.NAME as AmbarAdi
,VW_TeklifGidenMailler.UlasimZamani as  GidenMailTarihi
,
CASE  WHEN VW_TedarikcilereGidenMailler.Kime is not null then  (select RenkKodu from SatinalmaDurumKodlari where Id = 5)
	 WHEN len(isnull(VW_LogoyaAktarilanSiparisler.LogoSiparisNo,'')) >4 then  (select RenkKodu from SatinalmaDurumKodlari where Id = 4)
	 WHEN Talep.YoneticiRaporTarihi is not null then  (select RenkKodu from SatinalmaDurumKodlari where Id = 3)
	  WHEN VW_TeklifGidenMailler.UlasimZamani is not null then  (select RenkKodu from SatinalmaDurumKodlari where Id = 2)
	   WHEN Talep.DurumKodu = 'RED' then '#FFAEBC'
	 else (select RenkKodu from SatinalmaDurumKodlari where Id = 1)
end as SiparisDurumuRengi
--FirmaId,TigerAmbarNr
 from (
select DISTINCT
q1.id, OnayDokumanId,DokumanTakipNo,OnayMekanizmaId,AdimSiraNo,DurumKodu,OnayTalepleri.RowUpdatedBy AS KaydedenKullaniciId,Aciklama,OnayTalepleri.Tarih,OnayMekanizmaAdimlariId,BankaTemsilcisiId,
case when DurumKodu in('ONY','DEN','RED','STK','SAT') then 'Rota Tamamlanmış' else 'Onay Aşamasında' end as OnayDurumu
,OnayTalepleri.TalepKonusu,OnayTalepleri.TalepTutari,OnayTalepleri.VW_TigerDovizTurleriId,YoneticiRaporTarihi,FirmaId,TigerAmbarNr from OnayIslemleri q1 with(Nolock)  
left join OnayTalepleri with(Nolock)  on OnayTalepleri.id = q1.OnayDokumanId
LEFT JOIN  Kullanici_Yetkileri ON YetkiTurleriId=1 and OnayTalepleri.RowUpdatedBy =YetkiTableId  
where q1.id in 
(select top 1 id from  OnayIslemleri q2 with(Nolock) where q2.OnayDokumanId = q1.OnayDokumanId order by q2.AdimSiraNo desc)
and OnayTalepleri.RowDeleted = '0' and OnayTalepleri.Tarih between '20230601' and @SonTarih
and  Kullanici_Yetkileri.Id is not null and  KullaniciId= @UserId  
)  as Talep
LEFT OUTER JOIN Kullanicilar with (NOLOCK) on Kullanicilar.Id = Talep.KaydedenKullaniciId
 LEFT OUTER JOIN [OnayMekanizmaAdimlari] with (NOLOCK) ON Talep.OnayMekanizmaAdimlariId =  [OnayMekanizmaAdimlari].id
 LEFT OUTER JOIN [OnayGruplari] with (NOLOCK) ON OnayGruplari.id =  [OnayMekanizmaAdimlari].OnaylayanGrubuId
 LEFT OUTER JOIN Kullanicilar  Onaylayacak with (NOLOCK) on Onaylayacak.Id = [OnayGruplari].KullaniciId
 LEFT OUTER JOIN [OnayDurumKodlari] with (NOLOCK) ON [OnayDurumKodlari].DurumKodu COLLATE DATABASE_DEFAULT =  Talep.DurumKodu COLLATE DATABASE_DEFAULT
 LEFT OUTER JOIN OnayMekanizmalari with (NOLOCK) ON [OnayMekanizmalari].id =[OnayMekanizmaAdimlari].[OnayMekanizmaId] 
 LEFT OUTER JOIN OnayBolgeSube with (NOLOCK) ON [OnayMekanizmalari].OnayBolgeSubeId =OnayBolgeSube.Id 
 LEFT OUTER JOIN OnayTurleri with (NOLOCK) ON [OnayMekanizmalari].OnayTurId =OnayTurleri.Id 
 LEFT OUTER JOIN Firmalar with (NOLOCK) ON Firmalar.SirketKodu =  OnayMekanizmalari.FirmaKodu
 LEFT OUTER JOIN BankaTemsilcisi with (NOLOCK) ON BankaTemsilcisi.Id =Talep.BankaTemsilcisiId
 LEFT OUTER JOIN VW_TigerDovizTurleri with (NOLOCK) ON VW_TigerDovizTurleri.CURTYPE =Talep.VW_TigerDovizTurleriId
 LEFT OUTER JOIN VW_SatinalmaTalepFormuToplamlari on VW_SatinalmaTalepFormuToplamlari.OnayTalepleriId = Talep.OnayDokumanId
 LEFT OUTER JOIN VW_TedarikcilereGidenMaillerTekSatir VW_TedarikcilereGidenMailler ON  VW_TedarikcilereGidenMailler.OnaytalepleriId = Talep.OnayDokumanId
 LEFT OUTER JOIN VW_LogoyaAktarilanSiparislerTekSatir VW_LogoyaAktarilanSiparisler ON  VW_LogoyaAktarilanSiparisler.OnaytalepleriId = Talep.OnayDokumanId
 LEFT OUTER JOIN VW_TigerAmbar with (NOLOCK) ON VW_TigerAmbar.FIRMNR = Talep.FirmaId  AND  VW_TigerAmbar.NR =Talep.TigerAmbarNr
 left outer join (select  * from VW_TeklifGidenMailler q1 where q1.MailTablosuId in (select top 1 MailTablosuId from VW_TeklifGidenMailler q2 where q2.OnayTalepleriId = q1.OnayTalepleriId order by Kime) ) as VW_TeklifGidenMailler on VW_TeklifGidenMailler.OnayTalepleriId = Talep.OnayDokumanId

     where  ( substring( (CASE  
			 WHEN VW_TedarikcilereGidenMailler.Kime is not null then  '5.Tedarikçi Maili Gönderildi' 
			 WHEN len(isnull(VW_LogoyaAktarilanSiparisler.LogoSiparisNo,'')) >4 then  '4.Sipariş Fişi Aktarıldı'
			 WHEN Talep.YoneticiRaporTarihi is not null then  '3.Yönetici Raporu Alındı' 
			  WHEN VW_TeklifGidenMailler.UlasimZamani is not null then  '2.Teklif Maili Gönderildi' 
			   WHEN VW_TeklifGidenMailler.UlasimZamani is not null then  '2.Teklif Maili Gönderildi' 
			    WHEN Talep.DurumKodu = 'RED' then '0.Talep Reddedildi'
			 else '1.Satınalma Başlangıcı' end),1,1) = @SiparisDurumu or @SiparisDurumu='-1')

			and  Talep.DurumKodu <> 'BEK'
  order by Tarih desc , OnayDokumanId desc 
 