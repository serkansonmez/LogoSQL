USE [TIGER3]
GO

/****** Object:  StoredProcedure [dbo].[sp_SatisAnalizRaporu]    Script Date: 19.10.2020 21:52:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_SatisAnalizRaporu]
@_CARIKOD AS VARCHAR(200), 
@_BASTAR AS DATETIME, 
@_BITTAR AS DATETIME,
@_MLZKOD AS VARCHAR(200) 
AS 
begin
--DECLARE

--declare @_CARIKOD varchar(200) = '*'
--declare @_MLZKOD varchar(200)  = '*'
--declare @_BASTAR datetime = '20200101'
--declare @_BITTAR datetime  = '20201001'
SELECT    
CASE when STLINE.LINETYPE = 1 THEN 'Promosyon' when STLINE.LINETYPE = 0 then 'Malzeme' else 'Di�er' end [Sat�r Tipi], 
CASE WHEN ITEMS.ACTIVE = 0 THEN 'Kullan�mda' ELSE 'Kullan�m D���' END AS [Cari Status�], 
                      CLCARD.CODE AS [Cari Kodu], CLCARD.DEFINITION_ AS [Cari �nvan�], 
                      CLCARD.SPECODE AS [Cari �zel Kodu], CLCARD.SPECODE5 AS [Cari �zel Kodu 5], 
CLCARD.SPECODE2 AS [Cari �zel Kodu 2],
CLCARD.SPECODE3 AS [Cari �zel Kodu 3],
CLCARD.SPECODE4 AS [Cari �zel Kodu 4],
                      CLCARD.CYPHCODE AS [Cari Yetki Kodu], CLCARD.TAXOFFICE AS [Vergi Dairesi], 
                      CLCARD.TAXNR AS [Vergi No], ITEMS.CODE AS [Malzeme Kodu], ITEMS.NAME AS [Malzeme A��klamas�], 
                      ITEMS.SPECODE AS [Malzeme �zel Kodu], ITEMS.SPECODE2 AS [Malzeme �zel Kod 2], 
                      ITEMS.SPECODE3 AS [Malzeme �zel Kod 3], ITEMS.SPECODE4 AS [Malzeme �zel Kod 4], 
                      ITEMS.SPECODE5 AS [Malzeme �zel Kod 5], ITEMS.Stgrpcode AS [Malzeme GrupKodu], 
                      INVOICE.DATE_  AS [FATURATARIH],
                      ITEMS.cyphcode AS [Malzeme Yetki Kodu], CASE STLINE.TRCODE WHEN 2 THEN 'Perakande Sat�� �ade �rsaliyesi' WHEN 3 THEN 'Toptan Sat�� �ade �rsaliyesi' WHEN 7 THEN 'Perakande Sat��  �rsaliyesi' WHEN 8 THEN 'Toptan Sat�� �rsaliyesi'
					  else 'Di�er' END  AS [Fi� T�r�], STLINE.DATE_ AS [Fi� Tarihi], 
                      STFICHE.FICHENO AS [Fi� No], 
                      CASE WHEN INVOICE.ACCOUNTED = 1 THEN 'Muhasebele�mi�' ELSE 'Muhasebele�tirilmemi�' END AS [Muhasebe Durumu], 
                      CASE WHEN STFICHE.BILLED = 1 THEN 'Faturalanm��' ELSE 'Faturalanmam��' END AS [Fatura Durumu], 
                      STFICHE.INVNO AS [Fatura No],CASE  MONTH(STLINE.DATE_) WHEN 1 THEN '01.OCAK' WHEN 2 THEN '02.�UBAT' WHEN 3 THEN '03.MART' WHEN 4 THEN '04.N�SAN' WHEN 5 THEN '05.MAYIS' WHEN 6 THEN '06.HAZ�RAN'
					  WHEN 7 THEN '07.TEMMUZ' WHEN 8 THEN '08.A�USTOS' WHEN 9 THEN '09.EYL�L' WHEN 10 THEN '10.EK�M' WHEN 11 THEN '11.KASIM' ELSE '12.ARALIK' END AS  [Fi� Ay�],
CASE  MONTH(INVOICE.DATE_) WHEN 1 THEN '01.OCAK' WHEN 2 THEN '02.�UBAT' WHEN 3 THEN '03.MART' WHEN 4 THEN '04.N�SAN' WHEN 5 THEN '05.MAYIS' WHEN 6 THEN '06.HAZ�RAN'
					  WHEN 7 THEN '07.TEMMUZ' WHEN 8 THEN '08.A�USTOS' WHEN 9 THEN '09.EYL�L' WHEN 10 THEN '10.EK�M' WHEN 11 THEN '11.KASIM' ELSE '12.ARALIK' END AS  [Fatura Ay�],

					  CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)*-1 ELSE (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1) END   AS Miktar, 
                      STLINE.VAT AS [Kdv], 
CASE WHEN STLINE.LINETYPE = 1 THEN 0 ELSE
CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.VATMATRAH + STLINE.DIFFPRICE)*-1 ELSE STLINE.VATMATRAH + STLINE.DIFFPRICE END END
  AS [Kdv Hari�],
CASE WHEN STLINE.LINETYPE = 1 THEN 0 ELSE

CASE WHEN STLINE.TRCODE IN(2,3) THEN STLINE.VATAMNT*-1 ELSE STLINE.VATAMNT END END  AS [Kdv Tutar�], 
CASE WHEN STLINE.LINETYPE = 1 THEN 0 ELSE 
CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.VATMATRAH + STLINE.DIFFPRICE)*-1 ELSE STLINE.VATMATRAH + STLINE.DIFFPRICE END END  +

CASE WHEN STLINE.LINETYPE = 1 THEN 0 ELSE
CASE WHEN STLINE.TRCODE IN(2,3) THEN STLINE.VATAMNT*-1 ELSE STLINE.VATAMNT END END  AS [Genel Toplam],


CASE WHEN STLINE.LINETYPE = 1 THEN 0 ELSE

 (CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.VATMATRAH + STLINE.DIFFPRICE)*-1 ELSE STLINE.VATMATRAH + STLINE.DIFFPRICE END  + CASE WHEN STLINE.TRCODE IN(2,3) THEN STLINE.VATAMNT*-1 ELSE STLINE.VATAMNT END ) /				  CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)*-1 ELSE (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1) END END  [Birim Fiyat],

                      ISNULL((SELECT CODE FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Sat�c� Kodu],ISNULL((SELECT DEFINITION_  FROM LG_SLSMAN WHERE LOGICALREF=STLINE.SALESMANREF),'') AS [Sat�c� Ad�]
						,CASE WHEN STLINE.TRCODE IN(2,3) THEN (STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) * -1 ELSE (STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) END AS Maliyet,
						STLINE.DIFFPRICE*-1 AS [Sat�� Fiyat Fark�],
						CASE WHEN STLINE.TRCODE IN(2,3) 
							THEN ((STLINE.VATMATRAH - STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) + STLINE.DIFFPRICE) * -1
                      ELSE ((STLINE.VATMATRAH - STLINE.OUTCOST * (STLINE.AMOUNT*STLINE.UINFO2/STLINE.UINFO1)) + STLINE.DIFFPRICE) END AS Kar, 
                      YEAR(STLINE.DATE_) AS [Fi� Y�l�],CLCARD.CITY AS [�ehir],UNITSETL.CODE AS [Birim],CAPI.NAME [Ambar],
					  PAYP.DEFINITION_  [�deme Vadesi]

FROM LG_003_01_STLINE STLINE WITH(NOLOCK)  
LEFT JOIN LG_003_ITEMS ITEMS WITH(NOLOCK) ON STLINE.STOCKREF = ITEMS.LOGICALREF
LEFT JOIN LG_003_CLCARD CLCARD WITH(NOLOCK) ON STLINE.CLIENTREF = CLCARD.LOGICALREF 
LEFT JOIN LG_003_01_STFICHE STFICHE WITH(NOLOCK) ON STLINE.STFICHEREF = STFICHE.LOGICALREF 
LEFT JOIN  LG_003_01_INVOICE INVOICE WITH(NOLOCK) ON STFICHE.INVOICEREF = INVOICE.LOGICALREF 
left JOIN LG_003_UNITSETL UNITSETL ON UNITSETL.LOGICALREF=STLINE.UOMREF
LEFT JOIN L_CAPIWHOUSE CAPI WITH(NOLOCK)  ON INVOICE.SOURCEINDEX=CAPI.NR AND FIRMNR=003
LEFT JOIN LG_003_PAYPLANS PAYP ON INVOICE.PAYDEFREF = PAYP.LOGICALREF 

            WHERE     (STLINE.LINETYPE IN(0,1)) AND (STLINE.CANCELLED = 0) and STLINE.TRCODE IN (2,3,7,8)
AND (@_CARIKOD='' OR CLCARD.CODE LIKE REPLACE(@_CARIKOD,'*','%')) AND (@_MLZKOD='' OR ITEMS.CODE LIKE REPLACE(@_MLZKOD,'*','%')) 
AND (INVOICE.DATE_ BETWEEN @_BASTAR AND @_BITTAR)
end
GO


