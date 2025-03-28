SELECT  * FROM VW_TigerGoSatinalmaFaturaKarsilastirmaListesi

ALTER view VW_TigerGoSatinalmaFaturaKarsilastirmaListesi as
select 
GO3_STL.LOGICALREF,
TGR_CLC.CODE AS TigerCariKodu,TGR_CLC.DEFINITION_ AS TigerCariAdi,
TGR_INV.FICHENO As TigerFaturaNo,
TGR_INV.DOCODE as TigerFaturaNo2,
--TGR_ITM.code as TigerMalzemeKodu,
--TGR_ITM.NAME as TigerMalzemeAdi,
CASE WHEN TGR_STL.LINETYPE = 4 THEN TGR_SRV.code ELSE TGR_ITM.code END  as TigerMalzemeKodu,
CASE WHEN TGR_STL.LINETYPE = 4 THEN TGR_SRV.DEFINITION_ ELSE TGR_ITM.NAME END  as TigerMalzemeAdi,
TGR_STL.AMOUNT as TigerMalzemeAdet,
TGR_STL.PRICE as TigerMalzemeBirimFiyat,
TGR_STL.LINENET as TigerMalzemeToplam,
 
cASE WHEN GO3_INV.TRCODE =1 THEN 'Sat�nalma Faturas�' else 'Sat�� �ade Faturas�' end as GoFaturaTuru, 
GO3_CLC.CODE AS GoCariKodu,
GO3_CLC.DEFINITION_ AS GoCariAdi, 
GO3_INV.FICHENO GoFaturaNo,
GO3_INV.DATE_ GoFaturaTarih,
CASE WHEN GO3_STL.LINETYPE = 4 THEN GO3_SRV.code ELSE GO3_ITM.code END  as GoMalzemeKodu,
CASE WHEN GO3_STL.LINETYPE = 4 THEN GO3_SRV.DEFINITION_ ELSE GO3_ITM.NAME END  as GoMalzemeAdi,
--GO3_ITM.NAME as GoMalzemeAdi,
GO3_STL.AMOUNT as GoMalzemeAdet,
GO3_STL.PRICE as GoMalzemeBirimFiyat,
GO3_STL.LINENET as GoMalzemeToplam
from GO3DB..LG_425_01_INVOICE GO3_INV
LEFT JOIN CEZVE..LG_325_01_INVOICE TGR_INV ON TGR_INV.DOCODE = GO3_INV.FICHENO

LEFT JOIN GO3DB..LG_425_CLCARD GO3_CLC ON GO3_INV.CLIENTREF = GO3_CLC.LOGICALREF

LEFT JOIN CEZVE..LG_325_CLCARD TGR_CLC ON TGR_INV.CLIENTREF = TGR_CLC.LOGICALREF --TGR_CLC.CODE = GO3_CLC.CODE

LEFT JOIN GO3DB..LG_425_01_STLINE GO3_STL ON GO3_STL.INVOICEREF = GO3_INV.LOGICALREF
LEFT JOIN GO3DB..LG_425_ITEMS GO3_ITM ON GO3_ITM.LOGICALREF = GO3_STL.STOCKREF  
LEFT JOIN GO3DB..LG_425_SRVCARD GO3_SRV ON GO3_SRV.LOGICALREF = GO3_STL.STOCKREF  
 
LEFT JOIN CEZVE..LG_325_01_STLINE TGR_STL ON TGR_STL.INVOICEREF = TGR_INV.LOGICALREF AND   TGR_STL.AMOUNT =  GO3_STL.AMOUNT AND TGR_STL.PRICE BETWEEN  GO3_STL.PRICE -1  AND GO3_STL.PRICE +1 



LEFT JOIN CEZVE..LG_325_ITEMS TGR_ITM ON TGR_ITM.LOGICALREF = TGR_STL.STOCKREF  
LEFT JOIN CEZVE..LG_325_SRVCARD TGR_SRV ON TGR_SRV.LOGICALREF = TGR_STL.STOCKREF  
WHERE GO3_INV.TRCODE  IN  (1,4)
AND ROUND(GO3_STL.LINENET,0) <> ROUND(TGR_STL.LINENET,0)
--AND GO3_INV.FICHENO = 'SFN2025000000539'

--SELECT * FROM CEZVE..LG_325_ITEMS  WHERE CODE = '150-MAB-0051'


-- SELECT * FROM  CEZVE..LG_325_01_INVOICE WHERE FICHENO = '0000000000000121'
-- SELECT * FROM  CEZVE..LG_325_01_STLINE WHERE INVOICEREF = 2005