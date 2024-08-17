select * from Kullanicilar where kodu like 'bogac'

select * from VW_ONAY_ROTALARI where AdiSoyadi like 'bO%'


SELECT OnayMekanizmaAdimlari.FirmaKodu,OnayMekanizmalari.FirmaKodu,OnayMekanizmaAdimlari.id,OnayMekanizmalari.Adi
,'UPDATE OnayMekanizmaAdimlari SET FirmaKodu = '''+ OnayMekanizmalari.FirmaKodu + ''' WHERE id= ' + cast(OnayMekanizmaAdimlari.id as varchar(100))
FROM OnayMekanizmalari
LEFT Join  OnayMekanizmaAdimlari on OnayMekanizmalari.id = OnayMekanizmaAdimlari.OnayMekanizmaId
where OnayMekanizmalari.FirmaKodu <> OnayMekanizmaAdimlari.FirmaKodu