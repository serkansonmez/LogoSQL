
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
    TIGER..LG_025_01_STFICHE STF WITH(NOLOCK) -- Sat�nalma faturalar� ana tablo
JOIN 
    TIGER..LG_025_01_STLINE STL WITH(NOLOCK) ON STF.LOGICALREF = STL.STFICHEREF -- Sat�nalma fatura sat�rlar�
JOIN 
    TIGER..LG_025_ITEMS STK WITH(NOLOCK) ON STL.STOCKREF = STK.LOGICALREF -- Stok kart�
JOIN 
    TIGER..LG_025_CLCARD CLC  WITH(NOLOCK) ON STF.CLIENTREF = CLC.LOGICALREF -- Cari hesap kart�
WHERE 
    STF.TRCODE = 1 -- Sat�nalma faturas� (TRCODE 1: Sat�nalma Faturas�)
	--AND CLC.DEFINITION_ LIKE 'DEM�RTA�%' AND STK.NAME LIKE '%RON%'
ORDER BY 
    STF.DATE_ DESC, STF.FICHENO;
