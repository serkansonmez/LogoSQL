  insert into KabanSiparisleri

 
SELECT  'SQL Query Ýle 20241115' DosyaAdi,TeklifTarihi, TeklifSiparisNo,CAST(SUBSTRING(PozNo, PATINDEX('%[0-9]%', PozNo), LEN(PozNo)) AS INT) as PozNo  FROM ErcomMaliyetAnalizi where 
TeklifSiparisNo in ('1400497' ) group by TeklifSiparisNo,CAST(SUBSTRING(PozNo, PATINDEX('%[0-9]%', PozNo), LEN(PozNo)) AS INT),TeklifTarihi