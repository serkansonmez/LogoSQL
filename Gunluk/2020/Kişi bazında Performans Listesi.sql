SELECT ROW_NUMBER() over (order by avg(ortalama ) desc ) as SiraNo,TBL.PerformansDonemiId,avg(ortalama) as ortalama,UcretPersonelId,AdiSoyadi 
,tblGenel.FirmaOrtalama

FROM 
(
select PerformansDonemiId,PerformansAnaHedefleriId,avg(Seviye2) as ortalama,UcretPersonelId,AdiSoyadi from VW_PerformansSonucSeviyelerIcmali WHERE PerformansAnaHedefleriId = 1
group by PerformansDonemiId,PerformansAnaHedefleriId,UcretPersonelId,AdiSoyadi  
UNION ALL
-- ÞUBE
select PerformansDonemiId,PerformansAnaHedefleriId,avg(PuanDegeri) as ortalama,UcretPersonelId,AdiSoyadi from VW_PerformansHareketlerAnaHedefliPersonelIcmal
group by PerformansDonemiId,PerformansAnaHedefleriId,UcretPersonelId,AdiSoyadi  )   TBL --where AdiSoyadi = 'cengiz özbek'

left join ( select PerformansDonemiId,avg(Ortalama) as FirmaOrtalama from 
					(select PerformansDonemiId, avg(Seviye2) as ortalama  from VW_PerformansSonucSeviyelerIcmali WHERE PerformansAnaHedefleriId = 1
				group by PerformansDonemiId 
				UNION ALL
				-- ÞUBE
				select PerformansDonemiId, avg(PuanDegeri) as ortalama  from VW_PerformansHareketlerAnaHedefliPersonelIcmal
				group by PerformansDonemiId  ) as tmp 
				group by PerformansDonemiId) tblGenel on tblGenel.PerformansDonemiId = TBL.PerformansDonemiId
GROUP BY TBL.PerformansDonemiId,UcretPersonelId,AdiSoyadi ,tblGenel.FirmaOrtalama 

