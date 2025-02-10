USE [FercamB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_KesimIsEmriToplamlari]    Script Date: 04.02.2025 10:02:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


exec dbo.SP_KesimUretimKontrol '2310.0063'
 

 --ALTER view [dbo].[VW_KesimIsEmriToplamlari] as 
CREATE PROCEDURE SP_KesimUretimKontrol @UretimEmriNo varchar(20) 
as 
begin
--DECLARE @UretimEmriNo varchar(20) = '2310.0063'
select tbl.IsEmriNo, sum(OptimizasyonAdet) as OptimizasyonAdet,sum(GerceklesenAdet) as GerceklesenAdet ,FercamKodu  , IseBaslangicSaati   from 
(select  OptimizasyonKodu, UretimEmriNo1 collate Turkish_CI_AS as IsEmriNo, OptimizasyonAdet1 as OptimizasyonAdet  , GerceklesenAdet1 as  GerceklesenAdet,UretimMalzeme1 as FercamKodu,IseBaslangicSaati  from VW_Optimizasyon_Lite where UretimEmriNo1=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo2 collate Turkish_CI_AS, OptimizasyonAdet2,  GerceklesenAdet2, UretimMalzeme2,IseBaslangicSaati    from VW_Optimizasyon_Lite where UretimEmriNo2=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo3 collate Turkish_CI_AS, OptimizasyonAdet3 , GerceklesenAdet3,UretimMalzeme3 ,IseBaslangicSaati      from VW_Optimizasyon_Lite where UretimEmriNo3=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo4 collate Turkish_CI_AS, OptimizasyonAdet4 , GerceklesenAdet4,UretimMalzeme4,IseBaslangicSaati     from VW_Optimizasyon_Lite where UretimEmriNo4=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo5 collate Turkish_CI_AS, OptimizasyonAdet5 , GerceklesenAdet5,UretimMalzeme5,IseBaslangicSaati      from VW_Optimizasyon_Lite where UretimEmriNo5=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo6 collate Turkish_CI_AS, OptimizasyonAdet6 , GerceklesenAdet6,UretimMalzeme6,IseBaslangicSaati       from VW_Optimizasyon_Lite where UretimEmriNo6=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo7 collate Turkish_CI_AS, OptimizasyonAdet7 , GerceklesenAdet7,UretimMalzeme7,IseBaslangicSaati       from VW_Optimizasyon_Lite where UretimEmriNo7=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo8 collate Turkish_CI_AS, OptimizasyonAdet8 , GerceklesenAdet8,UretimMalzeme8 ,IseBaslangicSaati      from VW_Optimizasyon_Lite where UretimEmriNo8=@UretimEmriNo
union all
select  OptimizasyonKodu, UretimEmriNo9 collate Turkish_CI_AS, OptimizasyonAdet9 , GerceklesenAdet9,UretimMalzeme9 ,IseBaslangicSaati      from VW_Optimizasyon_Lite where UretimEmriNo9=@UretimEmriNo ) as tbl
where tbl.IsEmriNo is not null
group by tbl.IsEmriNo,FercamKodu   , IseBaslangicSaati 
end


