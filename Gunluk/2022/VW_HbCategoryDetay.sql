USE [KrcB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_HbCategoryDetay]    Script Date: 28.05.2022 18:02:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER VIEW  [dbo].[VW_HbCategoryDetay] AS 
select * ,
VW_HbDigerAttributes.HbAttributes as DigerAttributes,
VW_HbZorunluAttributes.HbAttributes as ZorunluAttributes
from (
select DISTINCT
tbl2.CategoryId,tbl2.Name AS Name_,tbl2.DisplayName,tbl2.ParentCategoryId,tbl2.Leaf,tbl2.Seviye,tbl2.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' +  isnull(tbl2.DisplayName,'')   AS  KategoriDetayi
from VW_HbCategory tbl2
 
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl2.ChildCount=0 and tbl2.Seviye=2
UNION ALL
select DISTINCT
tbl3.CategoryId,tbl3.Name AS Name_,tbl3.DisplayName,tbl3.ParentCategoryId,tbl3.Leaf,tbl3.Seviye,tbl3.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' +  isnull(tbl2.DisplayName,'') + '->' +  isnull(tbl3.DisplayName,'') AS  KategoriDetayi
from VW_HbCategory tbl3
left join VW_HbCategory tbl2 on tbl3.ParentCategoryId = tbl2.CategoryId AND tbl2.Seviye=2
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl3.ChildCount=0 and tbl3.Seviye=3
UNION ALL
select DISTINCT
tbl4.CategoryId,tbl4.Name AS Name_,tbl4.DisplayName,tbl4.ParentCategoryId,tbl4.Leaf,tbl4.Seviye,tbl4.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' + isnull( tbl2.DisplayName,'') + '->' +  isnull(tbl3.DisplayName,'') + '->' +  isnull(tbl4.DisplayName,'') AS  KategoriDetayi
from VW_HbCategory tbl4
left join VW_HbCategory tbl3 on tbl4.ParentCategoryId = tbl3.CategoryId AND tbl3.Seviye=3
left join VW_HbCategory tbl2 on tbl3.ParentCategoryId = tbl2.CategoryId AND tbl2.Seviye=2
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl4.ChildCount=0 and tbl4.Seviye=4

UNION ALL
select DISTINCT
tbl5.CategoryId,tbl5.Name AS Name_,tbl5.DisplayName,tbl5.ParentCategoryId,tbl5.Leaf,tbl5.Seviye,tbl5.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' + isnull( tbl2.DisplayName,'') + '->' +  isnull(tbl3.DisplayName,'') + '->' + isnull(tbl4.DisplayName,'') + '->' +  isnull(tbl5.DisplayName,'') AS  KategoriDetayi
from VW_HbCategory tbl5
left join VW_HbCategory tbl4 on tbl5.ParentCategoryId = tbl4.CategoryId AND tbl4.Seviye=4
left join VW_HbCategory tbl3 on tbl4.ParentCategoryId = tbl3.CategoryId AND tbl3.Seviye=3
left join VW_HbCategory tbl2 on tbl3.ParentCategoryId = tbl2.CategoryId AND tbl2.Seviye=2
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl5.ChildCount=0 and tbl5.Seviye=5

UNION ALL
select DISTINCT
tbl6.CategoryId,tbl6.Name AS Name_,tbl6.DisplayName,tbl6.ParentCategoryId,tbl6.Leaf,tbl6.Seviye,tbl6.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' + isnull( tbl2.DisplayName,'') + '->' +  isnull(tbl3.DisplayName,'') + '->' + isnull(tbl4.DisplayName,'') + '->' +  isnull(tbl5.DisplayName,'') + '->' +  isnull(tbl6.DisplayName,'') AS  KategoriDetayi
from VW_HbCategory tbl6
left join VW_HbCategory tbl5 on tbl6.ParentCategoryId = tbl5.CategoryId AND tbl5.Seviye=5
left join VW_HbCategory tbl4 on tbl5.ParentCategoryId = tbl4.CategoryId AND tbl4.Seviye=4
left join VW_HbCategory tbl3 on tbl4.ParentCategoryId = tbl3.CategoryId AND tbl3.Seviye=3
left join VW_HbCategory tbl2 on tbl3.ParentCategoryId = tbl2.CategoryId AND tbl2.Seviye=2
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl6.ChildCount=0 and tbl6.Seviye=6
UNION ALL
select DISTINCT
tbl7.CategoryId,tbl7.Name AS Name_,tbl7.DisplayName,tbl7.ParentCategoryId,tbl7.Leaf,tbl7.Seviye,tbl7.ChildCount  
,isnull( tbl1.DisplayName,'') + '->' + isnull( tbl2.DisplayName,'') + '->' +  isnull(tbl3.DisplayName,'') + '->' + isnull(tbl4.DisplayName,'') + '->' +  isnull(tbl5.DisplayName,'') + '->' +  isnull(tbl6.DisplayName,'') + '->' +  isnull(tbl7.DisplayName,'') AS  KategoriDetayi
from VW_HbCategory tbl7
left join VW_HbCategory tbl6 on tbl7.ParentCategoryId = tbl6.CategoryId AND tbl6.Seviye=6
left join VW_HbCategory tbl5 on tbl6.ParentCategoryId = tbl5.CategoryId AND tbl5.Seviye=5
left join VW_HbCategory tbl4 on tbl5.ParentCategoryId = tbl4.CategoryId AND tbl4.Seviye=4
left join VW_HbCategory tbl3 on tbl4.ParentCategoryId = tbl3.CategoryId AND tbl3.Seviye=3
left join VW_HbCategory tbl2 on tbl3.ParentCategoryId = tbl2.CategoryId AND tbl2.Seviye=2
left join VW_HbCategory tbl1 on tbl2.ParentCategoryId = tbl1.CategoryId AND tbl1.Seviye=1
where tbl7.ChildCount=0 and tbl7.Seviye=7) tblMain
left join VW_HbDigerAttributes on VW_HbDigerAttributes.CategoryId = tblMain.CategoryId
left join VW_HbZorunluAttributes on VW_HbZorunluAttributes.CategoryId = tblMain.CategoryId


--select * from VW_HbCategory where Seviye =3 and ChildCount=0
--select * from VW_HbCategory where categoryId = 3013118
--select * from VW_HbCategory where categoryId = 2147483646
GO

--SELECT * FROM VW_HbDigerAttributes

--SELECT * FROM VW_HBzORUNLUAttributes


