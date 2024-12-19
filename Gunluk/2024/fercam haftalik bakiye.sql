declare @NakitToplami float 
declare @NakitToplamiTl float 
declare @NakitToplamiUsd float 
declare @NakitToplamiEuro float 
declare @PortfoydekiCekler float 
declare @CariAlacaklarimiz float
declare @StokToplami float
declare @KredilerToplami float 
declare @CeklerToplami float 
declare @CariBorclarToplami float
declare @KrediKartlariToplami float 
declare @Bakiye float 
declare @Id int = 0
declare @Hafta int =52
--select DATEPART(WW,GETDATE ())
--SELECT* FROM  TIGER..VW_CekSenetRaporu_24 where Tip = 'Kendi Çekimiz'  and  DATEPART(WW,Vade) <=1 and VadeYil<= 2024

select  @NakitToplami= Sum(Bakiye)  from TIGER..VW_Bankalar_24   WHERE DATEPART(WW,DATE_) <= @Hafta
select  @NakitToplamiUsd= Sum(DovizBakiye)  from TIGER..VW_Bankalar_24  where DovizCinsi='$' AND DATEPART(WW,DATE_) <= @Hafta
select  @NakitToplamiEuro= Sum(DovizBakiye)  from TIGER..VW_Bankalar_24  where DovizCinsi='€' AND DATEPART(WW,DATE_) <= @Hafta
select  @NakitToplamiTl= Sum(DovizBakiye)  from TIGER..VW_Bankalar_24  where DovizCinsi='TL' AND DATEPART(WW,DATE_) <= @Hafta
select @PortfoydekiCekler= isnull(sum(amount),0) from TIGER..VW_PortfoydekiCekler_2024 WHERE DATEPART(WW,SETDATE) <= @Hafta
select @CariAlacaklarimiz= sum(HaftaBakiyesi) from TIGER..VW_CariAlacaklarListesiHaftalik_24 WHERE HaftaNo <= @Hafta
select @StokToplami= sum(Toplam) from TIGER..[VW_CamStokListesiHaftalik_24] WHERE Hafta  <= @Hafta
select @KredilerToplami= sum(KalanTl) * -1 from TIGER..VW_BankaKredileri_24 where Durum = 'Yürürlükte' and  DATEPART(WW,TahakkukTarihi) <= @Hafta
select @CeklerToplami= isnull(sum(Tutar),0)  from TIGER..VW_CekSenetRaporu_24 where  Tip = 'Kendi Çekimiz' and  DATEPART(WW,Vade) <= @Hafta  and VadeYil<= 2024
select @CariBorclarToplami= sum(HaftaBakiyesi) * -1 from TIGER..VW_CariBorclarListesiHaftalik_24    WHERE HaftaNo <= @Hafta
 select @KrediKartlariToplami = sum(Bakiye)   from TIGER..[VW_KrediKartiIcmalListesiHaftalik_24]  WHERE Hafta  <= @Hafta

 set @Bakiye = @NakitToplami + @PortfoydekiCekler + @CariAlacaklarimiz + @StokToplami + @KredilerToplami + @CeklerToplami + @CariBorclarToplami + @KrediKartlariToplami

 select @Id = Id from HaftalikFinansalOzet where Yil =  year(getdate()) and Hafta = @Hafta
 if (@Id=0)
 begin 
	 insert into HaftalikFinansalOzet
	  select GETDATE () as Tarih,
		  year(getdate()) as Yil,
		  @Hafta as Hafta,
		  round(@NakitToplami,2),
		   round(@NakitToplamiTl,2),
		 round( @NakitToplamiEuro,2),
		 round( @NakitToplamiUsd,2),
		 round( @PortfoydekiCekler,2),
		 round( @CariAlacaklarimiz,2),
		 round( @StokToplami,2),
		 round( @KredilerToplami,2),
		 round( @CeklerToplami,2),
		 round( @CariBorclarToplami,2),
		 round( @KrediKartlariToplami,2),
		 round( @Bakiye ,2) 
end

--    select * from HaftalikFinansalOzet where Yil = 2024 and hafta in (50,51,52  )
--   delete from HaftalikFinansalOzet where Yil = 2024 and hafta in ( 52  )

--select *  from TIGER..VW_CariAlacaklarListesiHaftalik_24 WHERE  CariKodu = '120.01.D002' ORDER BY HAFTANO
--select sum(HaftaBakiyesi)  from TIGER..VW_CariAlacaklarListesiHaftalik_24 WHERE  CariKodu = '120.01.D002' and HAftaNo <= 51

--select * from TIGER..VW_CariAlacaklarListesi_24 WHERE CariKodu = '120.01.D002'


--select  DATEPART(WW,'20240906')