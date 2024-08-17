declare @FirmaKodu int = 57
declare @DonemKodu int = 2022
declare @Ay int = 1


select   CRK as CariHesapKodu ,Mukunvan as Unvan,EPOSTA,  CARIGEN.VERGINO ,Bsayisi AS Adet, Bedel as Bakiye, 'B' BakiyeTuru,GUNCELBAKIYETURU,GUNCELBAKIYE,320 AS HesapTuru,bformua.* from bformua 

 left JOIN TUÐRAL_DÖKÜM_LTD_2022T.. CARIGEN ON CARIGEN.VERGINO = Mukvergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
                        from TUÐRAL_DÖKÜM_LTD_2022T.. CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID
						where Mukvergino<>''



select   CRK as CariHesapKodu ,Mukunvan as Unvan,EPOSTA,  CARIGEN.VERGINO ,Bsayisi AS Adet, Bedel as Bakiye, 'B' BakiyeTuru,GUNCELBAKIYETURU,GUNCELBAKIYE,120 AS HesapTuru,bformus.* from bformus 

 left JOIN TUÐRAL_DÖKÜM_LTD_2022T.. CARIGEN ON CARIGEN.VERGINO = Mukvergino  
                        LEFT JOIN (Select   Max(CARIP_ID) AS CARIP_ID ,BORC=Round(SUM(TUTARB),6),ALACAK=Round(SUM(TUTARA),6)  , CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN 'B' 
                                                                                     WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN 'A' ELSE '-' END AS GUNCELBAKIYETURU
                        ,CASE WHEN Round(SUM(TUTARB),6)>Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARB),6) - Round(SUM(TUTARA),6)
                        WHEN  Round(SUM(TUTARB),6)<Round(SUM(TUTARA),6) THEN  Round(SUM(TUTARA),6) - Round(SUM(TUTARB),6) ELSE 0 END AS GUNCELBAKIYE 
                        from TUÐRAL_DÖKÜM_LTD_2022T.. CARIT_ISLEM_TUTAR()  CARIP_ID 
                        group by CARIP_ID ) AS tblBakiye on tblBakiye.CARIP_ID = CARIGEN.P_ID
						where Mukvergino<>''


SELECT * FROM tugraldb..OnlineMutabakat

	SELECT * from tugraldb..OnlineMutabakat where LogoDonemKodu =  2022 and Ay = 1 and OnlineMutabakatTurleriId>1 and 
                                     GuncelBakiye<5000 and OnlineMutabakatDurumuId=1