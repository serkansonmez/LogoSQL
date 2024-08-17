select * from [VW_SatinalmaTalepFormuTedarikci]  

--update OnayTalepleri set TigerAmbarNr  =0

select 
case when FirmaLogo = 'ÝPLÝK' THEN 1
  when FirmaLogo = 'BOYAHANE' THEN 2
    when FirmaLogo = 'DOKUMA' THEN 3 END , [VW_SatinalmaTalepFormuTedarikci].Id,
	'UPDATE OnayTalepleri SET  TigerAmbarNr=''' + cast  ( case when FirmaLogo = 'ÝPLÝK' THEN 1
  when FirmaLogo = 'BOYAHANE' THEN 2
    when FirmaLogo = 'DOKUMA' THEN 3 END as varchar(20))    + ''' WHERE Id=' + cast([VW_SatinalmaTalepFormuTedarikci].OnayTalepleriId as varchar(20))
from  [VW_SatinalmaTalepFormuTedarikci] where [VW_SatinalmaTalepFormuTedarikci].OnayTalepleriId is not null