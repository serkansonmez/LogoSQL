USE TUÐRAL_DÖKÜM_LTD_2022
GO 
SELECT * FROM fnHesapPlaniGetir(NULL)
WHERE (detay = 'E')  ORDER BY Kod


--2
SELECT Kod COLLATE Turkish_CI_AS, MAX(Kod), MIN(Kod) FROM (SELECT DISTINCT Kod FROM hesplan) as tbl GROUP BY Kod COLLATE Turkish_CI_AS HAVING COUNT(*)>1

--3 
select sum(Borclu) as [BTop], sum(Alacakli) as [ATop],
(select sum(Doviz) from yevmiye where gmkod='391.20.020'  and  Islemtipi  IN (1,3)  and  Fistar<'01.01.2022'  and borclu>0) as [DBorç], (select sum(Doviz) from yevmiye where gmkod='391.20.020'  and  Islemtipi  IN (1,3)  and  Fistar<'01.01.2022'  and alacakli>0) as [DAlacak],
(select sum(Miktar) from yevmiye where gmkod='391.20.020'  and  Islemtipi  IN (1,3)  and  Fistar<'01.01.2022'  and borclu>0) as [Giriþ Miktarý], (select sum(Miktar) from yevmiye where gmkod='391.20.020'  and  Islemtipi  IN (1,3)  and  Fistar<'01.01.2022'  and alacakli>0) as [Çýkýþ Miktarý]
from yevmiye where gmkod='391.20.020'  and  Islemtipi  IN (1,3)  and  Fistar<'01.01.2022'
--4 TEVKÝFAT SATIÞ 391.20 detay sorgusu
select gmkod as 'Hesap Kodu',
(select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'Hesap Adý',
fistar as 'Fiþ Tarihi',fistur as 'Fiþ Türü',fisno as 'Fiþ No',yevno as 'Yevmiye No',
aciklama as 'Açýklama',borclu as 'Borç Tutarý', alacakli as 'Alacak Tutarý',
Refno,Refno2 as 'SiraNo', Sube as 'Þube', Masrafmerkezi as 'Masraf Merkezi',
Stk as 'Stok Kodu', Miktar as 'Miktar', (select dovizcinsi from zirvegenel..dovizcin where (isnull(Dovizadi,0)=kod) and (kod>1)) as 'Para Birimi', Doviz as 'Döviz Tutarý',Evraktarihi as 'Evrak Tarihi',Evrakno as 'Evrak No',Vergino,Serino,Belge_Turu,Belge_Turu_Aciklamasi 
from yevmiye where gmkod='391.20.020'  and (Islemtipi  IN (1,3)) and ((Fistar>='20220101') and (Fistar<='20220131')) 

order by fistar,fistur,fisno,refno2
--satýþ benzeri
 select  NEWID() AS Referans,  CRK as CariHesapKodu ,Mukunvan as CARIADI,EPOSTA,  CARIGEN.VERGINO ,Bsayisi AS EVRAKADEDI, Bedel as TUTAR, 'B' BAKIYETURU,GUNCELBAKIYETURU,GUNCELBAKIYE,320 AS HesapTuru from bformua 

 left JOIN TUÐRAL_DÖKÜM_LTD_2022T.. CARIGEN ON CARIGEN.VERGINO = Mukvergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
                        from TUÐRAL_DÖKÜM_LTD_2022T.. CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID
						 where Mukvergino<>'' AND Ayindex= 1

						 -- satýþ gruplu sorgusu
  select DISTINCT NEWID() AS Referans, --gmkod as 'CariHesapKodu',
--(select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'CARIADI',
 CARIGEN.CRK AS 'CariHesapKodu', CARIGEN.STA AS 'CARIADI', CARIGEN.EPOSTA ,Vergino AS VERGINO,  count(gmkod) as EVRAKADEDI,
   sum(alacakli) as 'TUTAR',
 'A' AS BakiyeTuru, GUNCELBAKIYETURU, GUNCELBAKIYE,gmkod as HesapTuru, (select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'HesapAciklama', aciklama 
    
from yevmiye 
left JOIN  TUÐRAL_DÖKÜM_LTD_2022T..CARIGEN ON CARIGEN.VERGINO = Vergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
						
                        from TUÐRAL_DÖKÜM_LTD_2022T..CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID

where gmkod like '391.20%'  and (Islemtipi  IN (1,3)) and  MONTH(Fistar) = 1 AND  CARIGEN.CRK NOT LIKE '%-159' AND CARIGEN.CRK LIKE '120%'
group by gmkod,aciklama,Vergino, CARIGEN.CRK , CARIGEN.STA ,CARIGEN.EPOSTA,GUNCELBAKIYETURU, GUNCELBAKIYE

--5 TEVKÝFAT ALIÞ gruplu 360.16  sorgusu olacak
select gmkod as 'Hesap Kodu',
(select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'Hesap Adý',
fistar as 'Fiþ Tarihi',fistur as 'Fiþ Türü',fisno as 'Fiþ No',yevno as 'Yevmiye No',
aciklama as 'Açýklama',borclu as 'Borç Tutarý', alacakli as 'Alacak Tutarý',
Refno,Refno2 as 'SiraNo', Sube as 'Þube', Masrafmerkezi as 'Masraf Merkezi',
Stk as 'Stok Kodu', Miktar as 'Miktar', (select dovizcinsi from zirvegenel..dovizcin where (isnull(Dovizadi,0)=kod) and (kod>1)) as 'Para Birimi', Doviz as 'Döviz Tutarý',Evraktarihi as 'Evrak Tarihi',Evrakno as 'Evrak No',Vergino,Serino,Belge_Turu,Belge_Turu_Aciklamasi 
from yevmiye where gmkod like '360.16%'  and (Islemtipi  IN (1,3)) and ((Fistar>='20220101') and (Fistar<='20220131')) 

order by fistar,fistur,fisno,refno2


-- ALIÞ BENZERÝ
 select  NEWID() AS Referans,  CRK as CariHesapKodu ,Mukunvan as CARIADI,EPOSTA,  CARIGEN.VERGINO ,Bsayisi AS EVRAKADEDI, Bedel as TUTAR, 'B' BAKIYETURU,GUNCELBAKIYETURU,GUNCELBAKIYE,120 AS HesapTuru from bformus 

 left JOIN  TUÐRAL_DÖKÜM_LTD_2022T..CARIGEN ON CARIGEN.VERGINO = Mukvergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
                        from TUÐRAL_DÖKÜM_LTD_2022T..CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID
						where Mukvergino<>'' AND Ayindex= 1

						--Gruplu tevkifat sorgusu
select DISTINCT --gmkod as 'CariHesapKodu',
--(select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'CARIADI',
 CARIGEN.CRK AS 'CariHesapKodu', CARIGEN.STA AS 'CARIADI', CARIGEN.EPOSTA ,Vergino AS VERGINO,  count(gmkod) as EVRAKADEDI,
   sum(alacakli) as 'TUTAR',
 'A' AS BakiyeTuru, GUNCELBAKIYETURU, GUNCELBAKIYE,gmkod as HesapTuru, (select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'HesapAciklama', aciklama 
    
from yevmiye 
left JOIN  TUÐRAL_DÖKÜM_LTD_2022T..CARIGEN ON CARIGEN.VERGINO = Vergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
						
                        from TUÐRAL_DÖKÜM_LTD_2022T..CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID

where gmkod like '360.16%'  and (Islemtipi  IN (1,3)) and  MONTH(Fistar) = 1 AND  CARIGEN.CRK NOT LIKE '%-159' AND CARIGEN.CRK LIKE '320%'
group by gmkod,aciklama,Vergino, CARIGEN.CRK , CARIGEN.STA ,CARIGEN.EPOSTA,GUNCELBAKIYETURU, GUNCELBAKIYE
--SELECT * FROM TUÐRAL_DÖKÜM_LTD_2022T..CARIGEN 