create Procedure SP_HaftalikFinansalOzetInsert as 
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


select  @NakitToplami= Sum(Bakiye)  from TIGER..VW_Bankalar_23  
select  @NakitToplamiUsd= Sum(DovizBakiye)  from TIGER..VW_Bankalar_23  where DovizCinsi='$'
select  @NakitToplamiEuro= Sum(DovizBakiye)  from TIGER..VW_Bankalar_23  where DovizCinsi='€'
select  @NakitToplamiTl= Sum(DovizBakiye)  from TIGER..VW_Bankalar_23  where DovizCinsi='TL'
select @PortfoydekiCekler= sum(amount) from TIGER..VW_PortfoydekiCekler_2023
select @CariAlacaklarimiz= sum(Bakiye) from TIGER..VW_CariAlacaklarListesi_23
select @StokToplami= sum(Toplam) from TIGER..VW_CamStokListesi_23
select @KredilerToplami= sum(KalanTl) * -1 from TIGER..VW_BankaKredileri_23 where Durum = 'Yürürlükte'
select @CeklerToplami= sum(Tutar) * -1 from TIGER..VW_CekSenetRaporu_23 where  Durum = 'Kendi Çekimiz'
select @CariBorclarToplami= sum(Bakiye) * -1 from TIGER..VW_CariBorclarListesi_23   
 select @KrediKartlariToplami = sum(Bakiye) * -1 from TIGER..VW_KrediKartiIcmalListesi_23

 set @Bakiye = @NakitToplami + @PortfoydekiCekler + @CariAlacaklarimiz + @StokToplami + @KredilerToplami + @CeklerToplami + @CariBorclarToplami + @KrediKartlariToplami

 insert into HaftalikFinansalOzet
  select GETDATE () as Tarih,
      year(getdate()) as Yil,
	  DATEPART(WW,GETDATE ()) as Hafta,
	  @NakitToplami,
	   @NakitToplamiTl,
	  @NakitToplamiEuro,
	  @NakitToplamiUsd,
	  @PortfoydekiCekler,
	  @CariAlacaklarimiz,
	  @StokToplami,
	  @KredilerToplami,
	  @CeklerToplami,
	  @CariBorclarToplami,
	  @KrediKartlariToplami,
	  @Bakiye  
 




 select * from HaftalikFinansalOzet
	 












--select * from TIGER..LG_EXCHANGE_023