USE [AltinCezveB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_MalzemeKarsilastirmaListesi]    Script Date: 29.11.2024 11:45:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--drop view VW_BankaHesaplariKarsilastirmaListesi

create view [dbo].[VW_BankaHesaplariKarsilastirma] as 
  SELECT * FROM (
  select ITM.LOGICALREF as TigerRef,ITM.CODE as TigerStokKodu,ITM.DEFINITION_ as TigerHesapAdi, CYPHCODE TigerYetkiKodu  from    CEZVE..LG_324_BANKACC  ITM  
   ) tblTiger 
  left join (
  select ITM.LOGICALREF as GoRef,ITM.CODE as GoStokKodu,ITM.DEFINITION_ as GoHesapAdi   from    GO3DB..LG_424_BANKACC ITM  
   ) tblGo on   tblTiger.TigerYetkiKodu = tblGo.GoStokKodu
   and tblTiger.TigerYetkiKodu = ''
     


	  select ITM.LOGICALREF as TigerRef,ITM.CODE as TigerBankaKodu,ITM.DEFINITION_ as TigerHesapAdi, CYPHCODE Go3BankaKodu  from    CEZVE..LG_324_BANKACC  ITM  where ACTIVE = 0
	  AND CYPHCODE=''

	 UPDATE  CEZVE..LG_324_BANKACC SET CYPHCODE = 'B002  02' WHERE LOGICALREF = 57


	 SELECT * FROM GO3DB..LG_424_CLCARD WHERE DEFINITION_ LIKE 'SÝNAN%'
 
select * from   GO3DB..LG_424_BANKACC where  DEFINITION_ LIKE '%FÝNANS%YILDIRIM%'

select 
  TIGER_ITM.CODE,
  TIGER_ITM.DEFINITION_  ,
  GO3_ITM.CODE as GoCode,
  GO3_ITM.DEFINITION_ as GoName  ,

  'UPDATE CEZVE..LG_324_BANKACC SET CYPHCODE = ''' +  GO3_ITM.CODE + ''' WHERE LOGICALREF=' + CAST(TIGER_ITM.LOGICALREF AS VARCHAR(200))
  from CEZVE..LG_324_BANKACC TIGER_ITM
  LEFT JOIN  GO3DB..Lg_424_BANKACC GO3_ITM ON SUBSTRING(GO3_ITM.DEFINITION_,1,30) =  SUBSTRING(TIGER_ITM.DEFINITION_,1,30)
  WHERE TIGER_ITM.ACTIVE = 0 AND GO3_ITM.CODE IS NOT NULL 