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
declare @Id int

declare @Hafta int = 5

while @Hafta <= 50
begin
    select  @NakitToplami=  isnull(Sum(Bakiye),0)  from TIGER..VW_Bankalar_24   WHERE DATEPART(WW,DATE_) <= @Hafta
    select  @NakitToplamiUsd=  isnull(Sum(DovizBakiye),0)  from TIGER..VW_Bankalar_24  where DovizCinsi='$' AND DATEPART(WW,DATE_) <= @Hafta
    select  @NakitToplamiEuro=  isnull(Sum(DovizBakiye),0)  from TIGER..VW_Bankalar_24  where DovizCinsi='€' AND DATEPART(WW,DATE_) <= @Hafta
    select  @NakitToplamiTl=  isnull(Sum(DovizBakiye),0)  from TIGER..VW_Bankalar_24  where DovizCinsi='TL' AND DATEPART(WW,DATE_) <= @Hafta
    select @PortfoydekiCekler= isnull(sum(amount),0) from TIGER..VW_PortfoydekiCekler_2024 WHERE DATEPART(WW,SETDATE) <= @Hafta
    select @CariAlacaklarimiz=  isnull(sum(HaftaBakiyesi),0) from TIGER..VW_CariAlacaklarListesiHaftalik_24 WHERE HaftaNo <= @Hafta
    select @StokToplami= sum(Toplam) from TIGER..[VW_CamStokListesiHaftalik_24] WHERE Hafta  <= @Hafta
    select @KredilerToplami=  isnull(sum(KalanTl) * -1,0) from TIGER..VW_BankaKredileri_24 where Durum = 'Yürürlükte' and  DATEPART(WW,TahakkukTarihi) <= @Hafta
    select @CeklerToplami= isnull(sum(Tutar),0)  from TIGER..fnc_CekListeHaftalik_24(@Hafta)  
    select @CariBorclarToplami=  isnull(sum(HaftaBakiyesi),0)   from TIGER..VW_CariBorclarListesiHaftalik_24    WHERE HaftaNo <= @Hafta
    select @KrediKartlariToplami =  isnull(sum(Bakiye),0)   from TIGER..[VW_KrediKartiIcmalListesiHaftalik_24]  WHERE Hafta  <= @Hafta

    set @Bakiye = @NakitToplami + @PortfoydekiCekler + @CariAlacaklarimiz + @StokToplami + @KredilerToplami + @CeklerToplami + @CariBorclarToplami + @KrediKartlariToplami
	 set @Id = 0
    select @Id = Id from HaftalikFinansalOzet where Yil = year(getdate()) and Hafta = @Hafta
	select @Id,@Hafta
    if (@Id is null or @Id = 0)
    begin 
        insert into HaftalikFinansalOzet
        select GETDATE() as Tarih,
               year(getdate()) as Yil,
               @Hafta as Hafta,
               isnull(round(@NakitToplami,2),0),
               isnull(round(@NakitToplamiTl,2),0),
               isnull(round(@NakitToplamiEuro,2),0),
               isnull(round(@NakitToplamiUsd,2),0),
               isnull(round(@PortfoydekiCekler,2),0),
               isnull(round(@CariAlacaklarimiz,2),0),
               isnull(round(@StokToplami,2),0),
               isnull(round(@KredilerToplami,2),0),
               isnull(round(@CeklerToplami,2),0),
               isnull(round(@CariBorclarToplami,2),0),
               isnull(round(@KrediKartlariToplami,2),0),
               isnull(round(@Bakiye,2) ,0)


			  
    end

    set @Hafta = @Hafta + 1
end
--   select * from HaftalikFinansalOzet WHERE Bakiye>0

-- select sum(HaftaBakiyesi)   from TIGER..VW_CariBorclarListesiHaftalik_24    WHERE HaftaNo =1 

-- select * from TIGER..VW_CekSenetRaporu_24 where  Durum = 'Kendi Çekimiz' and  DATEPART(WW,Vade) <= 1