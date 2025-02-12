 CREATE VIEW VW_ZirveCariListesiTumu as 
select '2017' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL as Tel2 from �REN_PVC_2017T.dbo.LISTECARILER()
UNION 
select '2018' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2018T.dbo.LISTECARILER()
UNION 
select '2019' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2019T.dbo.LISTECARILER()
UNION 
select '2020' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2020T.dbo.LISTECARILER()
UNION 
select '2021' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2021T.dbo.LISTECARILER()
UNION 
select '2022' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2022T.dbo.LISTECARILER()
UNION 
select '2023' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2023T.dbo.LISTECARILER()
UNION 
select '2024' as YIL, CRK,STA,VERGINO,VERGID,ADRES1,TELEFON,FAKS,SEMT,SEHIR,YETKILI,GRUP1,AKTEL + ' ' + TEL from �REN_PVC_2024T.dbo.LISTECARILER()


select * from AlvinB2B_Default_v1..VW_ZirveCariListesiTumu