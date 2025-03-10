            Declare @IlkTarih  DateTime ='20250101'
                       Declare @SonTarih   DateTime ='20250228'
                       Declare @DurumId  VarChar(50) = '-1,1,2'
                       Declare @SonrakiOperasyon  VarChar(50) ='Firin'
                       Declare @KullaniciYetkiTurleriId Int =7
                       Declare @KullaniciId  Int =2
--SELECT value FROM   string_split(@DurumId, ',')
SELECT 
LOGICALREF ,
SiparisNo ,
MusteriSiparisNo ,
SiparisTarihi ,
MalzemeKodu ,
UretimEmriNo ,
RotaKodu ,
FirinRotaKodu ,
UrunKodu ,
FirmaKodu ,
FirmaAdi ,
SiparisAdet ,
KesimAdet ,
Renk ,
En ,
Boy ,
Kalinlik ,
SiparisToplamAlan ,
Firin ,
Serigraf ,
ToplamCap ,
BirimM2 ,
MevcutOperasyonDurumu ,
SonrakiOperasyon ,
KesimPlanlanan ,
KesilenAdet ,
KesimSehpaAdet ,
KesimHurdaCamAdet ,
KesimDurumId ,
KesimDurumAdi ,
KesimIsIstasyonlariId ,
KesimIseBaslangicSaati ,
BandoPlanlanan ,
BandoSaglamAdet ,
BandoSehpaAdet ,
BandoHurdaCamAdet ,
BandoDurumId ,
BandoDurumAdi ,
BandoIsIstasyonlariId ,
BandoIseBaslangicSaati ,
CncPlanlanan ,
CncSaglamAdet ,
CncSehpaAdet ,
CncHurdaCamAdet ,
CncDurumId ,
CncDurumAdi ,
CncIsIstasyonlariId ,
CncIseBaslangicSaati ,
DelikPlanlanan ,
DelikSaglamAdet ,
DelikSehpaAdet ,
DelikHurdaCamAdet ,
DelikDurumId ,
DelikDurumAdi ,
DelikIsIstasyonlariId ,
DelikIseBaslangicSaati ,
SerigrafPlanlanan ,
SerigrafSaglamAdet ,
SerigrafSehpaAdet ,
SerigrafHurdaCamAdet ,
SerigrafDurumId ,
SerigrafDurumAdi ,
SerigrafIsIstasyonlariId ,
SerigrafIseBaslangicSaati ,
FirinPlanlanan ,
FirinSaglamAdet ,
FirinSehpaAdet ,
FirinHurdaCamAdet ,
FirinDurumId ,
FirinDurumAdi ,
FirinIsIstasyonlariId ,
FirinIseBaslangicSaati ,
RezistansPlanlanan ,
RezistansSaglamAdet ,
RezistansSehpaAdet ,
RezistansHurdaCamAdet ,
RezistansDurumId ,
RezistansDurumAdi ,
RezistansIsIstasyonlariId ,
RezistansIseBaslangicSaati ,
PaketlemePlanlanan ,
PaketlemeSaglamAdet ,
PaketlemeSehpaAdet ,
PaketlemeHurdaCamAdet ,
PaketlemeDurumId ,
PaketlemeDurumAdi ,
PaketlemeIsIstasyonlariId ,
PaketlemeIseBaslangicSaati ,
ShrinkPlanlanan ,
ShrinkSaglamAdet ,
ShrinkSehpaAdet ,
ShrinkHurdaCamAdet ,
ShrinkDurumId ,
ShrinkDurumAdi ,
ShrinkIsIstasyonlariId ,
ShrinkIseBaslangicSaati FROM VW_UretimPlanlama WITH (NOLOCK)  WHERE KesilenAdet>0 and   SiparisTarihi between @IlkTarih and @SonTarih 
and  (
     FirinDurumId IN (SELECT value FROM STRING_SPLIT(@DurumId, ','))
      OR @DurumId = '-1'

  )
and FirinRotaKodu in (select RotaKodu from KullaniciYetkileri 
left join IsIstasyonlari on IsIstasyonlari.IsIstasyonlariId = YetkiTableId
where KullaniciYetkiTurleriId = @KullaniciYetkiTurleriId and KullaniciId = @KullaniciId) 


select RotaKodu from KullaniciYetkileri WITH(NOLOCK)
left join IsIstasyonlari  WITH(NOLOCK) on IsIstasyonlari.IsIstasyonlariId = YetkiTableId
where KullaniciYetkiTurleriId = 7 and KullaniciId = 2

select  MalzemeKodu from VW_UretimPlanlama where FirinRotaKodu = '' group by MalzemeKodu 

select  FirinRotaKodu ,count(FirinRotaKodu) as Sayi from VW_UretimPlanlama where FirinRotaKodu is not null group by FirinRotaKodu 

SELECT *FROM UretimRotaBaglanti where FercamKodu	 = 'F.081.00.132'