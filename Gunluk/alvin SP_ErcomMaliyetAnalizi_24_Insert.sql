create procedure SP_ErcomMaliyetAnalizi_24_Insert as 
 
select VW_ErcomMaliyetAnalizi_24.TeklifNo, sum( (VW_ErcomMaliyetAnalizi_24.ToplamFiyat + VW_ErcomMaliyetAnalizi_24.KdvTutar)) as KdvDahilToplam  into ErcomMaliyetAnalizi_24 from VW_ErcomMaliyetAnalizi_24
 left join ErcomMaliyetAnalizi_24 on ErcomMaliyetAnalizi_24.TeklifNo = VW_ErcomMaliyetAnalizi_24.TeklifNo

 where ErcomMaliyetAnalizi_24.TeklifNo is null
group by VW_ErcomMaliyetAnalizi_24.TeklifNo