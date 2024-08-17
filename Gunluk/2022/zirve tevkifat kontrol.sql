        select DISTINCT NEWID() AS Referans, --gmkod as 'CariHesapKodu',
--(select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'CARIADI',
 CARIGEN.CRK AS 'CariHesapKodu', CARIGEN.STA AS 'CARIADI', CARIGEN.EPOSTA ,Vergino AS VERGINO,  count(gmkod) as EVRAKADEDI,
   sum(alacakli) as 'TUTAR',
 'A' AS BAKIYETURU, GUNCELBAKIYETURU, GUNCELBAKIYE,gmkod as HesapTuru, (select hesplan.aciklama from hesplan where gmkod  COLLATE Turkish_CS_AS  =kod  COLLATE Turkish_CS_AS  ) as 'HesapAciklama', aciklama 
    
from yevmiye 
left JOIN  TUÐRAL_DÖKÜM_LTD_2022T..CARIGEN ON CARIGEN.VERGINO = Vergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
						
                        from TUÐRAL_DÖKÜM_LTD_2022T..CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID

where gmkod like '391.20%'  and (Islemtipi  IN (1,3)) and  MONTH(Fistar) =  1  AND  CARIGEN.CRK NOT LIKE '%-159' AND CARIGEN.CRK LIKE '120%'
group by gmkod,aciklama,Vergino, CARIGEN.CRK , CARIGEN.STA ,CARIGEN.EPOSTA,GUNCELBAKIYETURU, GUNCELBAKIYE