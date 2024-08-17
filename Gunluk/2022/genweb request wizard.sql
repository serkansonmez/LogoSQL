
-- select * from Kullanicilar where kodu like 'ali%'
declare @kullaniciId int = 358

-- firma Bazýnda
select CAST(firmaKodu AS INT) AS firmaKodu,FirmaAdi + ' (' + cast(sum(Sayi) as varchar(30)) + ') ' as FirmaAdi
,'-' AS OnayRenk1,
'-' AS OnayRenk2,
'-' AS OnayRenkBaslik, 
'-' AS BilgiRenk1,
'-' ASBilgiRenk2,
'-' AS BilgiRenkBaslik  from (select firmaKodu,FirmaAdi,kullaniciId,OnayTurId,RotaPasifMi,Count(firmaKodu) as Sayi from [VW_ONAY_ROTALARI] where [VW_ONAY_ROTALARI].AdimSiraNo=1 group by  firmaKodu,FirmaAdi,kullaniciId,OnayTurId,RotaPasifMi) [VW_ONAY_ROTALARI] where 
                                            kullaniciId =@kullaniciId and RotaPasifMi= '0' group by firmaKodu,FirmaAdi

select UlkeKodu, Ulke + ' (' + cast(sum(AdimSiraNo) as varchar(30)) + ') ' as Ulke from [VW_ONAY_ROTALARI] where [VW_ONAY_ROTALARI].AdimSiraNo=1  and Ulke is not null and
                                            kullaniciId =@kullaniciId and RotaPasifMi= '0' group by Ulke,UlkeKodu

select  ProjeKodu, ProjeAdi + ' (' + cast(sum(AdimSiraNo) as varchar(30)) + ') ' as Ulke from [VW_ONAY_ROTALARI] where [VW_ONAY_ROTALARI].AdimSiraNo=1  and ProjeAdi is not null and
                                            kullaniciId =@kullaniciId and RotaPasifMi= '0' group by ProjeAdi,ProjeKodu


select  TurAdi, TurAdi + ' (' + cast(sum(AdimSiraNo) as varchar(30)) + ') ' as TurAdi  from [VW_ONAY_ROTALARI] where [VW_ONAY_ROTALARI].AdimSiraNo=1  and
                                            kullaniciId =@kullaniciId and RotaPasifMi= '0' group by TurAdi


											select * from Kullanicilar where kodu like 'loren%'