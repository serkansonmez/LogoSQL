USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_hbCategory]    Script Date: 22.05.2022 18:06:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM HbCategory where ParentCategoryId = 60003639
--SELECT * FROM VW_HbCategory where ParentCategoryId = 60003640
--SELECT * FROM VW_HbCategory where CategoryId = 60001501
/*
CREATE VIEW  VW_HbCategory AS
select * , 1 as Seviye from hbCategory where ParentCategoryId = 0
UNION ALL
select * , 2 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0)
UNION ALL
select * , 3 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0))
UNION ALL
select * , 4 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0)))
UNION ALL
select * , 5 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId  from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0))))
UNION ALL
select * , 6 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId  from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0)))))
UNION ALL
select * , 7 as Seviye from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId  from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId from hbCategory where ParentCategoryId  in  (select CategoryId as Seviye from hbCategory where ParentCategoryId = 0))))))

 
 */
 
 
 --create view [dbo].[VW_HbKategori] as 
SELECT q2.CategoryId
      ,q2.ParentCategoryId
      ,q2.DisplayName
      ,q2.RowUpdatedBy
      ,q2.[RowUpdatedTime]
      ,q2.[Seviye]
   ,s2.DisplayName,s3.DisplayName,s4.DisplayName,s5.DisplayName,s6.DisplayName,s7.DisplayName
      
	  , case when q2.[Seviye] = 5 then
	     isnull(s2.DisplayName,'') + '->' + isnull(s3.DisplayName,l2.DisplayName) + '->' +  isnull(s4.DisplayName,l3.DisplayName) + '->' +  isnull(q2.DisplayName,'')
		  when q2.[Seviye] = 3 then 
		  isnull(l2.DisplayName,'') + '->' +  isnull( l3.DisplayName,'') + '->' +  isnull(q2.DisplayName,'') 
		   when q2.[Seviye] = 2 then 
		     isnull( x2.DisplayName,'') + '->' +  isnull(q2.DisplayName,'')
		 end as KategoriDetayi
		 --,isnull(VW_N11ZorunluAttributes.N11Attributes,'') as ZorunluAlanlar
		 -- ,isnull(VW_N11DigerAttributes.N11Attributes,'') as DigerAlanlar
  FROM [dbo].VW_HbCategory  q2
   left join VW_HbCategory s7 on q2.ParentCategoryId = s7.CategoryId and s7.Seviye =6
  left join VW_HbCategory s6 on q2.ParentCategoryId = s6.CategoryId and s6.Seviye =5
  left join VW_HbCategory s5 on q2.ParentCategoryId = s5.CategoryId and s5.Seviye =4
  left join VW_HbCategory s4 on q2.ParentCategoryId = s4.CategoryId and s4.Seviye =3
  left join VW_HbCategory s3 on s4.ParentCategoryId = s3.CategoryId and s3.Seviye =2
  left join VW_HbCategory s2 on s3.ParentCategoryId = s2.CategoryId and s2.Seviye =1

   
  left join VW_HbCategory l3 on q2.ParentCategoryId = l3.CategoryId and l3.Seviye =2
  left join VW_HbCategory l2 on l3.ParentCategoryId = l2.CategoryId and l2.Seviye =1

  
  left join VW_HbCategory x2 on q2.ParentCategoryId = x2.CategoryId and x2.Seviye =1
  --left join VW_N11ZorunluAttributes on VW_N11ZorunluAttributes.hbCategoryId = q2.hbCategoryId
  --left join VW_N11DigerAttributes on VW_N11DigerAttributes.hbCategoryId = q2.hbCategoryId
 where 
 q2.Seviye = 5
 --and q2.KategoriAdi like '%jene%'


 /*
select * from N11Attributes

create view VW_N11ZorunluAttributes as
SELECT DISTINCT ST2.hbCategoryId, 
    SUBSTRING(
        (
            SELECT ','+ST1.AttributesName  AS [text()]
            FROM dbo.N11Attributes ST1
            WHERE ST1.Mandatory=1 and ST1.hbCategoryId = ST2.hbCategoryId
            ORDER BY ST1.AttributesName
            FOR XML PATH ('')
        ), 2, 1000) N11Attributes 
FROM dbo.N11Attributes ST2 where   SUBSTRING(
        (
            SELECT ','+ST1.AttributesName  AS [text()]
            FROM dbo.N11Attributes ST1
            WHERE ST1.Mandatory=1 and ST1.hbCategoryId = ST2.hbCategoryId
            ORDER BY ST1.AttributesName
            FOR XML PATH ('')
        ), 2, 1000) is not null
		*/
GO


