SELECT 
   *
FROM 
    LG_000_SYSLOG      -- Log tablosunun ad� (Logo'nun kulland��� veritaban�na g�re de�i�ebilir)
 where DATE_ BETWEEN '20241112' AND  '20241115' AND USERNAME = '�RET�M' and MSGS1 like '%2411.0199%'
    