USE [GINSOFT_NET_PROD]
GO

/****** Object:  View [dbo].[VW_ONAY_ROTALARI_LISTESI]    Script Date: 13.01.2022 23:20:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[VW_ONAY_ROTALARI_LISTESI] AS

SELECT top 100000 dbo.OnayMekanizmalari.id AS RotaNo,    dbo.OnayMekanizmalari.Adi AS RotaAdi, 
dbo.OnayMekanizmalari.FirmaKodu, 
dbo.OnayMekanizmalari.AltLimit, dbo.OnayMekanizmalari.UstLimit, 
                      dbo.OnayTurleri.TurAdi, 
                      dbo.OnayGruplari.Adi + '-' + Kullanicilar.AdiSoyadi as OnayGrubu, 
                      dbo.OnayBolgeSube.BolgeSubeAdi, dbo.OnayMekanizmaAdimlari.AdimSiraNo, 
                      dbo.OnayMekanizmaAdimlari.Kime, dbo.OnayMekanizmaAdimlari.Bilgi, dbo.OnayMekanizmaAdimlari.Gizli,
                      case when OnayMekanizmalari.PasifMi = 1 then 'Pasif' else 'Aktif' end as AktifPasif
            ,(select COUNT(id) from OnayIslemleri  where AdimSiraNo = 1  and OnayMekanizmaId = OnayMekanizmalari.id ) as IslemSayisi
            ,(select max(Tarih) from OnayIslemleri  where AdimSiraNo = 1  and OnayMekanizmaId = OnayMekanizmalari.id ) as SonIslemTarihi
			,Firmalar.Adi + ' (' + cast(dbo.OnayMekanizmalari.FirmaKodu COLLATE DATABASE_DEFAULT  as varchar(20)) + ')' as FirmaAdi 
FROM         dbo.OnayMekanizmalari INNER JOIN
  dbo.OnayMekanizmaAdimlari ON dbo.OnayMekanizmalari.id = dbo.OnayMekanizmaAdimlari.OnayMekanizmaId LEFT OUTER JOIN
  dbo.OnayBolgeSube ON dbo.OnayMekanizmalari.OnayBolgeSubeId = dbo.OnayBolgeSube.Id left JOIN
    dbo.OnayTurleri ON dbo.OnayMekanizmalari.OnayTurId = dbo.OnayTurleri.Id INNER JOIN
  
  dbo.OnayGruplari ON dbo.OnayMekanizmaAdimlari.OnaylayanGrubuId = dbo.OnayGruplari.id
  left join Kullanicilar on OnayGruplari.KullaniciId = Kullanicilar.id
 LEFT OUTER JOIN
  dbo.Firmalar ON dbo.OnayMekanizmalari.FirmaKodu = dbo.Firmalar.No and ISNUMERIC(Firmalar.No) = 1
order by RotaNo,AdimSiraNo

--select * from Firmalar

--select * from OnayIslemleri  where AdimSiraNo = 1  and OnayMekanizmaId = 




SELECT * FROM OnayIslemleri where id = 405042

-- update OnayIslemleri set Tarih = null where id = 400092

select * from Kullanicilar where kodu like 'm'
--cavC6g0fTVir6aEHp10426:APA91bGpSYM__MA_gNvBdCtz4fumgyDHTIghvYHhKVmxnaccSSRhYI37VWIRBUvjDAi2kgoFf1xsvM2cxKtdiwpLkRCxpJhL7lkRflXyrFWD9elqMukE8m5HdUVbZmxkB1rozYBr9U8V
cavC6g0fTVir6aEHp10426:APA91bGpSYM__MA_gNvBdCtz4fumgyDHTIghvYHhKVmxnaccSSRhYI37VWIRBUvjDAi2kgoFf1xsvM2cxKtdiwpLkRCxpJhL7lkRflXyrFWD9elqMukE8m5HdUVbZmxkB1rozYBr9U8V


SELECT * FROM OnayIslemleri where OnayDokumanId = 97706


