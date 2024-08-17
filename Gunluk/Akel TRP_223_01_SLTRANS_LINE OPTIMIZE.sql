USE [TIGER3ENT]
GO

/****** Object:  View [dbo].[TRP_120_01_SLTRANS_LINE]    Script Date: 24.01.2024 17:09:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--ALTER VIEW [dbo].[TRP_120_01_SLTRANS_LINE] AS

WITH GIRIS_CARI_BILGISI AS 
(SELECT  
	STFICHE.FICHENO,
	SLTRANS.SLREF,
	STLINE.STOCKREF,
	(STLINE.VATMATRAH/ STLINE.AMOUNT) GIRIS_FIYATI,
	CASE WHEN RECVREF = 241 THEN 'Pazarlama' ELSE 'Tekstil' END TEKSTIL_PAZARLAMA,
	CASE WHEN STFICHE.RECVREF <> 0 THEN SEVK_HESABI.CODE ELSE  CLCARD.CODE END CODE,
	CASE WHEN STFICHE.RECVREF <> 0 THEN SEVK_HESABI.DEFINITION_ ELSE  CLCARD.DEFINITION_ END DEFINITION_,
	CLCARD.CODE ORJ_CR_CODE,
	CLCARD.DEFINITION_ ORJ_CR_DEFINITION_

FROM 
	LG_120_01_STLINE STLINE  WITH(NOLOCK)
	INNER JOIN LG_120_01_STFICHE STFICHE  WITH(NOLOCK) ON STLINE.STFICHEREF = STFICHE.LOGICALREF 
	INNER JOIN LG_120_CLCARD CLCARD  WITH(NOLOCK) ON STLINE.CLIENTREF = CLCARD.LOGICALREF
	LEFT OUTER JOIN LG_120_CLCARD  SEVK_HESABI  WITH(NOLOCK) ON STFICHE.RECVREF = SEVK_HESABI.LOGICALREF
	INNER JOIN LG_120_01_SLTRANS SLTRANS  WITH(NOLOCK) ON STLINE.LOGICALREF = SLTRANS.STTRANSREF AND SLTRANS.ITEMREF = STLINE.STOCKREF
WHERE
	STLINE.LINETYPE ='0'
	AND STLINE.CANCELLED =0
	AND STLINE.TRCODE ='1')
SELECT 

	CASE 
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND (GIRIS_CARI_BILGISI.CODE NOT LIKE '120.01.001' AND GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.01-TEKST�L FASON M��TER� ��� KUMA�LARI �RET�M' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND (GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.001' AND  GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.02-TEKST�L FASON M��TER� ��� KUMA�LARI NUMUNE' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND SLTRANS.INVENNO IN ('611','615') AND (GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.001' AND GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.03-TEKST�L FASON M��TER� ��� KUMA� GAZE ��LEMLER�' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND GIRIS_CARI_BILGISI.CODE  = '120.01.001' 
		THEN '1.04-PAZARLAMA ��� KUMA�LARI �RET�M' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND GIRIS_CARI_BILGISI.CODE   = '120.01.001' 
		THEN '1.05-PAZARLAMA ��� KUMA�LARI NUMUNE' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND GIRIS_CARI_BILGISI.CODE   = '120.01.000' 
		THEN '1.06-TEKST�L METRAJ ��� KUMA�LARI �RET�M' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND GIRIS_CARI_BILGISI.CODE   = '120.01.000' 
		THEN '1.07-TEKST�L METRAJ ��� KUMA�LARI NUMUNE' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =  'T.09' 
		THEN '1.08-TEKST�L METRAJ BOYALI KUMA�LAR' 
		
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Boyahane' AND TEKSTIL_PAZARLAMA = 'Tekstil'
		THEN '1.09.01-TEKST�L FASON YARIMAMUL �RET�M TEKST�L' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Boyahane' AND TEKSTIL_PAZARLAMA = 'Pazarlama'
		THEN '1.09.01-TEKST�L FASON YARIMAMUL �RET�M PAZARLAMA' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =  'T.10' 
		THEN '1.10-TEKST�L FASON M��TER�DEN �ADE GELEN KUMA�LAR' 
		
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =   'T.08' AND INVENNO=4
		THEN '1.11-TEKST�L FASON TEBD�LE GELEN �ADE MALLARI STOGU BEDELS�Z' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =   'T.02' 
		THEN '2.01-TEKST�L BOYA STOKLARI' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =   'T.03' 
		THEN '2.02-TEKST�L K�MYASAL STOKLARI' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =  'T.04' 
		THEN '1.12-TEKST�L �RET�M YARD. MALZEME STOKLARI' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,3) =  'BKM' 
		THEN '2.03-TEKST�L BAKIM STOKLARI' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =  '�DR.' 
		THEN '2.04-�DAR� ��LER STOKLARI' 

		
		WHEN 
		ITEMS.CODE IN ('P.02%','T.622%') AND CAPIWHOUSE.NAME = 'Merkez' 
		THEN '2.05-PAZARLAMA YARI MAMULLER� �RET�M' 

		WHEN 
		ITEMS.CODE IN ('P.02%','T.622%')  AND SLTRANS.INVENNO LIKE '6%' 
		THEN '2.06-PAZARLAMA YARI MAMULLER� KONFEKS�YON' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,5) =  'P.04.' AND CAPIWHOUSE.NAME = 'Merkez' 
		THEN '2.07-PAZARLAMA MAMUL STOKLARI' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'P.04' AND CAPIWHOUSE.NAME = 'Hatal� �r�n' 
		THEN '2.08-PAZARLAMA MAMULLER HATALI URUNLER' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'P.04' AND SLTRANS.INVENNO LIKE '2%' 
		THEN '2.09-PAZARLAMA KONS�NYE MAMULLER' 
		
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =   'P.03' 
		THEN '2.10-PAZARLAMA YARDIMCI MALZEMELER' 
		

		ELSE 'TANIMSIZ' END URUN_GRUBU,
	STFICHE.FICHENO STFICHE_FICHENO,
	STFICHE.DATE_ STFICHE_DATE,
	ITEMS.CODE ITEMS_CODE,
	ITEMS.NAME ITEMS_NAME,
	GIRIS_CARI_BILGISI.CODE CR_CODE,
	GIRIS_CARI_BILGISI.DEFINITION_ CR_DEFINITION,
	GIRIS_CARI_BILGISI.ORJ_CR_CODE ORJ_CR_CODE,
	GIRIS_CARI_BILGISI.ORJ_CR_DEFINITION_ ORJ_CR_DEFINITION,
	SLTRANS.IOCODE STLINE_IOCODE,
	CASE WHEN SLTRANS.IOCODE IN (1,2) THEN SLTRANS.AMOUNT ELSE SLTRANS.AMOUNT*-1 END  SLTRANS_AMOUNT,
	SLTRANS.DATE_ SLTRANS_DATE,
	STLINE.TRCODE STLINE_TRCODE,
	SLTRANS.INVENNO,
	CAPIWHOUSE.NAME CAPIWHOUSE_NAME,
	UNITSETL.CODE UNITSETL_CODE,
	SERILOTN.CODE SERILOTN_CODE,
	SERILOTN.NAME SERILOTN_NAME,
	(STLINE.VATMATRAH/STLINE.AMOUNT) * CASE WHEN SLTRANS.IOCODE IN (1,2) THEN SLTRANS.AMOUNT ELSE SLTRANS.AMOUNT*-1 END TUTAR,
	ROUND(GIRIS_CARI_BILGISI.GIRIS_FIYATI,6) GIRIS_FIYATI,
	GIRIS_CARI_BILGISI.FICHENO
	,TEKSTIL_PAZARLAMA
FROM
	LG_120_01_SLTRANS SLTRANS WITH(NOLOCK)
	INNER JOIN LG_120_01_STLINE STLINE  WITH(NOLOCK) ON SLTRANS.STTRANSREF = STLINE.LOGICALREF
	INNER JOIN LG_120_01_STFICHE STFICHE  WITH(NOLOCK) ON STLINE.STFICHEREF = STFICHE.LOGICALREF
	INNER JOIN L_CAPIWHOUSE CAPIWHOUSE  WITH(NOLOCK) ON SLTRANS.INVENNO = CAPIWHOUSE.NR AND CAPIWHOUSE.FIRMNR =120
	INNER JOIN LG_120_ITEMS ITEMS  WITH(NOLOCK) ON STLINE.STOCKREF = ITEMS.LOGICALREF 
	INNER JOIN LG_120_UNITSETL UNITSETL  WITH(NOLOCK) ON ITEMS.UNITSETREF = UNITSETL.UNITSETREF   AND MAINUNIT ='1'
	INNER JOIN LG_120_01_SERILOTN SERILOTN  WITH(NOLOCK) ON SLTRANS.SLREF = SERILOTN.LOGICALREF AND SLTRANS.ITEMREF = SERILOTN.ITEMREF
	LEFT OUTER JOIN  GIRIS_CARI_BILGISI ON SERILOTN.LOGICALREF = GIRIS_CARI_BILGISI.SLREF AND SERILOTN.ITEMREF = GIRIS_CARI_BILGISI.STOCKREF 
WHERE

	 STLINE.LINETYPE ='0'
	--AND ORJ_CR_CODE ='120.01.001'
	--AND ITEMS.CODE ='T.01.0108'
	--AND SERILOTN.CODE ='202301010001'
	AND STLINE.CANCELLED ='0'
	
	AND 
	CASE 
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND (GIRIS_CARI_BILGISI.CODE NOT LIKE '120.01.001' AND GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.01-TEKST�L FASON M��TER� ��� KUMA�LARI �RET�M' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND (GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.001' AND  GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.02-TEKST�L FASON M��TER� ��� KUMA�LARI NUMUNE' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND SLTRANS.INVENNO IN ('611','615') AND (GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.001' AND GIRIS_CARI_BILGISI.CODE  NOT LIKE '120.01.000') 
		THEN '1.03-TEKST�L FASON M��TER� ��� KUMA� GAZE ��LEMLER�' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND GIRIS_CARI_BILGISI.CODE  LIKE '120.01.001' 
		THEN '1.04-PAZARLAMA ��� KUMA�LARI �RET�M' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND GIRIS_CARI_BILGISI.CODE   LIKE '120.01.001' 
		THEN '1.05-PAZARLAMA  ��� KUMA�LARI NUMUNE' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='�i� Kuma�' AND GIRIS_CARI_BILGISI.CODE   LIKE '120.01.000' 
		THEN '1.06-TEKST�L METRAJ  ��� KUMA�LARI �RET�M' 
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Numune' AND GIRIS_CARI_BILGISI.CODE   LIKE '120.01.000' 
		THEN '1.07-TEKST�L METRAJ ��� KUMA�LARI NUMUNE' 

		
		WHEN 
		ITEMS.CODE LIKE 'T.09%' 
		THEN '1.08-TEKST�L METRAJ BOYALI KUMA�LAR' 
		
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Boyahane' AND TEKSTIL_PAZARLAMA = 'Tekstil'
		THEN '1.09.01-TEKST�L FASON YARIMAMUL �RET�M TEKST�L' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'T.01' AND CAPIWHOUSE.NAME ='Boyahane' AND TEKSTIL_PAZARLAMA = 'Pazarlama'
		THEN '1.09.01-TEKST�L FASON YARIMAMUL �RET�M PAZARLAMA' 

		WHEN 
		ITEMS.CODE LIKE 'T.10%' 
		THEN '1.10-TEKST�L FASON M��TER�DEN �ADE GELEN KUMA�LAR' 
		
		
		WHEN 
		ITEMS.CODE LIKE 'T.08%' AND INVENNO=4
		THEN '1.11-TEKST�L FASON TEBD�LE GELEN �ADE MALLARI STOGU BEDELS�Z' 
		
		WHEN 
		ITEMS.CODE LIKE 'T.02%' 
		THEN '2.01-TEKST�L BOYA STOKLARI' 

		
		WHEN 
		ITEMS.CODE LIKE 'T.03%' 
		THEN '2.02-TEKST�L K�MYASAL STOKLARI' 

		
		WHEN 
		ITEMS.CODE LIKE 'T.04%' 
		THEN '1.12-TEKST�L �RET�M YARD. MALZEME STOKLARI' 
		
		WHEN 
		ITEMS.CODE LIKE 'BKM%' 
		THEN '2.03-TEKST�L BAKIM STOKLARI' 

		
		WHEN 
		ITEMS.CODE LIKE '�DR.%' 
		THEN '2.04-�DAR� ��LER STOKLARI' 

		
		WHEN 
		ITEMS.CODE IN ('P.02%','T.622%')  AND CAPIWHOUSE.NAME = 'Merkez' 
		THEN '2.05-PAZARLAMA YARI MAMULLER� �RET�M' 

		WHEN 
		ITEMS.CODE IN ('P.02%','T.622%')  AND SLTRANS.INVENNO LIKE '6%' 
		THEN '2.06-PAZARLAMA YARI MAMULLER� KONFEKS�YON' 

		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,5) =   'P.04.' AND CAPIWHOUSE.NAME = 'Merkez' 
		THEN '2.07-PAZARLAMA MAMUL STOKLARI' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) =   'P.04' AND CAPIWHOUSE.NAME = 'Hatal� �r�n' 
		THEN '2.08-PAZARLAMA MAMULLER HATALI URUNLER' 

		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'P.04' AND  SLTRANS.INVENNO LIKE '2%' 
		THEN '2.09-PAZARLAMA KONS�NYE MAMULLER' 
		
		
		WHEN 
		SUBSTRING(ITEMS.CODE,1,4) = 'P.03' 
		THEN '2.10-PAZARLAMA YARDIMCI MALZEMELER' 
		

		ELSE 'TANIMSIZ' END <> 'TANIMSIZ' --URUN_GRUBU,
		

	--AND STFICHE.FICHENO ='00000117'

	/*
SELECT  
	SLTRANS.SLREF,
	CLCARD.CODE,
	CLCARD.DEFINITION_


FROM 
	LG_120_01_STLINE STLINE 
	INNER JOIN LG_120_CLCARD CLCARD ON STLINE.CLIENTREF = CLCARD.LOGICALREF
	INNER JOIN LG_120_01_SLTRANS SLTRANS ON STLINE.LOGICALREF = SLTRANS.STTRANSREF AND SLTRANS.ITEMREF = STLINE.STOCKREF
WHERE
	STLINE.LINETYPE ='0'
	AND STLINE.CANCELLED =0
	AND STLINE.TRCODE ='1'
	*/

GO


