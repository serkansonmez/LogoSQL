DECLARE @SPDAHIL INT

SET @SPDAHIL = 1

SELECT  CARIREF, CARIADI,
SUM(ISNULL(GENELTOPLAM,0) - ISNULL(TOPLAMOIV,0) - (ISNULL(TOPLAMKDV,0)-ISNULL(TOPLAMTVK,0)) +
CASE WHEN @SPDAHIL=1 and TUR = 271 THEN ISNULL(TOPLAMGV,0) WHEN TUR = 69 THEN ISNULL(TOPLAMKESINTI,0) ELSE 0 END + isnull(TOPLAMMERAFONU,0)) AS 'TUTAR',
COUNT(SIRANO) AS 'EVRAKADEDI',
SUM(CASE WHEN AORS='S' THEN ISNULL(GENELTOPLAM,0) - (ISNULL(TOPLAMKDV,0)-ISNULL(TOPLAMTVK,0)) END + isnull(TOPLAMMERAFONU,0)) AS 'TUTAR_S',
COUNT(CASE WHEN AORS='S' THEN SIRANO END) AS 'EVRAKADEDI_S',
SUM(CASE WHEN AORS='A' THEN ISNULL(GENELTOPLAM,0) - (ISNULL(TOPLAMKDV,0)-ISNULL(TOPLAMTVK,0)) END +
CASE WHEN TUR = 271 THEN ISNULL(TOPLAMGV,0) ELSE 0 end+isnull(TOPLAMMERAFONU,0)) AS 'TUTAR_A',
COUNT(CASE WHEN AORS='A' THEN SIRANO END) AS 'EVRAKADEDI_A',
Carivergino AS VERGINO, FATURA.GMHK,
ISNULL(FATURA.ULKEKODU,'052') AS ULKEKODU,TELFAX,FATURA.VERGID,
SUM(CASE WHEN zirvegenel.dbo.EBelgemi(EVRAKNO, EVRAKTAR)=1 THEN 1 END) EBELGE_ADET,
SUM(CASE WHEN zirvegenel.dbo.EBelgemi(EVRAKNO, EVRAKTAR)=1 THEN ISNULL(GENELTOPLAM,0) - ISNULL(TOPLAMOIV,0) - (ISNULL(TOPLAMKDV,0)-ISNULL(TOPLAMTVK,0)) +
CASE WHEN @SPDAHIL=1 and TUR = 271 THEN ISNULL(TOPLAMGV,0) WHEN TUR = 69 THEN ISNULL(TOPLAMKESINTI,0) ELSE 0 END + ISNULL(TOPLAMMERAFONU,0) END) AS 'EBELGE_TUTAR',
SUM(CASE WHEN zirvegenel.dbo.EBelgemi(EVRAKNO, EVRAKTAR)=0 THEN 1 END) KAGIT_ADET,
SUM(CASE WHEN zirvegenel.dbo.EBelgemi(EVRAKNO, EVRAKTAR)=0 THEN ISNULL(GENELTOPLAM,0) - ISNULL(TOPLAMOIV,0) - (ISNULL(TOPLAMKDV,0)-ISNULL(TOPLAMTVK,0)) +
CASE WHEN @SPDAHIL=1 and TUR = 271 THEN ISNULL(TOPLAMGV,0) WHEN TUR = 69 THEN ISNULL(TOPLAMKESINTI,0) ELSE 0 END + ISNULL(TOPLAMMERAFONU,0) END) AS 'KAGIT_TUTAR'
 ,MONTH(EVRAKTAR) AS AY
 ,CARIGEN.EPOSTA
 , NEWID() AS Referans
FROM LISTEFATURA() AS FATURA
left JOIN CARIGEN ON CARIGEN.REF = FATURA.CARIREF
WHERE AORS='A' AND ISNULL(IPTAL,0) = 0

GROUP BY CARIREF,CARIADI,Carivergino,FATURA.GMHK,ISNULL(FATURA.ULKEKODU,'052'),TELFAX,FATURA.VERGID, MONTH(EVRAKTAR),CARIGEN.EPOSTA
HAVING round(sum(ISNULL(GENELTOPLAM,0)-ISNULL(TOPLAMKDV,0)+ISNULL(TOPLAMTVK,0)),2)>='8000'
 
ORDER BY MONTH(EVRAKTAR)   DESC


 