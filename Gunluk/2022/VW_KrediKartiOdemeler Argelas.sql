create view VW_KrediKartiTahsilatListesi as 
select Id,LogoFisNo,InsertDate as FisTarihi,'Kredi Kartý Fiþi' as FisTuru, '                ' as OzelKod,TigerCariKodu as CariHesapKodu,cari.DEFINITION as CariHesapUnvani
,'          ' as MakbuzNo, '    ' as SatirAciklama, KrediKartiOdemeler.Amount as Tutar,  cari.DEFINITION  + ' SANAL POS C TAHSÝLATI' as Notlar,dbo.fnc_ParayiYaziyaCevir(KrediKartiOdemeler.Amount,1) as Yalniz  from KrediKartiOdemeler
CROSS APPLY fnc_CariListesiByCariKodu('6',TigerCariKodu) cari  WHERE cari.CODE = TigerCariKodu
and KrediKartiOdemeler.IsActive = 1

 SELECT * FROM EmySeriLotEnvanter