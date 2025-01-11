SELECT 
   *
FROM 
    LG_000_SYSLOG      -- Log tablosunun adý (Logo'nun kullandýðý veritabanýna göre deðiþebilir)
 where DATE_ BETWEEN '20241112' AND  '20241115' AND USERNAME = 'ÜRETÝM' and MSGS1 like '%2411.0199%'
    