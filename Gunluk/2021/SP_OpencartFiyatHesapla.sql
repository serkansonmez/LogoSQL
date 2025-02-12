 --exec [SP_OpencartFiyatHesapla]
alter PROCEDURE [dbo].[SP_OpencartFiyatHesapla]
  
AS
BEGIN


declare @UrunlerId int
declare @LogoMalzemeKodu varchar(200)
declare @KampanyaBireyselFiyat float
declare @KampanyaKurumsalFiyat float
declare @HesaplananKampanyaBireyselFiyat float
declare @HesaplananKampanyaKurumsalFiyat float
declare @strSQL nvarchar(1024)
DECLARE firstProcesses CURSOR FOR
    select Urunler.UrunlerId  , LogoMalzemeKodu,KampanyaBireyselFiyat,KampanyaKurumsalFiyat,
	case when BireyselIskontoOran>0 then 
	       round( OpenCardHesaplananFiyat - ( OpenCardHesaplananFiyat * BireyselIskontoOran / 100),4)
    else 
	    0 end as  HesaplananKampanyaBireyselFiyat, 
   case when KurumsalIskontoOran>0 then 
	       round( OpenCardHesaplananFiyat - ( OpenCardHesaplananFiyat * KurumsalIskontoOran / 100),4)
    else 
	    0 end as  HesaplananKampanyaKurumsalFiyat
	from Urunler
	left join VW_TigerStokListesi on VW_TigerStokListesi.StokKodu = Urunler.LogoMalzemeKodu collate Turkish_CI_AS
	where  (KampanyaBireyselFiyat <> case when BireyselIskontoOran>0 then 
	       round( OpenCardHesaplananFiyat - ( OpenCardHesaplananFiyat * BireyselIskontoOran / 100),4)
    else 
	    0 end ) 
		        or 
		  (KampanyaKurumsalFiyat <>  case when KurumsalIskontoOran>0 then 
	       round( OpenCardHesaplananFiyat - ( OpenCardHesaplananFiyat * KurumsalIskontoOran / 100),4)
    else 
	    0 end )
OPEN firstProcesses
FETCH NEXT FROM firstProcesses
INTO @UrunlerId,@LogoMalzemeKodu,@KampanyaBireyselFiyat,@KampanyaKurumsalFiyat,@HesaplananKampanyaBireyselFiyat,@HesaplananKampanyaKurumsalFiyat
WHILE @@FETCH_STATUS = 0
BEGIN
   set @strSQL = 'update Urunler set  KampanyaBireyselFiyat= ' + cast( @HesaplananKampanyaBireyselFiyat as varchar(20)) + 
									 ',  KampanyaKurumsalFiyat= ' + cast( @HesaplananKampanyaKurumsalFiyat as varchar(20)) + ' where  UrunlerId= ' + cast( @UrunlerId as varchar(20))
     
 -- select @strSQL
   EXEC (@strSQL)
FETCH NEXT FROM firstProcesses
INTO  @UrunlerId,@LogoMalzemeKodu,@KampanyaBireyselFiyat,@KampanyaKurumsalFiyat,@HesaplananKampanyaBireyselFiyat,@HesaplananKampanyaKurumsalFiyat
END



CLOSE firstProcesses
DEALLOCATE firstProcesses





END