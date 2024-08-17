USE [AlvinB2B_Default_v1]
GO

SELECT ProfileDescription,OrderNo, cast(sum(Fire) as float) / 1000 as FireMtul,SUM(CUTLENGTH) / 1000 Mtul2,Substring(Userbarcode,6,9) as ZirveKod
--,sum(Miktar)
  FROM [dbo].[KabanLabels] 
 -- left join VW_ErcomMaliyetAnalizi on VW_ErcomMaliyetAnalizi.TeklifSiparisNo = OrderNo and Substring(Userbarcode,6,9) = StokKodu
where [KabanLabels].Cutted= 1  and OrderNo = 'S301684'
group by  ProfileDescription,OrderNo,Substring(Userbarcode,6,9)

 
--   select sum (miktar) from VW_ErcomMaliyetAnalizi where TeklifSiparisNo = 'S301684' and stokKodu = '103003427'
-- select sum (miktar) from VW_ErcomMaliyetAnalizi where TeklifSiparisNo = 'S301684' and stokKodu = '103123427'
-- select sum(cutlength) from   [dbo].[KabanLabels] where LogHistoryid= 8323 and Substring(Userbarcode,6,9) = '103003427' and Cutted = 1
select * from KabanKesimHeaderListesi

select   ProfileDescription,OrderNo,  cast(sum(Length - MinimumLength) as float) / 1000 as FireMtul,SUM(CUTLENGTH) / 1000 Mtul,SUM(MinimumLength  / 1000 ) Mtul2,  Substring(Userbarcode,6,9) as ZirveKod  
  from KabanKesimListesi
left join KabanLabels on KabanLabels.KabanLabelsId = LabelId
left join KabanKesimHeaderListesi on KabanKesimHeaderListesi.KabanKesimHeaderListesiId =  HeaderId
where KabanLabels.OrderNo = 'S301684' and KabanLabels.Cutted = 1
group by  ProfileDescription,OrderNo,     Substring(Userbarcode,6,9) 


  select DISTINCT  SUM(MinimumLength  / 1000 ) from   KabanKesimListesi
left join KabanLabels on KabanLabels.KabanLabelsId = LabelId
left join KabanKesimHeaderListesi on KabanKesimHeaderListesi.KabanKesimHeaderListesiId =  HeaderId
where KabanLabels.OrderNo = 'S301684' and KabanLabels.Cutted = 1 and Substring(Userbarcode,6,9) = '103003427'


SELECT * FROM KabanKesimHeaderListesi where KabanKesimHeaderListesiID = 518420
select * from KabanKesimListesi  where HeaderId = 518420
select * --sum(cutlength) 
from KabanLabels where KabanLabelsId in (2265882,
2265883,
2265884)
select sum(cutlength),sum(OtherLength)  from KabanLabels where KabanLabelsId in (  select DISTINCT  LabelId from   KabanKesimListesi
left join KabanLabels on KabanLabels.KabanLabelsId = LabelId
left join KabanKesimHeaderListesi on KabanKesimHeaderListesi.KabanKesimHeaderListesiId =  HeaderId
where KabanLabels.OrderNo = 'S301684' and KabanLabels.Cutted = 1 and Substring(Userbarcode,6,9) = '103003427'
)
select *  from KabanLabels where KabanLabelsId in (  select DISTINCT  LabelId from   KabanKesimListesi
left join KabanLabels on KabanLabels.KabanLabelsId = LabelId
left join KabanKesimHeaderListesi on KabanKesimHeaderListesi.KabanKesimHeaderListesiId =  HeaderId
where KabanLabels.OrderNo = 'S301684' and KabanLabels.Cutted = 1 and Substring(Userbarcode,6,9) = '103003427'
)