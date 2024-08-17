 

EXECUTE  [dbo].[SP_TigerHareketOzelKodu] 
   119
  ,43
  --3,17,20,21,24,25,27,33,43
  --Özel Kod Türleri ;
  --1:Stok kartý,;2:Stok fiþi,;3:Stok fiþi satýrý,;4:Alýnan hizmet kartlarý,;5:Verilen hizmet kartlarý,;6:Alýþ indirim kart;7:Alýþ masraf kartlarý;
  --8:Satýþ indirim kartlarý,;9:Satýþ masraf kartlarý,;10:Alýþ promosyon kartlarý,;11:Satýþ prom. Kartlarý;14:Alýnan sipariþler;15:Verilen sipariþler,;
  --16:Alýnan sip.fiþ satýrlarý,;17:Verilen sip.fiþ satýrlarý;18:Alým irsaliyeleri,;19:Satýþ irsaliyeleri;20:Alým irsaliye satýrlarý,;21:Satýþ irsaliye satýrlarý;
  --22:Alým faturalarý,;23:Satýþ faturalarý

   SELECT LOGICALREF,4 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_004_specodes where codetype=1
   UNION ALL
   SELECT LOGICALREF,29 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_029_specodes where codetype=1
    UNION ALL
   SELECT LOGICALREF,55 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_055_specodes where codetype=1
    UNION ALL
   SELECT LOGICALREF,58 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_058_specodes where codetype=1
    UNION ALL
   SELECT LOGICALREF,73 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_073_specodes where codetype=1
    UNION ALL
   SELECT LOGICALREF,76 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_076_specodes where codetype=1
     UNION ALL
   SELECT LOGICALREF,119 as Firm, SPECODE,DEFINITION_, SPECODETYPE  FROM TIGER2_DB..lg_119_specodes where codetype=1