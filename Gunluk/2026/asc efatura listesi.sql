SELECT 
T0.[Id] AS [Id],
T0.[RowDeleted] AS [RowDeleted],
T0.[RowUpdatedTime] AS [RowUpdatedTime],
T0.[RowUpdatedBy] AS [RowUpdatedBy],
T0.[FirmalarId] AS [FirmalarId],
T0.[TalepYapanId] AS [TalepYapanId],
T0.[TalepKonusu] AS [TalepKonusu],
T0.[Tarih] AS [Tarih],
T0.[MesajMetni] AS [MesajMetni],
T0.[Aciklama1] AS [Aciklama1],
--CASE WHEN T0.OnayTurleriId =2 THEN jGrupluFatura.Faturalar else T0.Aciklama2 END AS [Aciklama2],
T0.[TalepTutari] AS [TalepTutari],
T0.[OnayTurleriId] AS [OnayTurleriId],
T0.[IptalTarihi] AS [IptalTarihi],
T0.[IptalEdenId] AS [IptalEdenId],
T0.[IptalAciklama] AS [IptalAciklama],
T0.[OnayMekanizmalariId] AS [OnayMekanizmalariId],
T0.[EkliDosyalar] AS [EkliDosyalar],
--jOnayIslemleri.[DurumKodu] AS [OnayDurumu],
--jOnayIslemleri.[Tarih] AS [OnayIslemleriTarih],
--(SELECT u.[DisplayName] FROM [dbo].[Users] u WHERE u.[UserId] = jOnayIslemleri.[KaydedenKullaniciId]) AS [OnaylayanDisplayName],
jFirmaBilgileri.[Unvan] AS [FirmaUnvan],
--jEFaturaListesiTekli.KayitId AS [KayitId],
--jEFaturaListesiTekli.EfaturaId AS [EfaturaId],
--jEFaturaListesiTekli.BelgeTarihi AS [FaturaBelgeTarihi],
--jEFaturaListesiTekli.EvrakTarihi AS [ZarfTarihi],
T0.[SorumlulukMerkeziId] AS [SorumlulukMerkeziId],
jSorumlulukMerkezi.[Kodu] + '-' + jSorumlulukMerkezi.[Adi] AS [SorumlulukMerkeziAdi],
T0.[DovizCinsiId] AS [DovizCinsiId],
jDovizCinsi.[DovizKodu] AS [DovizKodu],
jTalepYapan.[DisplayName] AS [TalepYapanDisplayName],
jOnayTurleri.[TurAdi] AS [OnayTurleriTurAdi] 
FROM [dbo].[OnayTalepleri] T0 
  LEFT JOIN [VW_OnayTalepleriGrupluFatura] jGrupluFatura ON (jGrupluFatura.[OnayTalepleriId]   = T0.[Id]) 
  LEFT JOIN [VW_OnayIslemleriSonDurum] jOnayIslemleri ON (jOnayIslemleri.[OnayTalepleriId]   = T0.[Id]) 
LEFT JOIN [dbo].[FirmaBilgileri] jFirmaBilgileri with(nolock) ON  (jFirmaBilgileri.[Id] = T0.[FirmalarId]) 
 LEFT JOIN [VW_EFaturaListesiTekli] jEFaturaListesiTekli ON (jEFaturaListesiTekli.OnayTalepleriId = T0.[Id])   and jFirmaBilgileri.Id =jEFaturaListesiTekli.FirmaBilgileriId
LEFT JOIN [dbo].[SorumlulukMerkezi] jSorumlulukMerkezi  with(nolock) ON (jSorumlulukMerkezi.[Id] = T0.[SorumlulukMerkeziId]) 
LEFT JOIN [dbo].[DovizCinsi] jDovizCinsi  with(nolock) ON (jDovizCinsi.[Id] = T0.[DovizCinsiId]) 
LEFT JOIN [dbo].[Users] jTalepYapan  with(nolock) ON (jTalepYapan.[UserId] = T0.[TalepYapanId]) 
LEFT JOIN [dbo].[OnayTurleri] jOnayTurleri  with(nolock) ON (jOnayTurleri.[Id] = T0.[OnayTurleriId]) 
WHERE (T0.[RowDeleted] = 0) AND 
(T0.[OnayTurleriId] = 2)


-- select * from [VW_OnayTalepleriGrupluFatura]
 --select * from [VW_EFaturaListesiTekli]