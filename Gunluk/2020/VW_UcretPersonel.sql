USE [SuperIk_DB]
GO

/****** Object:  View [dbo].[VW_UcretPersonel]    Script Date: 21.07.2020 11:18:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from [VW_UcretPersonel] where MarkaAdi is not null

ALTER view [dbo].[VW_UcretPersonel] as
SELECT [UcretPersonel].[Id]
      ,[Firma]
      ,[Bolge]
      ,[SicilNo]
      ,[TcKimlikNo]
      ,[Adi]
      ,[Soyadi]
      ,[Gorevi]
      ,[GirisTarihi]
      ,[Ucreti]
      ,[RaporluGunSayisi]
      ,[TB_Pers_LREF]
      ,[AylikNetUcreti]
      ,[AylikAGI]
      ,[IzinGunu]
      ,[IbanNo]
      ,[BankaHesapNo]
      ,[AkademikUnvani]
      ,[UcretPersonel].[FirmalarId]
      ,[AktifPasif]
      ,[RowDeleted]
      ,[RowUpdatedBy]
      ,[RowUpdatedTime]
      ,[KrediHesapKodu]
      ,[AvansHesapKodu]
      ,[IsAvansHesapKodu]
      ,[MaasHesapKodu]
      ,[BabaAdi]
      ,[IkametAdresi]
      ,[IletisimTelefon]
      ,[GsmNo]
      ,[BankaSubeNo]
      ,[PersonelGorevParametreId]
      ,[AyakkabiNo]
      ,[TisortBeden]
      ,[PantolonBeden]
      ,[KanGrubu]
      ,[CalismaBakanligiDestegiVarmi]
      ,[CalisanDurumuId]
      ,[KanunNo]
      ,[EngelliMi]
      ,[SirketKisaKod]
      ,[SirketTelefonNo]
      ,[DogumTarihi]
      ,[Eposta]
      ,[BesHesapKodu]
      ,[ProjeKodu]
      ,[PersonelAgiTanimlariId]
	  ,(select top 1 PozisyonAdi from  OrganizasyonSemasi where [UcretPersonel].Id = OrganizasyonSemasi.UcretPersonelId) as PozisyonAdi
	  ,(select top 1 Subeler.SubeAdi from  OrganizasyonSemasi 
	  left join Subeler on Subeler.Id = OrganizasyonSemasi.SubelerId
	  where [UcretPersonel].Id = OrganizasyonSemasi.UcretPersonelId) as SubeAdi
	  ,(select top 1 Unvanlar.UnvanAdi from  OrganizasyonSemasi 
	  left join Unvanlar on Unvanlar.Id = OrganizasyonSemasi.UnvanlarId
	  where [UcretPersonel].Id = OrganizasyonSemasi.UcretPersonelId) as UnvanAdi
	  ,Adi + ' ' + Soyadi as AdiSoyadi
	  ,	 isnull((select top 1 MarkaCiroOran.MarkaAdi from  OrganizasyonSemasi 
	  left join MarkaCiroOran on MarkaCiroOran.Id = OrganizasyonSemasi.MarkaCiroOranId
	  where [UcretPersonel].Id = OrganizasyonSemasi.UcretPersonelId),'') as MarkaAdi
	 ,(select top 1 UcretPersonelYonetici.Adi + ' ' + UcretPersonelYonetici.Soyadi from  OrganizasyonSemasi 

	  left join OrganizasyonSemasi YoneticiPozisyon on YoneticiPozisyon.Id = OrganizasyonSemasi.ParentId
	  left join UcretPersonel UcretPersonelYonetici  on UcretPersonelYonetici.Id = YoneticiPozisyon.UcretPersonelId
	  where UcretPersonel.Id = OrganizasyonSemasi.UcretPersonelId ) as YoneticiAdi
  FROM [dbo].[UcretPersonel]
  

 -- select * from OrganizasyonSemasi




GO


