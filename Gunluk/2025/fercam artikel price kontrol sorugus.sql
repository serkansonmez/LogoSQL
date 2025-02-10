select * from VW_fercam_distributor_artikel_LastPrice where fercam_distributor_artikelId = 2303

select * from fercam_distributor_artikel_price_20230215 
left join fercam_distributor_artikel_price on fercam_distributor_artikel_price.id = fercam_distributor_artikel_price_20230215.id
where  fercam_distributor_artikel_price.id is null and   fercam_distributor_artikel_price_20230215.fercam_distributor_artikelId = 1247




select * from FercamB2B_Default_v1_20250130..fercam_distributor_artikel_price where fercam_distributor_artikelId = 2213
 