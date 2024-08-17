USE [GO3]
GO
/****** Object:  StoredProcedure [dbo].[SP_UrunAgaciUret]    Script Date: 22.07.2022 14:55:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from MaliyetTalep where MaliyetTalepId = 45

--exec [SP_UrunAgaciUret] 45,47821,1806,1
--select * from MaliyetDetay where MaliyetTalepId = 45 AND KODU like '%7.5%'
--select * FROM MaliyetDetay WHERE VariantRef = 37050 and MaliyetTalepId = 45 
--delete FROM MaliyetDetay WHERE MaliyetDetayId =  5905
--delete FROM MaliyetDetay WHERE MaliyetTalepId = 45



ALTER  PROCEDURE [dbo].[SP_UrunAgaciUret] 
	    @MaliyetTalepId int ,
                  @ItemRef int,
                  @VariantRef int,
                  @Adet int
AS
BEGIN
 SET NOCOUNT ON
 insert into [MaliyetDetay]
  select DISTINCT
       @MaliyetTalepId as [MaliyetTalepId]
      ,0 as [Seviye]
      ,'' [SatirTipi]
     ,LG_002_ITEMS.CARDTYPE AS  [Turu]
      ,ItemCode [Kodu]
      ,ItemName [Aciklamasi]
      ,'' as [VaryantKodu]
      ,'' [VaryantAciklamasi]
     -- ,cast(Formula as float) as [Miktar]
	 , cast(replace(Formula,',','.')  as float)   as [Miktar]
      ,fnc.[Birim]
      ,BomlineRef [VariantRef]
      ,cast(replace(Formula,',','.')  as float) * @Adet as [Adet]
      ,CASE WHEN LG_002_ITEMS.CARDTYPE = 11 OR LG_002_ITEMS.CARDTYPE = 12 THEN 0 ELSE cast(SonAlisFiyati as float)  END AS  [BirimFiyat]
      ,CASE WHEN LG_002_ITEMS.CARDTYPE = 11 OR LG_002_ITEMS.CARDTYPE = 12 THEN 0 ELSE  cast(SonAlisFiyati as float) *  cast(@Adet as float) * cast(replace(Formula,',','.')  as float) END AS [Tutar]
      ,fnc.[FisTuru]
      ,fnc.[FisNo]
      ,fnc.FisTarihi
	  ,fnc.ParentRef from fnc_UrunAgaci(@ItemRef,@VariantRef) fnc
	  left join [MaliyetDetay] on [MaliyetDetay].MaliyetTalepId = @MaliyetTalepId and [MaliyetDetay].Kodu =  ItemCode
	  LEFT JOIN LG_002_ITEMS ON LG_002_ITEMS.CODE = ItemCode
	  where [MaliyetDetay].MaliyetDetayId is null

	  declare @code varchar(40)
	  select @code=code from LG_003_ITEMS WHERE LOGIcALREF =   @ItemRef
	  update MaliyetDetay set BirimFiyat =0 ,Tutar= 0 where MaliyetTalepId = @MaliyetTalepId and Kodu = @code
       select * from MaliyetDetay
END