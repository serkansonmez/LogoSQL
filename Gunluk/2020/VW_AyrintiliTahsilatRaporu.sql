USE [ArgelasB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_AyrintiliTahsilatRaporu]    Script Date: 9.11.2020 22:47:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[VW_AyrintiliTahsilatRaporu] as
select 
PT.LOGICALREF as PaytransLogicalref,
PT.CARDREF AS CariLogicalref,
CL.CODE as CariKodu,
CL.DEFINITION_ as CariUnvani,
PT.PROCDATE AS Tarih,
CLF.TRANNO AS FisNo,

--PT.MODULENR AS MODULNR,
	   --PT.SIGN AS B_A,
	   ---PT.FICHEREF AS FIS_REFERANS,
	   PT.TRCODE AS FisTrcode,
	   CASE   WHEN PT.TRCODE=14 AND PT.MODULENR=5 THEN 'A��l�� Fi�i'
	          WHEN PT.TRCODE=46 AND PT.MODULENR=5 THEN 'Al�nan Serbest Meslek Makbuzu' 
			  WHEN PT.TRCODE=70 AND PT.MODULENR=5 THEN 'Kredi Kart� Fi�i'
			  WHEN PT.TRCODE=4 AND PT.MODULENR=5 THEN 'Alacak Delekontu'
			  WHEN PT.TRCODE=5 AND PT.MODULENR=5 THEN 'Virman Fi�i'
			  WHEN PT.TRCODE=1 AND  PT.MODULENR=6 THEN '�ek Giri�i'
			  WHEN PT.TRCODE=2 AND  PT.MODULENR=6 THEN 'Senet Giri�i'
			  WHEN PT.TRCODE=3 AND  PT.MODULENR=7 THEN 'Gelen Havale'
		      WHEN PT.TRCODE=1 AND  PT.MODULENR=10 THEN 'Nakit Tahsilat'
              WHEN PT.TRCODE=1  AND PT.MODULENR=4 THEN 'Mal Al�m Faturas�'
			  WHEN PT.TRCODE=4  AND PT.MODULENR=4 THEN 'Al�nan Hizmet Faturas�'
			  WHEN PT.TRCODE=2  AND PT.MODULENR=4 THEN 'Perkande Sat�� �ade Faturas�'
		      WHEN PT.TRCODE=7  AND PT.MODULENR=4 THEN 'Perakende Sat�� Faturas�'
			  WHEN PT.TRCODE=8  AND PT.MODULENR=4 THEN 'Toptan Sat�� Faturas�'
			  WHEN PT.TRCODE=9  AND PT.MODULENR=4 THEN 'Verilen Hizmet  Faturas�'
			  WHEN PT.TRCODE=3  AND PT.MODULENR=4 THEN 'Al�m �ade Faturas�'

	  ELSE 'Tan�ms�z' END 'FisTuru',
	   --PT.TOTAL AS FIS_TUTARI
	PT.TOTAL AS Tutar ,
	PT.DATE_     AS VadeTarihi,
DATEDIFF(day,GETDATE(),PT.DATE_) AS Gun
	
FROM         TIGER3.dbo.LG_003_01_PAYTRANS PT WITH(NOLOCK) INNER JOIN
            TIGER3.dbo.LG_003_CLCARD CL WITH(NOLOCK) ON PT.CARDREF=CL.LOGICALREF INNER JOIN
			TIGER3.dbo.LG_003_01_CLFLINE CLF WITH(NOLOCK) ON PT.FICHEREF=CLF.SOURCEFREF AND CLF.MODULENR=PT.MODULENR

		 WHERE PT.SIGN=0 AND  PT.TOTAL-PT.PAID>0.00  AND PT.PAIDINCASH=0 AND PT.CANCELLED=0 
 --AND    (PT.CARDREF = 10396)
GO


