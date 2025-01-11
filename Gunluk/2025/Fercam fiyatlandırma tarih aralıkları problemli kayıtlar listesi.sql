SELECT DISTINCT a.fercam_distributor_artikelId,
fercam_distributor_artikel.artikelnummer
,fercam_distributor_artikel.id_distributor
FROM fercam_distributor_artikel_price a
JOIN fercam_distributor_artikel_price b
  ON a.fercam_distributor_artikelId = b.fercam_distributor_artikelId
  AND a.Id <> b.Id
  AND a.FirstDate <= b.LastDate
  AND a.LastDate >= b.FirstDate
  left join fercam_distributor_artikel on fercam_distributor_artikel.id =  a.fercam_distributor_artikelId
   --where fercam_distributor_artikel.artikelnummer like '%shr%'
   --where fercam_distributor_artikel.id_distributor= 1
  order by artikelnummer