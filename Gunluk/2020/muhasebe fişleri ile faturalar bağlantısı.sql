 SELECT LG_076_20_EMFICHE.LOGICALREF, CAST(CAST(LG_076_20_CLFLINE.DATE_ AS FLOAT) AS VARCHAR) + '-' + CAST(LG_076_20_CLFLINE.LOGICALREF AS VARCHAR) AS Id, LG_076_CLCARD.CODE AS CariHesapKodu, LG_076_CLCARD.DEFINITION_ AS CariAdi, LG_076_20_CLFLINE.DATE_ AS Tarih, 
		LG_076_20_CLFLINE.TRANNO AS BelgeNo, dbo.Ay_isl('cl', LG_076_20_CLFLINE.TRCODE) AS Aciklama, CASE LG_076_20_CLFLINE.SIGN WHEN 0 THEN AMOUNT ELSE 0 END AS Borc, CASE LG_076_20_CLFLINE.SIGN WHEN 1 THEN AMOUNT ELSE 0 END AS Alacak, 0 AS Bakiye, 
		CASE WHEN LG_076_20_CLFLINE.TRCODE = 38 THEN
		   CONVERT (VARCHAR(10), LG_076_20_CLFLINE.DATE_ + (SELECT CAST(CODE AS INT) FROM LG_076_PAYPLANS WHERE LG_076_PAYPLANS.LOGICALREF = LG_076_CLCARD.PAYMENTREF),103)
		   ELSE  (SELECT CODE FROM LG_076_PAYPLANS AS PAYPLANS 
	   
		WHERE (LG_076_20_CLFLINE.PAYDEFREF = LOGICALREF)) END AS Vadesi,
		LG_076_20_INVOICE.EINVOICE,
		CASE WHEN LG_076_20_CLFLINE.TRCURR = 0 THEN 'TL' WHEN LG_076_20_CLFLINE.TRCURR = 1 THEN 'USD' WHEN LG_076_20_CLFLINE.TRCURR = 20 THEN 'EUR' ELSE '?' END AS IslemDovizi,
		LG_076_20_CLFLINE.TRNET AS IslemDovizTutari
		,CASE WHEN LG_076_20_INVOICE.ACCOUNTED = 1 THEN 'M' else ' ' end as MuhIsareti
		,(SELECT COUNT(LOGICALREF) FROM LG_076_20_EMFLINE WHERE LG_076_20_EMFLINE.ACCFICHEREF= LG_076_20_EMFICHE.LOGICALREF) AS MuhSatirSayi
		,LG_076_20_CLFLINE.TRCODE
		,CASE WHEN (SELECT COUNT(LOGICALREF) FROM LG_076_20_EMFLINE WHERE LG_076_20_EMFLINE.ACCFICHEREF= LG_076_20_EMFICHE.LOGICALREF)=0 AND LG_076_20_INVOICE.ACCOUNTED = 1 THEN 'Muhasebe Kay�tlar� Yok'
		WHEN (SELECT COUNT(LOGICALREF) FROM LG_076_20_EMFLINE WHERE LG_076_20_EMFLINE.ACCFICHEREF= LG_076_20_EMFICHE.LOGICALREF)>0 AND LG_076_20_INVOICE.ACCOUNTED = 0 THEN '��aret Yok'
		else 'Normal' end as Durum

		--,LG_076_20_CLFICHE.ACCFICHEREF
		--,LG_076_20_CLFICHE.LOGICALREF 
		-- ,LG_076_20_CLFLINE.SOURCEFREF
		-- ,LG_076_20_CLFICHE.LOGICALREF 
		FROM LG_076_20_CLFLINE 
		LEFT OUTER JOIN LG_076_CLCARD ON LG_076_20_CLFLINE.CLIENTREF = LG_076_CLCARD.LOGICALREF 
		LEFT OUTER JOIN LG_076_20_CLFICHE ON LG_076_20_CLFLINE.SOURCEFREF = LG_076_20_CLFICHE.LOGICALREF 
		LEFT OUTER JOIN LG_076_20_EMFICHE ON LG_076_20_EMFICHE.SOURCEFREF = LG_076_20_CLFLINE.SOURCEFREF
		LEFT OUTER JOIN LG_076_20_INVOICE ON LG_076_20_CLFLINE.TRANNO = LG_076_20_INVOICE.FICHENO 
		WHERE --(LG_076_CLCARD.CODE = @code) AND 
		(LG_076_20_CLFLINE.CANCELLED <> '1') AND LG_076_20_CLFLINE.TRCODE NOT IN (14,21,5,20,1,2)  
		AND MONTH(LG_076_20_CLFLINE.DATE_)=4
		--20 GELEN HAVALE
		--21 G�NDER�LEN HAVALE