SELECT Id ,
OnayTalepleriId ,
MalzemeKodu ,
MalzemeAdi ,
Miktar ,
Birim ,
OdemeVadesi ,
BirimFiyati ,
FirmaId ,
VergiNo ,
VergiDairesi ,
Eposta ,
Telefon ,
DovizTuruId ,
DovizTuru ,
SirketAdi ,
FirmaLogo ,
Tarih ,
TedarikCariReferans ,
TedarikFirmasiHesapKodu ,
TedarikFirmasiAdi ,
LogoSiparisAktarildiMi , 
LogoSiparisNo ,
                  MalzemeBirimKodu ,
                  MalzemeBirimAdi  ,
				  case when FirmaLogo = 'ÝPLÝK' THEN 1
				  when FirmaLogo = 'BOYAHANE' THEN 2
				  when FirmaLogo = 'DOKUMA' THEN 3 ELSE 0 END
				  ,


				  case when FirmaLogo = 'ÝPLÝK' THEN 1
  when FirmaLogo = 'BOYAHANE' THEN 2
    when FirmaLogo = 'DOKUMA' THEN 3 END , [VW_SatinalmaTalepFormuTedarikci].Id,
	'UPDATE OnayTalepleri SET  TigerAmbarNr=''' + CAST(case when FirmaLogo = 'ÝPLÝK' THEN 1
  when FirmaLogo = 'BOYAHANE' THEN 2
    when FirmaLogo = 'DOKUMA' THEN 3 ELSE 0 END AS varchar(20))  + ''' WHERE id=' + cast([VW_SatinalmaTalepFormuTedarikci].OnayTalepleriId as varchar(20))

				  FROM VW_SatinalmaTalepFormuTedarikci WITH (NOLOCK) 