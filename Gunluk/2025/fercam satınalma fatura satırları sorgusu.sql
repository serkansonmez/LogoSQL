
SELECT 
    STF.FICHENO AS FaturaNo,
    STF.DATE_ AS FaturaTarihi,
    CLC.CODE AS CariHesapKodu,
    CLC.DEFINITION_ AS CariHesapAdi,
    STK.CODE AS StokKodu,
    STK.NAME AS StokAdi,
    STL.AMOUNT AS Adet,
    STL.PRICE AS BirimFiyat,
   
    STL.TOTAL AS SatirToplami,
	STL.VATAMNT AS KdvToplami,
	STL.VATAMNT + STL.TOTAL AS KdvDahilToplam
	 
FROM 
    TIGER..LG_025_01_STFICHE STF WITH(NOLOCK) -- Satýnalma faturalarý ana tablo
JOIN 
    TIGER..LG_025_01_STLINE STL WITH(NOLOCK) ON STF.LOGICALREF = STL.STFICHEREF -- Satýnalma fatura satýrlarý
JOIN 
    TIGER..LG_025_ITEMS STK WITH(NOLOCK) ON STL.STOCKREF = STK.LOGICALREF -- Stok kartý
JOIN 
    TIGER..LG_025_CLCARD CLC  WITH(NOLOCK) ON STF.CLIENTREF = CLC.LOGICALREF -- Cari hesap kartý
WHERE 
    STF.TRCODE = 1 -- Satýnalma faturasý (TRCODE 1: Satýnalma Faturasý)
	--AND CLC.DEFINITION_ LIKE 'DEMÝRTAÞ%' AND STK.NAME LIKE '%RON%'
ORDER BY 
    STF.DATE_ DESC, STF.FICHENO;
