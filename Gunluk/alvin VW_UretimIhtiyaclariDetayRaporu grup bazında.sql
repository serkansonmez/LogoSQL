select UretimDurumu, GrupAdi  ,SUM(Miktar) as Miktar,Sum(ToplamFiyat) as ToplamTutar,sum(BoyAdet) as Adet,count(TeklifSiparisNo) as TeklifSiparisNo from VW_UretimIhtiyaclariDetayRaporu where UretimDurumu  = 'Beklemede' 
group by  GrupAdi ,UretimDurumu
 
UNION ALL
SELECT 'Tüm Gruplar' as UretimDurumu, '' as GrupAdi, SUM(Miktar) as Miktar, SUM(ToplamFiyat) as ToplamTutar, SUM(BoyAdet) as ToplamBoyAdet,count(TeklifSiparisNo) as TeklifSiparisNo
FROM VW_UretimIhtiyaclariDetayRaporu
WHERE UretimDurumu = 'Beklemede'

select UretimDurumu, GrupAdi,StokAdi,SUM(Miktar) as Miktar,Sum(ToplamFiyat) as ToplamFiyat,sum(BoyAdet) from VW_UretimIhtiyaclariDetayRaporu where UretimDurumu  = 'Beklemede' 
group by  GrupAdi,StokAdi,UretimDurumu


select * from VW_UretimIhtiyaclariDetayRaporu