USE [FercamB2B_Default_v1]
GO

/****** Object:  View [dbo].[VW_IsIstasyonlariPlanlama]    Script Date: 6.01.2026 16:17:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select * from VW_IsIstasyonlariPlanlama


ALTER view [dbo].[VW_IsIstasyonlariPlanlama] as 
SELECT [IsIstasyonlariPlanlamaId]
      ,[RowCreatedTime]
      ,[RowCreatedBy]
      ,[IsIstasyonlariPlanlama].[IsIstasyonlariId]
      ,[Tarih]
      ,[UretimEmriNo]
      ,[IsIstasyonlariPlanlama].[FercamKodu]
      ,[MusteriAdi]
      ,[SiraNo]
      ,[SiparisAdet]
      ,[OncekiAdet]
      ,[PlanlananAdet]
      ,[Hat]
      ,[Delikli]
      ,[Rodaj]
      ,[Aciklama]
	  ,IsIstasyonlari.IstasyonKodu
	  ,IsIstasyonlari.IstasyonAciklama
      ,IsIstasyonlari.OperasyonTanimiId
      ,[YanBesleme]
      ,[ErkekKalip]
      ,[TekBasmali]
      ,[CiftBasmali]
      ,[PaketlemeTuruId]
      ,TeknikResimKontrol.TeknikResimYolu
      ,tblRota.BandoSetupRotasi
      ,tblRota.UrunModeli
  FROM [dbo].[IsIstasyonlariPlanlama] with(nolock)
  left join IsIstasyonlari with(nolock) on IsIstasyonlari.IsIstasyonlariId = [IsIstasyonlariPlanlama].IsIstasyonlariId
    left join  (select FercamKodu,max(BandoSetupRotasi) BandoSetupRotasi,max(UrunModeli) UrunModeli from UretimRotaBaglanti  with(nolock) group By FercamKodu) tblRota on tblRota.FercamKodu collate SQL_Latin1_General_CP1_CI_AS = [IsIstasyonlariPlanlama].FercamKodu    
   left join TIGER..TeknikResimKontrol with(nolock) on TeknikResimKontrol.MalzemeKodu collate SQL_Latin1_General_CP1_CI_AS = [IsIstasyonlariPlanlama].FercamKodu and TeknikResimKontrol.TeknikResimVarMi=1


GO


