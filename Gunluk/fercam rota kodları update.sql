select 
'update LG_XT050_024 set ROTA_KODU =''' + isnull(ExcelUretimRotaKodlari.Rota,'') +  ''' ,FIRIN_ROTA_KODU =''' + isnull(ExcelUretimRotaKodlari.FirinRotasi,'') + 
''' WHERE PARLOGREF = '  + CAST(ITM.LOGICALREF AS varchar(20)),
* from ExcelUretimRotaKodlari
left join LG_024_ITEMS ITM ON ITM.CODE = ExcelUretimRotaKodlari.Referanslar
WHERE ITM.CODE is not null

-- SELECT * from ExcelUretimRotaKodlari WHERE REFERANSLAR = '06 001'

select * from LG_024_ITEMS where LOGICALREF = 4428

 