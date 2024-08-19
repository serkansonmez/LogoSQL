DECLARE @json nvarchar(max)
DECLARE @xml XML;
SET @json='{"ulke":"Türkiye","il":"BURSA","ilce":"BURSA","adres1":"ATAEVLER MAH. ALÝ RIZA BEY CAD. ÇAÐIN F BLOK 1 13","adres2":"","vergiNo":"8520247774","vergiDairesi":"NÝLÜFER","ad":"MÜJGAN","soyad":"TOPALOÐLU","unvan":null,"efaturaGondericiPK":"","efaturaAliciGB":"","eIrsaliyeGondericiPK":"","eIrsaliyeAliciGB":"","efaturaCheck":"false","eIrsaliyeCheck":"false"}';

SELECT  @xml= dbo.fn_parse_json2xml(@json)  

select 
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('ulke')  AS book(addrbook)) as ulke , 
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('il')  AS book(addrbook)) as il,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('ilce')  AS book(addrbook)) as ilce,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('adres1')  AS book(addrbook)) as adres1,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('adres2')  AS book(addrbook)) as adres2,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('vergiNo')  AS book(addrbook)) as vergiNo,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('vergiDairesi')  AS book(addrbook)) as vergiDairesi,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('ad')  AS book(addrbook)) as ad,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('soyad')  AS book(addrbook)) as soyad,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('unvan')  AS book(addrbook)) as unvan,

(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('efaturaGondericiPK')  AS book(addrbook)) as efaturaGondericiPK,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('efaturaAliciGB')  AS book(addrbook)) as efaturaAliciGB,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('eIrsaliyeGondericiPK')  AS book(addrbook)) as eIrsaliyeGondericiPK,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('eIrsaliyeAliciGB')  AS book(addrbook)) as eIrsaliyeAliciGB,
 (select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('efaturaCheck')  AS book(addrbook)) as efaturaCheck,
(select book.addrbook.value('.', 'VARCHAR(100)') AS ulke FROM  @xml.nodes('eIrsaliyeCheck')  AS book(addrbook)) as eIrsaliyeCheck
 