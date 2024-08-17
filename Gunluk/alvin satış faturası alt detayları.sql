 select ErcomEslesmeyenKartlar.Id,SiparisNo,MusterilerId,ErcomStokId,Miktar,Birim,Miktar as BirimKg,
 round(ToplamTutar / Miktar,2) as BirimFiyat,ToplamTutar,MusteriKodu,
			-- StokAdi,StokKodu,
TblStk.STA AS Stokadi, TblStk.STK AS StokKodu,
SiparisNo,TblStk.P_ID from VW_ErcomFiyatTeklifi 
left join ErcomStok on ErcomStok.Id = VW_ErcomFiyatTeklifi.ErcomStokId
left join ErcomEslesmeyenKartlar on ErcomEslesmeyenKartlar.ErcomKodu = ErcomStok.StokKodu
LEFT JOIN [ÝREN_PVC_2024T]..STOKGEN TblStk ON SUBSTRING(stk,8,5) + SUBSTRING(stk,14,4)  = case when ErcomEslesmeyenKartlar.ZirveKodu is not null then replace(ErcomEslesmeyenKartlar.ZirveKodu,'.','') else  StokKodu end
--  where TeklifSiparisNo = 'S301312' and PozNo= 'Poz 1' and ZirveSatisFaturaRef is null
where SiparisNo =    and ZirveFaturaRef is null


--select * from VW_ErcomFiyatTeklifi where SiparisNo = '410061'

select * from ErcomStok where Id in ( 1739,
6859,
1896)

select * from ErcomEslesmeyenKartlar where ErcomKodu in ('52200015',
'52311001',
'52300255')