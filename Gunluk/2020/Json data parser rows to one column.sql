 /*
 SELECT  * FROM 
 OPENJSON('{"ulke":"Türkiye","il":"BURSA","ilce":"BURSA","adres1":"ATAEVLER MAH. ALÝ RIZA BEY CAD. ÇAÐIN F BLOK 1 13","adres2":"","vergiNo":"8520247774","vergiDairesi":"NÝLÜFER","ad":"MÜJGAN","soyad":"TOPALOÐLU","unvan":null,"efaturaGondericiPK":"","efaturaAliciGB":"","eIrsaliyeGondericiPK":"","eIrsaliyeAliciGB":"","efaturaCheck":"false","eIrsaliyeCheck":"false"}')
 
declare @NewEmployees nvarchar (max) = '{"ulke":"Türkiye","il":"BURSA","ilce":"BURSA","adres1":"ATAEVLER MAH. ALÝ RIZA BEY CAD. ÇAÐIN F BLOK 1 13","adres2":"","vergiNo":"8520247774","vergiDairesi":"NÝLÜFER","ad":"MÜJGAN","soyad":"TOPALOÐLU","unvan":null,"efaturaGondericiPK":"","efaturaAliciGB":"","eIrsaliyeGondericiPK":"","eIrsaliyeAliciGB":"","efaturaCheck":"false","eIrsaliyeCheck":"false"}'
*/
SELECT *
FROM OPENJSON('{"ulke":"Türkiye","il":"BURSA","ilce":"BURSA","adres1":"ATAEVLER MAH. ALÝ RIZA BEY CAD. ÇAÐIN F BLOK 1 13","adres2":"","vergiNo":"8520247774","vergiDairesi":"NÝLÜFER","ad":"MÜJGAN","soyad":"TOPALOÐLU","unvan":null,"efaturaGondericiPK":"","efaturaAliciGB":"","eIrsaliyeGondericiPK":"","eIrsaliyeAliciGB":"","efaturaCheck":"false","eIrsaliyeCheck":"false"}')
WITH (
	ulke VARCHAR(100) 'strict $.ulke',
	il VARCHAR(256) '$.il',
	ilce VARCHAR(50) '$.ilce', 
	adres1 VARCHAR(250) '$.adres1' ,
	adres2 VARCHAR(250) '$.adres2', 
	vergiNo VARCHAR(50) '$.vergiNo',
	vergiDairesi VARCHAR(50) '$.vergiDairesi',
	ad VARCHAR(50) '$.ad', 
	soyad VARCHAR(50) '$.soyad', 
	unvan VARCHAR(250) '$.unvan' ,
	efaturaGondericiPK VARCHAR(250) '$.efaturaGondericiPK' ,
	efaturaAliciGB VARCHAR(250) '$.efaturaAliciGB',
	eIrsaliyeGondericiPK VARCHAR(250) '$.eIrsaliyeGondericiPK',
	eIrsaliyeAliciGB VARCHAR(250) '$.eIrsaliyeAliciGB',
	efaturaCheck VARCHAR(5) '$.efaturaCheck',
	eIrsaliyeCheck VARCHAR(5) '$.eIrsaliyeCheck'
);