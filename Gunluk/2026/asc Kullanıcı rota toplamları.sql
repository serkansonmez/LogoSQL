SELECT 
    KullaniciId = GrupUyeUserId,
    RotaTuruId = OnayTurleriId,
     FirmaBilgileriId,
    ToplamOnay = SUM(CASE WHEN DurumKodu = 'ONY' THEN 1 ELSE 0 END),
    ToplamRed = SUM(CASE WHEN DurumKodu = 'RED' THEN 1 ELSE 0 END),
    ToplamBekleyen = SUM(CASE WHEN DurumKodu = 'BEK' THEN 1 ELSE 0 END),
    ToplamIslem = COUNT(*)
FROM VW_OnayIslemToplamlari
WHERE GrupUyeUserId IS NOT NULL
GROUP BY GrupUyeUserId, OnayTurleriId,FirmaBilgileriId
ORDER BY GrupUyeUserId, OnayTurleriId,FirmaBilgileriId


--select * from Users where UserId=31
  select DurumKodu,count(DurumKodu) from OnayIslemleri  
  left join OnayMekanizmalari on OnayIslemleri.OnayMekanizmalariId = OnayMekanizmalari.Id
  where KaydedenKullaniciId = 7   and FirmaBilgileriId= 1 and OnayTurId=2
  group by DurumKodu