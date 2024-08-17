SELECT * FROM fercam_distributor

select * from fercam_distributor_artikel 
left join VW_DistributorArticleList on 
VW_DistributorArticleList.DistributorArticleNummer = fercam_distributor_artikel.artikelnummer and VW_DistributorArticleList.id_distributor = fercam_distributor_artikel.id_distributor
and fercam_distributor_artikel.id_artikel = VW_DistributorArticleList.id_artikel
--where VW_DistributorArticleList.FercamNummer = '12 001' 

select * from VW_DistributorArticleList

SELECT * FROM fercam_artikel