select Id, Tarih,
--REPLACE(alldata,'\n',''),
--CHARINDEX('price ', REPLACE(alldata,'\n',''))
--,substring(REPLACE(alldata,'\n',''),CHARINDEX('price ', REPLACE(alldata,'\n','')),len(CHARINDEX('price ', REPLACE(alldata,'\n',''))) )
 'SELL' AS Typ
,replace(substring (REPLACE(alldata,'\n',''),CHARINDEX('Period : ', REPLACE(alldata,'\n','')), LEN(REPLACE(alldata,'\n','')) - CHARINDEX('Period: ', REPLACE(alldata,'\n',''))),'Period : ','') as Period
--,substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata))
,SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))) AS Fiyat
,substring(SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata))) + 1, len(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),0,CHARINDEX(':',SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata))) + 1, len(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))))) as Borsa
--,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))
 ,SUBSTRING(replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', ''), charindex(':',replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', '')) + 1, len(replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', '')) ) as CoinTuru
--,replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', '')
--,CHARINDEX(CHAR(13),substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),1 )
 from AlfaLog nolock   where REPLACE(alldata,'\n','') like 'SELL%' 

UNION ALL
select  Id,  Tarih,
 'BUY' AS Typ
,replace(substring (REPLACE(alldata,'\n',''),CHARINDEX('Period : ', REPLACE(alldata,'\n','')), LEN(REPLACE(alldata,'\n','')) - CHARINDEX('Period: ', REPLACE(alldata,'\n',''))),'Period : ','') as Period
  ,SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))) AS Fiyat
,substring(SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata))) + 1, len(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),0,CHARINDEX(':',SUBSTRING(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),CHARINDEX(CHAR(13),substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata))) + 1, len(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))))) as Borsa
  ,SUBSTRING(replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', ''), charindex(':',replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', '')) + 1, len(replace(substring(substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)),1,CHARINDEX(' ', substring(alldata,CHARINDEX('price ',alldata) + 6,len(alldata) - CHARINDEX('price ',alldata)))),' ', '')) ) as CoinTuru

from AlfaLog nolock   where REPLACE(alldata,'\n','') like 'BUY%' 


--SELL (SCALP) : , price 0.02956  BINANCE:REEFUSDT   Period : 1
--0.02956  BINANCE:REEFUSDT   