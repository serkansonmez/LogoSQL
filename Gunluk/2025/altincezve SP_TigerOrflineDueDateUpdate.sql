USE [AltinCezveB2B_Default_v1]
GO
/****** Object:  StoredProcedure [dbo].[SP_TigerOrflineDueDateUpdate]    Script Date: 20.02.2025 20:20:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--  exec [SP_TigerProducerCodeUpdate] '323',3,'test'
 
ALTER procedure [dbo].[SP_TigerOrflineDueDateUpdate]
(  @TigerFirmaKodu varchar(250) ,@TigerFirmaDonem varchar(250), @Id int, @Duedate datetime, @Genexp1 varchar(51))
as
 
 
  
 declare @strSQL nvarchar(max)  = ''
 set @strSQL +=  ' update CEZVE..LG_' + @TigerFirmaKodu + '_' + @TigerFirmaDonem + '_ORFLINE WITH(READPAST) SET DUEDATE=@Duedate , GENEXP1=@Genexp1 WHERE LOGICALREF=@Id'
 
 declare @FisId int = 0
 
 
 set @strSQL +=  ' select  @FisId = LOGICALEFREF CEZVE..LG_' + @TigerFirmaKodu + '_' + @TigerFirmaDonem + '_ORFLINE  WHERE LOGICALREF=@Id'
 
EXEC sp_executesql @strSQL, N'@Duedate datetime, @Genexp1 varchar(51), @Id int',   @Id
           
-- fatura master 
set @strSQL +=  ' update CEZVE..LG_' + @TigerFirmaKodu + '_' + @TigerFirmaDonem + '_ORFICHE WITH(READPAST) SET   GENEXP1=@Genexp1 WHERE LOGICALREF=@FisId'

EXEC sp_executesql @strSQL, N'  @Genexp1 varchar(51), @FisId int', @Genexp1, @FisId



		 --     select TOP 1000000 LG_ 323_CLCARD.LOGICALREF AS KaynakReferans,LG_ 323_CLCARD.CODE as KaynakCariKod,LG_ 323_CLCARD.DEFINITION_ as KaynakCariUnvani,   LG_ 423_CLCARD.CODE as HedefCariKodu,   CASE WHEN  LG_ 423_CLCARD.CODE IS NULL THEN    'Aktarılmamış'   else    'Ok'   end as AktarimDurumu   ,ISNULL(LG_ 323_EMUHACC.LOGICALREF,0) AS  MuhasebeReferans    from CEZVE..LG_ 323_CLCARD WITH(NOLOCK)  LEFT JOIN GO3DB..LG_ 423_CLCARD  WITH(NOLOCK) ON LG_ 423_CLCARD.CODE = LG_ 323_CLCARD.CODE  LEFT JOIN CEZVE..LG_ 323_EMUHACC  WITH(NOLOCK) ON LG_ 323_EMUHACC.CODE = LG_ 323_CLCARD.CODE  WHERE LG_ 323_CLCARD.ACTIVE = '0'  and LG_ 423_CLCARD.CODE IS NULL  ORDER BY  LG_ 323_CLCARD.CODE   GO 
