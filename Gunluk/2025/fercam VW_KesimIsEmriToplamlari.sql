USE [FercamB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_KesimIsEmriToplamlari]    Script Date: 27.02.2025 10:31:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

VW_UretimPlanlama


 

 ALTER view [dbo].[VW_KesimIsEmriToplamlari] as 
 SELECT IsEmriNo, 
       MAX(OptimizasyonAdet) AS OptimizasyonAdet, 
       MAX(GerceklesenAdet) AS GerceklesenAdet, 
       MAX(FercamKodu) AS FercamKodu, 
       IseBaslangicSaati  
FROM (
    SELECT OptimizasyonKodu, 
           FercamKodu, 
           IseBaslangicSaati, 
           IsEmriNo, 
           OptimizasyonAdet, 
           GerceklesenAdet
    FROM (
        SELECT OptimizasyonKodu,
               IseBaslangicSaati,
               UretimMalzeme1, UretimMalzeme2, UretimMalzeme3, UretimMalzeme4, UretimMalzeme5, 
               UretimMalzeme6, UretimMalzeme7, UretimMalzeme8, UretimMalzeme9,
               UretimEmriNo1, OptimizasyonAdet1, GerceklesenAdet1,
               UretimEmriNo2, OptimizasyonAdet2, GerceklesenAdet2,
               UretimEmriNo3, OptimizasyonAdet3, GerceklesenAdet3,
               UretimEmriNo4, OptimizasyonAdet4, GerceklesenAdet4,
               UretimEmriNo5, OptimizasyonAdet5, GerceklesenAdet5,
               UretimEmriNo6, OptimizasyonAdet6, GerceklesenAdet6,
               UretimEmriNo7, OptimizasyonAdet7, GerceklesenAdet7,
               UretimEmriNo8, OptimizasyonAdet8, GerceklesenAdet8,
               UretimEmriNo9, OptimizasyonAdet9, GerceklesenAdet9
        FROM VW_Optimizasyon_Lite
    ) AS SourceTable
    UNPIVOT (
        IsEmriNo FOR UretimEmriNoColumn IN (UretimEmriNo1, UretimEmriNo2, UretimEmriNo3, UretimEmriNo4, UretimEmriNo5, 
                                            UretimEmriNo6, UretimEmriNo7, UretimEmriNo8, UretimEmriNo9)
    ) AS UnpivotedEmir
    UNPIVOT (
        OptimizasyonAdet FOR OptimizasyonAdetColumn IN (OptimizasyonAdet1, OptimizasyonAdet2, OptimizasyonAdet3, OptimizasyonAdet4, OptimizasyonAdet5, 
                                                         OptimizasyonAdet6, OptimizasyonAdet7, OptimizasyonAdet8, OptimizasyonAdet9)
    ) AS UnpivotedOptimizasyon
    UNPIVOT (
        GerceklesenAdet FOR GerceklesenAdetColumn IN (GerceklesenAdet1, GerceklesenAdet2, GerceklesenAdet3, GerceklesenAdet4, GerceklesenAdet5, 
                                                       GerceklesenAdet6, GerceklesenAdet7, GerceklesenAdet8, GerceklesenAdet9)
    ) AS UnpivotedGerceklesen
    UNPIVOT (
        FercamKodu FOR UretimMalzemeColumn IN (UretimMalzeme1, UretimMalzeme2, UretimMalzeme3, UretimMalzeme4, UretimMalzeme5, 
                                               UretimMalzeme6, UretimMalzeme7, UretimMalzeme8, UretimMalzeme9)
    ) AS UnpivotedMalzeme
    WHERE RIGHT(UretimEmriNoColumn, 1) = RIGHT(UretimMalzemeColumn, 1) -- Doðru eþleþtirme için
) AS FinalTable
WHERE FinalTable.IsEmriNo IS NOT NULL
GROUP BY FinalTable.IsEmriNo, FinalTable.IseBaslangicSaati;


--select * from VW_Optimizasyon_Lite
--select tbl.IsEmriNo, sum(OptimizasyonAdet) as OptimizasyonAdet,sum(GerceklesenAdet) as GerceklesenAdet ,FercamKodu  , IseBaslangicSaati   from 
--(select  OptimizasyonKodu, UretimEmriNo1 collate Turkish_CI_AS as IsEmriNo, OptimizasyonAdet1 as OptimizasyonAdet  , GerceklesenAdet1 as  GerceklesenAdet,UretimMalzeme1 as FercamKodu,IseBaslangicSaati  from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo2 collate Turkish_CI_AS, OptimizasyonAdet2,  GerceklesenAdet2, UretimMalzeme2,IseBaslangicSaati    from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo3 collate Turkish_CI_AS, OptimizasyonAdet3 , GerceklesenAdet3,UretimMalzeme3 ,IseBaslangicSaati      from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo4 collate Turkish_CI_AS, OptimizasyonAdet4 , GerceklesenAdet4,UretimMalzeme4,IseBaslangicSaati     from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo5 collate Turkish_CI_AS, OptimizasyonAdet5 , GerceklesenAdet5,UretimMalzeme5,IseBaslangicSaati      from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo6 collate Turkish_CI_AS, OptimizasyonAdet6 , GerceklesenAdet6,UretimMalzeme6,IseBaslangicSaati       from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo7 collate Turkish_CI_AS, OptimizasyonAdet7 , GerceklesenAdet7,UretimMalzeme7,IseBaslangicSaati       from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo8 collate Turkish_CI_AS, OptimizasyonAdet8 , GerceklesenAdet8,UretimMalzeme8 ,IseBaslangicSaati      from VW_Optimizasyon_Lite
--union all
--select  OptimizasyonKodu, UretimEmriNo9 collate Turkish_CI_AS, OptimizasyonAdet9 , GerceklesenAdet9,UretimMalzeme9 ,IseBaslangicSaati      from VW_Optimizasyon_Lite) as tbl
--where tbl.IsEmriNo is not null
--group by tbl.IsEmriNo,FercamKodu   , IseBaslangicSaati 
GO


