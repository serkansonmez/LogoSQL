DECLARE @IlkTarih datetime = '20250222'
DECLARE @SonTarih  datetime = getdate()
declare @OperasyonTanimiId int = 2

SELECT 
LOGICALREF ,
SiparisNo ,
MusteriSiparisNo ,
SiparisTarihi ,
MalzemeKodu ,
OperasyonPlanlama.UretimEmriNo ,
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
ShrinkIseBaslangicSaati FROM OperasyonPlanlama  WITH (NOLOCK)   
 left join VW_UretimPlanlama WITH (NOLOCK)  on OperasyonPlanlama.UretimEmriNo collate Turkish_CI_AS  = VW_UretimPlanlama.UretimEmriNo and OperasyonPlanlama.OperasyonTanimiId = @OperasyonTanimiId
 WHERE cast(OperasyonPlanlama.Tarih as date) between @IlkTarih and @SonTarih   --and VW_UretimPlanlama.UretimEmriNo is not null    


SELECT * FROM TIGER..LG_025_PRODORD 
LEFT JOIN TIGER..LG_025_PEGGING ON LG_025_PEGGING.PEGREF = LG_025_PRODORD.LOGICALREF
WHERE LG_025_PEGGING.LOGICALREF IS   NULL  -- FICHENO IN '2501.0207','2502.0070','2502.0083','2502.0086')


SELECT LG_025_PEGGING.PEGREF, * FROM TIGER..LG_025_PRODORD 
LEFT JOIN TIGER..LG_025_PEGGING ON LG_025_PEGGING.PEGREF = LG_025_PRODORD.LOGICALREF
WHERE LG_025_PRODORD.FICHENO IN ('2501.0207','2502.0070','2502.0083','2502.0086')

SELECT * FROM VW_UretimPlanlama WHERE UretimEmriNo  IN ('2501.0207','2502.0070','2502.0083','2502.0086')


SELECT * FROM  TIGER..LG_025_PEGGING WHERE PEGREF =  1048