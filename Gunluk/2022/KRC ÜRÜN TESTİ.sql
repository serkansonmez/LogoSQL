select * from Urunler where Aciklama like 'Emas%'  --Emas A12B1K11

update Urunler set LogoMalzemeKodu = 'EM A12B1K11' where UrunlerId = 2972
 


select * from TIGER3..LG_003_PRCLIST WHERE CARDREF = 6325
--update TIGER3..LG_003_PRCLIST set  cardref = 6224 where LOGICALREF = 5115

select * from TIGER3..LG_003_ITEMS WHERE LOGICALREF = 6151

--select * from TIGER3..LG_003_ITEMS WHERE code  = 'EM A12B1K11'

-- UPDATE TIGER3..LG_003_ITEMS SET CODE= 'EM A12B1K11' WHERE LOGICALREF = 2207

-- SELECT TOP 1 * FROM [VW_TigerStokListesi] WHERE StokKodu = 'EM A12B1K11'