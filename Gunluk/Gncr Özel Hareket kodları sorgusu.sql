 

EXECUTE  [dbo].[SP_TigerHareketOzelKodu] 
   119
  ,43
  --3,17,20,21,24,25,27,33,43
  --�zel Kod T�rleri ;
  --1:Stok kart�,;2:Stok fi�i,;3:Stok fi�i sat�r�,;4:Al�nan hizmet kartlar�,;5:Verilen hizmet kartlar�,;6:Al�� indirim kart;7:Al�� masraf kartlar�;
  --8:Sat�� indirim kartlar�,;9:Sat�� masraf kartlar�,;10:Al�� promosyon kartlar�,;11:Sat�� prom. Kartlar�;14:Al�nan sipari�ler;15:Verilen sipari�ler,;
  --16:Al�nan sip.fi� sat�rlar�,;17:Verilen sip.fi� sat�rlar�;18:Al�m irsaliyeleri,;19:Sat�� irsaliyeleri;20:Al�m irsaliye sat�rlar�,;21:Sat�� irsaliye sat�rlar�;
  --22:Al�m faturalar�,;23:Sat�� faturalar�

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