select * FROM          dbo.OnayMekanizmaAdimlari  with(nolock) 
left JOIN    dbo.OnayMekanizmalari with(nolock)  ON dbo.OnayMekanizmalari.id = dbo.OnayMekanizmaAdimlari.OnayMekanizmaId 
LEFT OUTER JOIN   dbo.OnayBolgeSube with(nolock)  ON dbo.OnayMekanizmalari.OnayBolgeSubeId = dbo.OnayBolgeSube.Id 
left JOIN     dbo.OnayTurleri with(nolock)  ON dbo.OnayMekanizmalari.OnayTurId = dbo.OnayTurleri.Id 
INNER JOIN  dbo.OnayGruplari  with(nolock) ON dbo.OnayMekanizmaAdimlari.OnaylayanGrubuId = dbo.OnayGruplari.id
  left join VW_ProjeKodu on VW_ProjeKodu.Id = OnayMekanizmalari.ProjeId
  left join Proje  with(nolock) on Proje.Id = OnayMekanizmalari.ProjeId
  left join Kullanicilar with(nolock)  on OnayGruplari.KullaniciId = Kullanicilar.id
 LEFT OUTER JOIN
  dbo.Firmalar  with(nolock) ON dbo.OnayMekanizmalari.FirmaKodu = dbo.Firmalar.No and ISNUMERIC(Firmalar.No) = 1