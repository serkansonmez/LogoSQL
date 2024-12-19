USE [TIGER]
GO
/****** Object:  StoredProcedure [dbo].[SP_IsEmriBarkodListe]    Script Date: 07.11.2024 11:38:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

 -- EXEC [SP_IsEmriBarkodListe] '','022','01',2481
  
ALTER PROCEDURE [dbo].[SP_IsEmriBarkodListe]
( @DB varchar(255),@FRM varchar(3), @PRD varchar(2), @UretimEmriReferans int)
as 

declare @strSQL nvarchar(max)  = ''
declare @strSQL1 nvarchar(max)  = ''
declare @strSQL2 nvarchar(max)  = ''
declare @strSQL3 nvarchar(max)  = ''
if (LEN(@FRM) = 2 )
set @FRM = '0' + @FRM

    
	if (LEN(@PRD) = 1 )
     set @PRD = '0' + @PRD
	   

		set @strSQL = 'SELECT
								
								DISP.PRODORDREF  UretimRef,
								DISP.LINENO_     Barkod,
								ITM.CODE        AnaUrunKodu
								FROM LG_' + @FRM + '_DISPLINE DISP LEFT OUTER JOIN
								LG_' + @FRM + '_POLINE POL  ON DISP.LOGICALREF=POL.DISPLINEREF  AND POL.LINETYPE=4 LEFT OUTER JOIN
								LG_' + @FRM + '_ITEMS ITM ON POL.ITEMREF=ITM.LOGICALREF LEFT  OUTER JOIN
								LG_' + @FRM + '_UNITSETF UNUT ON ITM.UNITSETREF=UNUT.LOGICALREF   LEFT  OUTER JOIN
								LG_' + @FRM + '_VARIANT VARIANT ON POL.VARIANTREF=VARIANT.LOGICALREF LEFT  OUTER JOIN
								LG_' + @FRM + '_PRODORD PRD ON DISP.PRODORDREF=PRD.LOGICALREF LEFT  OUTER JOIN
								LG_' + @FRM + '_WORKSTAT WORK ON DISP.WSREF=WORK.LOGICALREF
								left  OUTER JOIN     [FercamB2B_Default_v1]..VW_Kalite8DTanimi ON FERCAMkodu +  '' '' + CASE WHEN VW_Kalite8DTanimi.OperasyonAdi = ''BANDO'' THEN ''RODAJ'' 
																							WHEN VW_Kalite8DTanimi.OperasyonAdi LIKE ''FIRIN%'' THEN ''FIRIN''
																							ELSE VW_Kalite8DTanimi.OperasyonAdi  END  COLLATE Turkish_CI_AS= ITM.CODE
								WHERE DISP.PRODORDREF=@UretimEmriReferans '

	 
 
 --SELECT PRODUCERCODE,* FROM LG_020_ITEMS WHERE CODE = '10 008'

 
 SET @strSQL3 = CONCAT(@strSQL, @strSQL1 , @strSQL2 )

 
  --SELECT @strSQL3
declare  @Tbl table
( 
	       UretimRef int,
           Barkod varchar(25),
          
           AnaUrunKodu  varchar(25) 

)
insert into @tbl
exec sp_executesql @strSQL3
            ,N'@UretimEmriReferans int'
            ,@UretimEmriReferans

			select  * from @tbl
			--UNION ALL 
			--select TOP 1 * from VW_ISEMRI_FORMU

 

         
 

  
 
