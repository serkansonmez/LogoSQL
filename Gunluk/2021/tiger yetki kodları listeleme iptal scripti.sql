  SELECT * FROM [TIGER2_DB].[dbo].[L_CAPIDRIGHT] WHERE
  OWNER = 76 -- F�RMA KODU
  AND ID = 111 -- l_CAPIUSER -NR alan�
  AND ACSKEY LIKE '%SSQ%' -- YETK� KODU
  /*
delete from   [L_CAPIDRIGHT] WHERE  OWNER = 76 -- F�RMA KODU
  AND ID = 111
  */
  SELECT * FROM [TIGER2_DB].[dbo].[L_CAPIDRIGHT] WHERE OWNER = 106 and ID = 178 


  SELECT * FROM l_CAPIUSER WHERE LOGICALREF = 44

    SELECT * FROM l_CAPIUSER where name like 'muge%'

	--m�ge 111
	--ersan 172
	--merve 193
	--busra 196
	--umran  192


	--DELETE FROM [TIGER2_DB].[dbo].[L_CAPIDRIGHT] WHERE  ID IN ( 111, 172,193,196,192)



	SELECT * FROM 
"TIGER2_DB"..L_CAPIDRIGHT
 WHERE 
(TYP = 135) AND (OWNER = 33) AND (ID = 6)