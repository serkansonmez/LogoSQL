-- muhasebe ba sorgusu
select Sirano, Mukunvan, Ukodu, Mukvergino, Bsayisi, Bedel, Donem,Vergino, Vergidairesi, Unvan, Ad , Ayindex, Digertoplam, Sirno, EM_ID,CARIGEN.* from bformua 

 left JOIN TUÐRAL_DÖKÜM_LTD_2022T.. CARIGEN ON CARIGEN.VERGINO = Mukvergino
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS BAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS BAKIYE 
                        from TUÐRAL_DÖKÜM_LTD_2022T.. CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID
						where Mukvergino<>''

SELECT * FROM tugraldb..OnlineMutabakat


-- muhasebe bs sorgusu
select Sirano, Mukunvan, Ukodu, Mukvergino, Bsayisi, Bedel, Donem,Vergino, Vergidairesi, Unvan, Ad , Ayindex, Digertoplam, Sirno, EM_ID from bformus

 