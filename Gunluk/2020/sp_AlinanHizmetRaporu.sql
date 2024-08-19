USE [TIGER3]
GO

/****** Object:  StoredProcedure [dbo].[sp_AlinanHizmetRaporu]    Script Date: 19.10.2020 21:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_AlinanHizmetRaporu]
@_CARIKODU varchar(200) = '*',
@_HZMKODU varchar(200)  = '*',
@_HZMOZELKOD varchar(200)  = '*',
@_HZMYETKIKODU varchar(200)  = '*',
@_BASTAR datetime = '20200101',
@_BITTAR datetime  = '20201001'
AS 
begin

--declare @_CARIKODU varchar(200) = '*'
--declare @_HZMKODU varchar(200)  = '*'
--declare @_HZMOZELKOD varchar(200)  = '*'
--declare @_HZMYETKIKODU varchar(200)  = '*'
--declare @_BASTAR datetime = '20200101'
--declare @_BITTAR datetime  = '20201001'
SELECT     CASE WHEN SRVCARD.ACTIVE = 0 THEN 'Kullan�mda' ELSE 'Kullan�m D���' END AS [Cari Status�], 
                        CLCARD.CODE AS [Cari Kodu], CLCARD.DEFINITION_ AS [Cari �nvan�], [Hareket �zel Kodu]=STLINE.SPECODE,
                        CLCARD.SPECODE AS [Cari �zel Kodu], CLCARD.SPECODE5 AS [Cari �zel Kodu 5], 
                        CLCARD.CYPHCODE AS [Cari Yetki Kodu], CLCARD.TAXOFFICE AS [Vergi Dairesi], CLCARD.TAXNR AS [Vergi No], 
                        SRVCARD.CODE AS [Hizmet Kodu], SRVCARD.DEFINITION_ AS [Hizmet A��klamas�], SRVCARD.SPECODE AS [Hizmet �zel Kodu], 
                        '' AS [Hizmet �zel Kod 2], '' AS [Hizmet �zel Kod 3], '' AS [Hizmet �zel Kod 4], '' AS [Hizmet �zel Kod 5], '' AS [Hizmet GrupKodu], 
                        SRVCARD.CYPHCODE AS [Hizmet Yetki Kodu], CASE STLINE.TRCODE WHEN 2 THEN 'Perakande Sat�� �ade �rsaliyesi' WHEN 3 THEN 'Toptan Sat�� �ade �rsaliyesi' WHEN 7 THEN 'Perakande Sat��  �rsaliyesi' WHEN 8 THEN 'Toptan Sat�� �rsaliyesi'  WHEN 9 THEN 'Verilen Hizmet Faturas�'  else 'Di�er' end  AS [Fi� T�r�], STLINE.DATE_ AS [Fi� Tarihi], '' AS [Fi� No], 
                        CASE WHEN INVOICE.ACCOUNTED = 1 THEN 'Muhasebele�mi�' ELSE 'Muhasebele�tirilmemi�' END AS [Muhasebe Durumu], 
                        '' AS [Fatura Durumu], INVOICE.FICHENO AS [Fatura No], CASE  MONTH(STLINE.DATE_) WHEN 1 THEN '01.OCAK' WHEN 2 THEN '02.�UBAT' WHEN 3 THEN '03.MART' WHEN 4 THEN '04.N�SAN' WHEN 5 THEN '05.MAYIS' WHEN 6 THEN '06.HAZ�RAN'
					  WHEN 7 THEN '07.TEMMUZ' WHEN 8 THEN '08.A�USTOS' WHEN 9 THEN '09.EYL�L' WHEN 10 THEN '10.EK�M' WHEN 11 THEN '11.KASIM' ELSE '12.ARALIK' END AS [Fi� Ay�], 
                      CASE WHEN STLINE.TRCODE=6 THEN   (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)*-1 ELSE (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1) END  AS Miktar, STLINE.VAT AS Kdv, CASE WHEN STLINE.TRCODE=6 THEN STLINE.VATMATRAH*-1 ELSE STLINE.VATMATRAH END  AS [Kdv Hari�], 
                       CASE WHEN STLINE.TRCODE=6 THEN  STLINE.VATAMNT*-1 ELSE STLINE.VATAMNT END  AS [Kdv Tutar�],CASE WHEN STLINE.TRCODE=6 THEN (STLINE.VATAMNT+STLINE.VATMATRAH)*-1 ELSE STLINE.VATAMNT+STLINE.VATMATRAH END  as [Genel Toplam], 'Hizmet' AS [Sat�r Tipi],ISNULL((SELECT CODE FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Sat�c� Kodu],ISNULL((SELECT DEFINITION_  FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Sat�c� Ad�]
 ,(STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) AS Maliyet,STLINE.DIFFPRICE*-1 as [Sat�� Fiyat Fark�],
 (STLINE.VATMATRAH - STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1))+STLINE.DIFFPRICE AS Kar ,YEAR(STLINE.DATE_) AS [Fi� Y�l�],
			CLCARD.CITY AS [�ehir],(select DEFINITION_
 FROM LG_003_EMCENTER WHERE LOGICALREF=STLINE.CENTERREF) AS [Masraf Merkezi]
 FROM         LG_003_01_STLINE STLINE WITH(NOLOCK)  LEFT OUTER JOIN
            LG_003_CLCARD CLCARD WITH(NOLOCK) ON STLINE.CLIENTREF = CLCARD.LOGICALREF INNER JOIN
             LG_003_SRVCARD SRVCARD WITH(NOLOCK) ON STLINE.STOCKREF = SRVCARD.LOGICALREF INNER JOIN
            LG_003_01_INVOICE INVOICE WITH(NOLOCK) ON STLINE.INVOICEREF = INVOICE.LOGICALREF
 WHERE     (STLINE.LINETYPE = 4) AND (STLINE.CANCELLED = 0) And STLINE.TRCODE IN (1,6,4)
AND (@_CARIKODU='' OR CLCARD.CODE LIKE REPLACE(@_CARIKODU,'*','%')) AND (@_HZMKODU='' OR SRVCARD.CODE LIKE REPLACE(@_HZMKODU,'*','%')) 
AND (STLINE.DATE_ BETWEEN @_BASTAR AND @_BITTAR) AND (@_HZMOZELKOD='' OR SRVCARD.SPECODE LIKE REPLACE(@_HZMOZELKOD,'*','%'))
 AND (@_HZMYETKIKODU='' OR SRVCARD.CYPHCODE LIKE REPLACE(@_HZMYETKIKODU,'*','%'))
 end
GO


