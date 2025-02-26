SELECT 
    dc.DenetlemeKontrolId,
    dc.DevriyeSubelerId,
    ds.DevriyeSubeAdi,
    dc.DenetlenenUserId,
    dn.DisplayName AS DenetlenenAdiSoyadi,
    ISNULL(dc.DenetlenenPersonelAciklama, '') AS DenetlenenPersonelAciklama,
    dc.Tarih,
    kh.HususKodu AS KontrolHususKodu,
    unp.KontrolHusus AS KontrolHususDegeri,
    kh.Aciklama AS KontrolHususAciklama,
    dc.DenetleyenUserId,
    dy.DisplayName AS DenetleyenAdiSoyadi,
    dc.DenetleyenPersonelAciklama
FROM 
    DenetlemeKontrol dc WITH (NOLOCK)
LEFT JOIN Users dy WITH (NOLOCK) ON dy.UserId = dc.DenetleyenUserId
LEFT JOIN Users dn WITH (NOLOCK) ON dn.UserId = dc.DenetlenenUserId
LEFT JOIN DevriyeSubeler ds WITH (NOLOCK) ON ds.DevriyeSubelerId = dc.DevriyeSubelerId
CROSS APPLY (
    SELECT 'KontrolHusus1', KontrolHusus1 UNION ALL
    SELECT 'KontrolHusus2', KontrolHusus2 UNION ALL
    SELECT 'KontrolHusus3', KontrolHusus3 UNION ALL
    SELECT 'KontrolHusus4', KontrolHusus4 UNION ALL
    SELECT 'KontrolHusus5', KontrolHusus5 UNION ALL
    SELECT 'KontrolHusus6', KontrolHusus6 UNION ALL
    SELECT 'KontrolHusus7', KontrolHusus7 UNION ALL
    SELECT 'KontrolHusus8', KontrolHusus8 UNION ALL
    SELECT 'KontrolHusus9', KontrolHusus9 UNION ALL
    SELECT 'KontrolHusus10', KontrolHusus10 UNION ALL
    SELECT 'KontrolHusus11', KontrolHusus11 UNION ALL
    SELECT 'KontrolHusus12', KontrolHusus12 UNION ALL
    SELECT 'KontrolHusus13', KontrolHusus13 UNION ALL
    SELECT 'KontrolHusus14', KontrolHusus14
) unp (HususKodu, KontrolHusus)
LEFT JOIN KontrolHususlari kh WITH (NOLOCK) ON kh.HususKodu = unp.HususKodu
ORDER BY dc.DenetlemeKontrolId, kh.Id;
