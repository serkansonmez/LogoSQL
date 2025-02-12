USE [SuperIk_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_PersonelIzinInsertOnaylananlar]    Script Date: 8.01.2021 08:54:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [SP_PersonelIzinInsertOnaylananlar]

ALTER PROCEDURE [dbo].[SP_PersonelIzinInsertOnaylananlar] 
 
as
begin

--1. Personel Izin insert edilecek
insert into PersonelIzin
select 
       '0' [RowDeleted]
      ,getdate() [RowUpdatedTime]
      ,VW_PersonelIzinHareketYeni.[RowCreatedBy] [RowUpdatedBy]
      ,VW_PersonelIzinHareketYeni.[UcretPersonelId]
      ,VW_PersonelIzinHareketYeni.[PersonelIzinTurleriId]
      ,VW_PersonelIzinHareketYeni.[BaslamaTarihi]
      ,VW_PersonelIzinHareketYeni.[BitisTarihi]
      ,null [DevirGunu]
      ,VW_PersonelIzinHareketYeni.[ToplamSureGun]
      ,0 [KalanGun]
      ,year(getdate()) [IzinYili]
      ,VW_PersonelIzinHareketYeni.AcilDurumAdresTelefon [IzinAdresi]
      ,VW_PersonelIzinHareketYeni.VekaletKisi [IzinTelefonNo]
      ,VW_PersonelIzinHareketYeni.Id [PersonelIzinHareketId]
	   from VW_PersonelIzinHareketYeni 
left join PersonelIzin on PersonelIzin.PersonelIzinHareketId = VW_PersonelIzinHareketYeni.Id and PersonelIzin.PersonelIzinTurleriId>1
where   DurumKodu = 'ONY' and  OnayDurumu = 'Rota Tamamlanmış'
and PersonelIzin.PersonelIzinHareketId is null

--2. hakedilen izin bilgisi girilecek

 insert into PersonelIzin
SELECT  0 [RowDeleted]
      ,GETDATE() [RowUpdatedTime]
      ,1 [RowUpdatedBy]
      ,VW_YillikIzinHakedisListesi.UcretPersonelId [UcretPersonelId]
      ,1 as [PersonelIzinTurleriId]   --Yıllık izin
      ,GerceklesecekTarih as [BaslangicTarihi]
      ,DATEADD(YY,1,GerceklesecekTarih )
      ,hakedisIzinGunu as [DevirGunu]
      ,null [IzinGunu]
      , 0  [KalanGun]
      ,year(GerceklesecekTarih) [IzinYili]
      ,null [IzinAdresi]
      ,null [IzinTelefonNo]
	  ,0
  FROM [dbo].[VW_YillikIzinHakedisListesi]
  left join PersonelIzin on PersonelIzin.IzinYili = year([VW_YillikIzinHakedisListesi].GerceklesecekTarih) and
							PersonelIzin.PersonelIzinTurleriId = 1 and 
							PersonelIzin.UcretPersonelId = [VW_YillikIzinHakedisListesi].UcretPersonelId
  where PersonelIzin.Id is  null and [VW_YillikIzinHakedisListesi].GerceklesecekTarih<=GETDATE() and HakedisIzinGunu>0

end
--select * from [VW_YillikIzinHakedisListesi]


 