WITH GIREN 
AS (
SELECT 
		GIREN.URUN_GRUBU,
		GIREN.UNITSETL_CODE,
		SUM(SLTRANS_AMOUNT) GIREN_MIKTAR
	FROM 
		TRP_213_01_SLTRANS_LINE GIREN
	WHERE 
    	GIREN.TEKSTIL_PAZARLAMA = 'Tekstil' and
		SLTRANS_DATE> =  CONVERT(dateTime,'20240101', 101)  AND 
		SLTRANS_DATE< =  CONVERT(dateTime,'20240131', 101)  AND  
		STLINE_IOCODE IN (1,2)
		GROUP BY GIREN.URUN_GRUBU,
		GIREN.UNITSETL_CODE) ,

 CIKAN
AS (
SELECT 
		CIKAN.URUN_GRUBU ,
		CIKAN.UNITSETL_CODE,
		SUM(SLTRANS_AMOUNT) CIKAN_MIKTAR

	FROM 
		TRP_213_01_SLTRANS_LINE CIKAN
	WHERE 
	    CIKAN.TEKSTIL_PAZARLAMA = 'Tekstil' and
		SLTRANS_DATE> =  CONVERT(dateTime,'20240101', 101)  AND 
		SLTRANS_DATE< =  CONVERT(dateTime,'20240131', 101)  AND  
		STLINE_IOCODE IN (3,4)
		GROUP BY 
		CIKAN.URUN_GRUBU,
		CIKAN.UNITSETL_CODE)
--SELECT * FROM GIREN

SELECT 
	LINE.URUN_GRUBU,
	--LINE.CAPIWHOUSE_NAME,
   ISNULL(SUM(LINE.SLTRANS_AMOUNT),0) +ISNULL((AVG(CIKAN.CIKAN_MIKTAR))*-1,0) - ISNULL((AVG(GIREN.GIREN_MIKTAR)),0)  DEVIR,
	AVG(GIREN.GIREN_MIKTAR) GIREN_MIKTAR  ,
	AVG(CIKAN.CIKAN_MIKTAR)*-1 CIKAN_MIKTAR,
    LINE.UNITSETL_CODE,
	SUM(LINE.SLTRANS_AMOUNT) KALAN_MIKTAR,

            BASTAR =CONVERT(dateTime,'20240101', 101),
               BITTAR =CONVERT(dateTime,'20240131', 101),
SUM(LINE.SLTRANS_AMOUNT * LINE.GIRIS_FIYATI) KALAN_TUTAR,
AVG(LINE.GIRIS_FIYATI) AS BIRIM_FIYAT,
LINE.TEKSTIL_PAZARLAMA

FROM 
TRP_213_01_SLTRANS_LINE LINE
LEFT OUTER JOIN  GIREN ON LINE.URUN_GRUBU = GIREN.URUN_GRUBU AND  LINE.UNITSETL_CODE= GIREN.UNITSETL_CODE 
LEFT OUTER JOIN  CIKAN ON LINE.URUN_GRUBU = CIKAN.URUN_GRUBU  AND  LINE.UNITSETL_CODE = CIKAN.UNITSETL_CODE  
WHERE 
LINE.SLTRANS_DATE<=  CONVERT(dateTime,'20240131', 101) 
and LINE.TEKSTIL_PAZARLAMA = 'Tekstil'
--AND LINE.ITEMS_CODE LIKE 'T.01%' AND LINE.CAPIWHOUSE_NAME ='�i� Kuma�' AND LINE.CR_CODE  LIKE '120.01.001' 
--AND LINE.ITEMS_CODE LIKE 'T.01%' AND LINE.CAPIWHOUSE_NAME ='�i� Kuma�' AND (LINE.CR_CODE NOT LIKE '120.01.001' or LINE.CR_CODE NOT LIKE '120.01.000') 
--AND LINE.CR_CODE LIKE '120.01.%'
--AND LINE.ITEMS_CODE LIKE 'T.01%'
--AND LINE.INVENNO ='4'

GROUP BY 
LINE.URUN_GRUBU,
LINE.UNITSETL_CODE,
LINE.TEKSTIL_PAZARLAMA,
LINE.URUN_GRUBU 
order by LINE.URUN_GRUBU
		