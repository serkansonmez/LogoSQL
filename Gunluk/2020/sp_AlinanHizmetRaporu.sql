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
SELECT     CASE WHEN SRVCARD.ACTIVE = 0 THEN 'Kullanýmda' ELSE 'Kullaným Dýþý' END AS [Cari Statusü], 
                        CLCARD.CODE AS [Cari Kodu], CLCARD.DEFINITION_ AS [Cari Ünvaný], [Hareket Özel Kodu]=STLINE.SPECODE,
                        CLCARD.SPECODE AS [Cari Özel Kodu], CLCARD.SPECODE5 AS [Cari Özel Kodu 5], 
                        CLCARD.CYPHCODE AS [Cari Yetki Kodu], CLCARD.TAXOFFICE AS [Vergi Dairesi], CLCARD.TAXNR AS [Vergi No], 
                        SRVCARD.CODE AS [Hizmet Kodu], SRVCARD.DEFINITION_ AS [Hizmet Açýklamasý], SRVCARD.SPECODE AS [Hizmet Özel Kodu], 
                        '' AS [Hizmet Özel Kod 2], '' AS [Hizmet Özel Kod 3], '' AS [Hizmet Özel Kod 4], '' AS [Hizmet Özel Kod 5], '' AS [Hizmet GrupKodu], 
                        SRVCARD.CYPHCODE AS [Hizmet Yetki Kodu], CASE STLINE.TRCODE WHEN 2 THEN 'Perakande Satýþ Ýade Ýrsaliyesi' WHEN 3 THEN 'Toptan Satýþ Ýade Ýrsaliyesi' WHEN 7 THEN 'Perakande Satýþ  Ýrsaliyesi' WHEN 8 THEN 'Toptan Satýþ Ýrsaliyesi'  WHEN 9 THEN 'Verilen Hizmet Faturasý'  else 'Diðer' end  AS [Fiþ Türü], STLINE.DATE_ AS [Fiþ Tarihi], '' AS [Fiþ No], 
                        CASE WHEN INVOICE.ACCOUNTED = 1 THEN 'Muhasebeleþmiþ' ELSE 'Muhasebeleþtirilmemiþ' END AS [Muhasebe Durumu], 
                        '' AS [Fatura Durumu], INVOICE.FICHENO AS [Fatura No], CASE  MONTH(STLINE.DATE_) WHEN 1 THEN '01.OCAK' WHEN 2 THEN '02.ÞUBAT' WHEN 3 THEN '03.MART' WHEN 4 THEN '04.NÝSAN' WHEN 5 THEN '05.MAYIS' WHEN 6 THEN '06.HAZÝRAN'
					  WHEN 7 THEN '07.TEMMUZ' WHEN 8 THEN '08.AÐUSTOS' WHEN 9 THEN '09.EYLÜL' WHEN 10 THEN '10.EKÝM' WHEN 11 THEN '11.KASIM' ELSE '12.ARALIK' END AS [Fiþ Ayý], 
                      CASE WHEN STLINE.TRCODE=6 THEN   (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)*-1 ELSE (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1) END  AS Miktar, STLINE.VAT AS Kdv, CASE WHEN STLINE.TRCODE=6 THEN STLINE.VATMATRAH*-1 ELSE STLINE.VATMATRAH END  AS [Kdv Hariç], 
                       CASE WHEN STLINE.TRCODE=6 THEN  STLINE.VATAMNT*-1 ELSE STLINE.VATAMNT END  AS [Kdv Tutarý],CASE WHEN STLINE.TRCODE=6 THEN (STLINE.VATAMNT+STLINE.VATMATRAH)*-1 ELSE STLINE.VATAMNT+STLINE.VATMATRAH END  as [Genel Toplam], 'Hizmet' AS [Satýr Tipi],ISNULL((SELECT CODE FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Satýcý Kodu],ISNULL((SELECT DEFINITION_  FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Satýcý Adý]
 ,(STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) AS Maliyet,STLINE.DIFFPRICE*-1 as [Satýþ Fiyat Farký],
 (STLINE.VATMATRAH - STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1))+STLINE.DIFFPRICE AS Kar ,YEAR(STLINE.DATE_) AS [Fiþ Yýlý],
			CLCARD.CITY AS [Þehir],(select DEFINITION_
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


