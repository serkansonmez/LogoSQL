USE [TIGER]
GO
/****** Object:  StoredProcedure [dbo].[SP_VaryantAciklamaGoster]    Script Date: 11.02.2025 12:03:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 select * from LG_022_PRODORD WHERE FICHENO = '2203.070'
 select * from LG_020_01_ORFICHE WHERE FICHENO = '201207005'
 select VARIANTREF,* from LG_020_01_ORFLINE WHERE ORDFICHEREF = 1482 AND STOCKREF = 1317  --1317'Yİ NEREDEN BULDUK?
 SELECT * FROM LG_020_VARIANT WHERE LOGICALREF = 2196
 SELECT PRODUCERCODE,* FROM LG_020_ITEMS WHERE CODE = '07 047'
 */

 --select * from LG_024_PRODORD WHERE FICHENO LIKE '2312.0179'

 -- EXEC [SP_UretimEmriVaryantGetir] '','025','01','2501.0071'
  
CREATE PROCEDURE [dbo].[SP_UretimEmriVaryantGetir]
( @DB varchar(255),@FRM varchar(3), @PRD varchar(2), @UretimEmriNo varchar(20))
as 
  
declare @strSQL nvarchar(max)  = ''
 declare @strSQL1 nvarchar(max)  = ''
 declare @strSQL2 nvarchar(max)  = ''
  declare @strSQL3 nvarchar(max)  = ''
if (LEN(@FRM) = 2 )
set @FRM = '0' + @FRM

    
	if (LEN(@PRD) = 1 )
     set @PRD = '0' + @PRD
	 
	   set @strSQL += 'select PROD.LOGICALREF,PROD.MASTERREF AS ITEMREF,PROD.FICHENO AS PRODFICHENO,PROD.DATE_, ITM.CODE AS ITEMCODE,ITM.NAME AS ITEMNAME,VRY.LOGICALREF AS VRYLOGICALREF, 
VRY.CODE AS VARIANTCODE,VRY.NAME AS VARIANTNAME,VRY.NAME2 VARIANTNAME2  from LG_' + @FRM + '_PRODORD PROD WITH(NOLOCK)
left join LG_' + @FRM + '_PEGGING PEG  WITH(NOLOCK) on PEG.PEGREF = PROD.LOGICALREF
left join LG_' + @FRM + '_ITEMS ITM  WITH(NOLOCK) on ITM.LOGICALREF = PROD.MASTERREF
left join LG_' + @FRM + '_VARIANT VRY  WITH(NOLOCK) on VRY.LOGICALREF = PEG.VARIANTREF
where PROD.FICHENO = @UretimEmriNo'
 
 
declare  @Tbl table
(	       
           Logicalref int,
		   Itemref int,
		   ProdFicheNo varchar(50),
		   ProdDate datetime,
		   ItemCode varchar(50),
		   ItemName varchar(150),
		   VariantLogicalref int,
		   VariantCode varchar(50),
		   VariantName varchar(150),
		   VariantName2 varchar(150)
)
insert into @tbl
exec sp_executesql @strSQL
            ,N'@UretimEmriNo  varchar(20)'
            ,@UretimEmriNo

			select  * from @tbl
 

 

         
 

  
 
