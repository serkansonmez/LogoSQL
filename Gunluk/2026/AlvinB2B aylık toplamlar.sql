select UretimYil,UretimAy,TedarikciFirmaAdi, Grup2, sum(Uretilen) as Uretilen,Birim from 

(
select UretimYil,UretimAy,TedarikciFirmaAdi,grup,substring(StokKodu,1,2) kod2,
case when substring(StokKodu,1,2) = '70' OR substring(StokKodu,1,2) = '12' OR substring(StokKodu,1,2) = '76'  OR substring(StokKodu,1,2) = 'A7'
then 'NORMAL DOÐRAMA' 
 when substring(StokKodu,1,2) = '74'  
then 'BASÝT SÜRME' 
 when substring(StokKodu,1,2) = '14'  
then 'ÝNOVA SÜRME' 
end 


Grup2, round(sum(Miktar),2) as Uretilen,Birim from  [VW_ErcomMaliyetAnalizi_25] 
where UretimYil = 2025 and TedarikciFirmaId  =  2 and TedarikciFirmaAdi is not null and (grup ='KASA' OR grup ='KANAT' OR GRUP = 'KAYIT')
group by UretimYil,UretimAy,grup,Birim,substring(StokKodu,1,2),TedarikciFirmaAdi
) tblAsas
group by UretimYil,UretimAy, Birim,TedarikciFirmaAdi,Grup2
order by     UretimYil,UretimAy,grup2,Birim
-- SELECT top 100 * FROM [VW_ErcomMaliyetAnalizi_25] WHERE substring(StokKodu,1,2) = 'A7'