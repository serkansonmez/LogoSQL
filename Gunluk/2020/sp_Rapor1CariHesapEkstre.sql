USE [TIGER3]
GO

/****** Object:  StoredProcedure [dbo].[sp_Rapor1CariHesapEkstre]    Script Date: 19.10.2020 21:52:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_Rapor1CariHesapEkstre]
@_KOD AS VARCHAR(200), 
@_BASTAR AS DATETIME, 
@_BITTAR AS DATETIME,
@_OZELKOD AS VARCHAR(200), 
@_YETKIKODU AS VARCHAR(200)
AS 
begin
--DECLARE


--declare @_KOD varchar(100) = '320%'
--declare @_OZELKOD varchar(100) = ''
--declare @_YETKIKODU varchar(100) = ''
--declare @_BASTAR datetime = '20200101'
--declare @_BITTAR datetime = '20201001'

select
      CLCARD.CODE   AS 'Cari Hesap Kodu',
      CLCARD.DEFINITION_  AS 'Cari Hesap �nvan�',
	  CLCARD.SPECODE   AS '�zel Kod',
	  CLCARD.cyphCODE   AS 'Yetki Kod',
      CLFLINE.DATE_   AS '��lem Tarihi',
      CASE CLFLINE.MODULENR  WHEN 4
        THEN
          (SELECT INV.FICHENO
          FROM LG_003_01_INVOICE INV
          WHERE INV.LOGICALREF = CLFLINE.SOURCEFREF)
        ELSE CLFLINE.TRANNO
      END AS '��lem No',
      CLFLINE.LINEEXP AS '��lem A��klamas�',
      ISNULL(CLFLINE.DOCODE,
      CASE CLFLINE.MODULENR
        WHEN 4
        THEN
          (SELECT INV.FICHENO
          FROM LG_003_01_INVOICE INV
          WHERE INV.LOGICALREF = CLFLINE.SOURCEFREF
          )
        ELSE CLFLINE.TRANNO
      END)         AS 'Belge No',
	  case CLFLINE.MODULENR when 4 then 'Fatura' when 5 then 'Cari Hesap' when 6 then '�ek/Senet' when 7 then 'Banka' when 10 then 'Kasa' else 'Di�er' end as '��lem T�r�',
           CASE SIGN
        WHEN 0
        THEN AMOUNT
        ELSE 0
      END AS 'Bor�',
      CASE SIGN
        WHEN 1
        THEN AMOUNT
        ELSE 0
      END AS 'Alacak',
  (CASE SIGN
        WHEN 0
        THEN AMOUNT
        ELSE 0
      END -
      CASE SIGN
        WHEN 1
        THEN AMOUNT
        ELSE 0
      END) AS 'Bakiye'
    FROM LG_003_CLCARD CLCARD,
          LG_003_01_CLFLINE CLFLINE
    WHERE 
     CLFLINE.CLIENTREF  = CLCARD.LOGICALREF
        AND CLFLINE.CANCELLED  = 0
AND (@_KOD='' OR CLCARD.CODE LIKE REPLACE(@_KOD,'*','%')) AND (@_OZELKOD='' OR CLCARD.SPECODE LIKE REPLACE(@_OZELKOD,'*','%')) AND (@_YETKIKODU='' OR CLCARD.CYPHCODE LIKE REPLACE(@_YETKIKODU,'*','%')) AND (CLFLINE.DATE_ BETWEEN @_BASTAR AND @_BITTAR)
   UNION ALL
      SELECT
	  CLCARD.CODE                            AS 'Cari Hesap Kodu',
      CLCARD.DEFINITION_                         AS 'Cari Hesap �nvan�',
	  CLCARD.SPECODE                            AS '�zel Kod',
	  CLCARD.cyphCODE                            AS 'Yetki Kodu',
      INVOICE.DATE_                              AS '��lem Tarihi',
      INVOICE.FICHENO                            AS '��lem No',
      ISNULL(INVOICE.DOCODE,INVOICE.FICHENO)+' nolu faturaya istinaden'       AS '��lem A��klamas�',
      ISNULL(INVOICE.DOCODE,INVOICE.FICHENO) AS 'Belge No',
	  'Fatura' as '��lem T�r�',
        CASE INVOICE.TRCODE
        WHEN 1
        THEN INVOICE.NETTOTAL
        WHEN 2
        THEN INVOICE.NETTOTAL
        WHEN 3
        THEN INVOICE.NETTOTAL
        WHEN 4
        THEN INVOICE.NETTOTAL
        WHEN 6
        THEN 0
        WHEN 7
        THEN 0
        WHEN 8
        THEN 0
        WHEN 9
        THEN 0
      END AS 'Bor�',
      CASE INVOICE.TRCODE
        WHEN 1
        THEN 0
        WHEN 2
        THEN 0
        WHEN 3
        THEN 0
        WHEN 4
        THEN 0
        WHEN 6
        THEN INVOICE.NETTOTAL
        WHEN 7
        THEN INVOICE.NETTOTAL
        WHEN 8
        THEN INVOICE.NETTOTAL
        WHEN 9
        THEN INVOICE.NETTOTAL
      END AS 'Alacak',
(CASE INVOICE.TRCODE
        WHEN 1
        THEN INVOICE.NETTOTAL
        WHEN 2
        THEN INVOICE.NETTOTAL
        WHEN 3
        THEN INVOICE.NETTOTAL
        WHEN 4
        THEN INVOICE.NETTOTAL
        WHEN 6
        THEN 0
        WHEN 7
        THEN 0
        WHEN 8
        THEN 0
        WHEN 9
        THEN 0
      END -
      CASE INVOICE.TRCODE
        WHEN 1
        THEN 0
        WHEN 2
        THEN 0
        WHEN 3
        THEN 0
        WHEN 4
        THEN 0
        WHEN 6
        THEN INVOICE.NETTOTAL
        WHEN 7
        THEN INVOICE.NETTOTAL
        WHEN 8
        THEN INVOICE.NETTOTAL
        WHEN 9
        THEN INVOICE.NETTOTAL
      END) AS 'Bakiye'
    FROM LG_003_01_INVOICE INVOICE,
      LG_003_CLCARD CLCARD
    
    WHERE CLCARD.LOGICALREF = INVOICE.CLIENTREF
     AND INVOICE.FROMKASA    = 1
    AND INVOICE.CLIENTREF   > 0
AND (@_KOD='' OR CLCARD.CODE LIKE REPLACE(@_KOD,'*','%')) AND (@_OZELKOD='' OR CLCARD.SPECODE LIKE REPLACE(@_OZELKOD,'*','%')) AND (@_YETKIKODU='' OR CLCARD.CYPHCODE LIKE REPLACE(@_YETKIKODU,'*','%')) AND (INVOICE.DATE_ BETWEEN @_BASTAR AND @_BITTAR)
end
GO


