  SELECT

OBJECT_NAME(c.OBJECT_ID) 'TABLO', c.name 'KOLON'

FROM sys.columns c

WHERE c.NAME LIKE '%sen%'  AND OBJECT_NAME(c.OBJECT_ID) LIKE 'LG%'

ORDER BY TABLO ASC