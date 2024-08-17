SELECT * FROM LG_119_EMUHACC

70 TOPAZ GES ENERJ� A.�.
090 'Gncr Canada'
SELECT *   FROM LG_121_EMUHACC WHERE CODE LIKE '%.090%'

update LG_121_EMUHACC set CODE = replace(code,'.090','.099'), DEFINITION_= replace(DEFINITION_,'TOPAZ GES ENERJ� A.�.','GNCR CANADA') WHERE CODE LIKE '%.090%'

update LG_121_EMUHACC set CODE = replace(code,'.090','.099')  WHERE CODE LIKE '%.090%' AND SUBSTRING(CODE,14,4) <> '090' AND CODE NOT IN ('320.79.1.0.090','127.36.00.01.090','128.36.00.01.090','129.36.00.01.090') 


70 TOPAZ GES ENERJ� A.�.
090 'Gncr Canada'
SELECT *   FROM LG_121_EMUHACC WHERE CODE LIKE '%.71%' AND SUBSTRING(CODE,1,1) <> 7

update LG_121_EMUHACC set CODE = replace(code,'.71','.100'), DEFINITION_= replace(DEFINITION_,'SAF�R GES ENERJ� A.�.','HAZELDEAN') WHERE CODE LIKE '%.71%' AND SUBSTRING(CODE,1,1) <> 7

70 TOPAZ GES ENERJ� A.�.
090 'Gncr Canada'
SELECT *   FROM LG_121_EMUHACC WHERE CODE LIKE '%.72%' AND SUBSTRING(CODE,1,1) <> 7

update LG_121_EMUHACC set CODE = replace(code,'.72','.101'), DEFINITION_= replace(DEFINITION_,'MERCAN GES ENERJ� A.�.','EVEREST NORTH') WHERE CODE LIKE '%.72%' AND SUBSTRING(CODE,1,1) <> 7


70 TOPAZ GES ENERJ� A.�.
090 'Gncr Canada'
SELECT *   FROM LG_121_EMUHACC WHERE CODE LIKE '%.73%' AND SUBSTRING(CODE,1,1) <> 7

update LG_121_EMUHACC set CODE = replace(code,'.73','.102'), DEFINITION_= replace(DEFINITION_,'�AMLI B�YOGAZ ENERJ� A.�.','EVEREST SOUTH') WHERE CODE LIKE '%.73%' AND SUBSTRING(CODE,1,1) <> 7



DELETE  FROM LG_121_EMUHACC WHERE   (SUBSTRING(CODE,1,3) = '320' OR SUBSTRING(CODE,1,3) = '120' ) AND LEN(CODE)> 3