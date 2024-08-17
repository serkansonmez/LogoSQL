USE [FercamB2B_Default_v1]
GO

SELECT [TeklifMaster].[TeklifMasterId]
      
	  ,case when fercam_distributor.firma is null then fercam_originalhersteller.name else fercam_distributor.firma end as FirmaAdi
	  ,case when fercam_distributor.strasse is null then fercam_originalhersteller.name + ' ' + fercam_originalhersteller.hausnr else fercam_distributor.strasse + ' ' + fercam_distributor.hausnr end as Adres1
	   ,case when fercam_distributor.plz is null then cast(fercam_originalhersteller.plz as varchar(20)) + ' ' + fercam_originalhersteller.land else cast(fercam_distributor.plz as varchar(20)) + ' ' + fercam_distributor.land end as Adres2
	   ,[TeklifMaster].TeklifGecerlilikTarihi
	   ,[TeklifMaster].TeklifTarihi
	   ,[TeklifMaster].TeklifNo
	   ,[Fercam_artikel].artikelnummer as No
	   ,[Fercam_artikel].oem_vgl_nr  as OEM
	   ,TanimTablosu.IngilizceTanimi as Description
	   ,fercam_distributor_artikel.nettopreis  as Price
	   ,  fercam_distributor_artikel.mind_bestellmenge as MQO  -- minimum satýþ miktarý 
	   ,fercam_artikel.druckkosten as SilkCost -- serigraf maliyeti  
	   ,fercam_artikel.approvalcost as ApprovalCost -- Onay maliyeti
	    ,fercam_artikel.modulcost as ModelCost3d -- 3d
		 ,0 as ToolingCost -- 3d
		  ,BombeliCamTuru.BombeliCamTuruEng as Curved  -- bombeliCam Türü
	   ,fercam_distributor_artikel.artikelnummer
	   , [Fercam_artikel].id

  FROM [dbo].[TeklifMaster] 
  left join [dbo].[TeklifDetay] on [TeklifDetay].TeklifMasterId = [TeklifMaster].TeklifMasterId   
  left join [dbo].[Fercam_artikel] on [TeklifDetay].Fercam_artikelId = [Fercam_artikel].id
  left join dbo.TanimTablosu on TanimTablosu.Kodu = [Fercam_artikel].oem
  left join VW_UreticiDistributorListesi on UreticiDistributorId = VW_UreticiDistributorListesi.id
  left join fercam_distributor on UreticiDistributorId = fercam_distributor.nummer
  left join fercam_originalhersteller on UreticiDistributorId = fercam_originalhersteller.id
  left join fercam_distributor_artikel on fercam_distributor_artikel.id_artikel = [Fercam_artikel].id   and fercam_distributor_artikel.id_distributor =  fercam_distributor.id
  left join BombeliCamTuru on BombeliCamTuru.Id = [Fercam_artikel].gebogen
  order by TeklifMasterId

  --select nettopreis, * from fercam_artikel where artikelnummer = '78 001'
  --select * from  BombeliCamTuru

 -- select * from fercam_distributor_artikel where id_artikel = 16 artikelnummer = '3715438M1N'
 /*
 
	   ,[Fercam_artikel].id
	   , [TeklifNo]
      ,[UreticiDistributorId]
      ,[TeklifTarihi]
      ,[TeklifGecerlilikTarihi]
      ,[TeslimAdresiUlke]
      ,[TeslimAdresiSokak]
      ,[TeslimAdresiNo]
      ,[TeslimAdresiPostaKodu]
      ,[TeslimAdresiSehir]
      ,[SeriUretimGun]
      ,[NumuneUretimGun]
      ,[NavlunBedeli]
      ,[OdemeTarihiGun]
      ,[TeslimatTuruId]
      ,[Paketleme]
      ,[PaketOlcusu]
      ,[TeklifMaster].[Notlar]
      ,[UserId]
      ,[RowCreatedTime]

	      ,[Fercam_artikelId]
      ,[NumuneCamMi]
      ,[TeklifDetay].[Notlar]

	  , [fercam_artikel].[id]
      ,[fercam_artikel].[bezeichnung]
      ,[fercam_artikel].[artikelnummer]
      ,[fercam_artikel].[produktionscode]
      ,[fercam_artikel].[oem]
      ,[fercam_artikel].[oem2]
      ,[fercam_artikel].[oem3]
      ,[fercam_artikel].[oem4]
      ,[fercam_artikel].[oem5]
      ,[fercam_artikel].[oem_vgl_nr]
      ,[fercam_artikel].[oem_2_vgl_nr]
      ,[fercam_artikel].[oem_3_vgl_nr]
      ,[fercam_artikel].[oem_4_vgl_nr]
      ,[fercam_artikel].[oem_5_vgl_nr]
      ,[fercam_artikel].[modell]
      ,[fercam_artikel].[esg_vsg]
      ,[fercam_artikel].[farbe]
      ,[fercam_artikel].[staerke]
      ,[fercam_artikel].[druck]
      ,[fercam_artikel].[gebogen]
      ,[fercam_artikel].[anzLoecher]
      ,[fercam_artikel].[DMLoch1]
      ,[fercam_artikel].[DMLoch2]
      ,[fercam_artikel].[DMLoch3]
      ,[fercam_artikel].[DMLoch4]
      ,[fercam_artikel].[DMLoch5]
      ,[fercam_artikel].[DMLoch6]
      ,[fercam_artikel].[DMLoch7]
      ,[fercam_artikel].[DMLoch8]
      ,[fercam_artikel].[DMLoch9]
      ,[fercam_artikel].[DMLoch10]
      ,[fercam_artikel].[jpg_skizze]
      ,[fercam_artikel].[jpg_foto]
      ,[fercam_artikel].[dxf]
      ,[fercam_artikel].[katalog_2014]
      ,[fercam_artikel].[katalog_2015]
      ,[fercam_artikel].[katalog_2016]
      ,[fercam_artikel].[katalog_2017]
      ,[fercam_artikel].[katalog_2018]
      ,[fercam_artikel].[katalog_2019]
      ,[fercam_artikel].[katalog_2021]
      ,[fercam_artikel].[katalog_2022]
      ,[fercam_artikel].[bemerkungen]
      ,[fercam_artikel].[nettopreis]
      ,[fercam_artikel].[waehrung]
      ,[fercam_artikel].[formkosten]
      ,[fercam_artikel].[druckkosten]
      ,[fercam_artikel].[dreidmodellkosten]
      ,[fercam_artikel].[approvalcost]
      ,[fercam_artikel].[modulcost]
      ,[fercam_artikel].[musterproduktion]
      ,[fercam_artikel].[serienproduktion]
      ,[fercam_artikel].[verpackung]
      ,[fercam_artikel].[oto_preis]
      ,[fercam_artikel].[oto_bemerkung]
      ,[fercam_artikel].[produziert]
      ,[fercam_artikel].[mindestbestellmenge]
      ,[fercam_artikel].[datum]
      ,[fercam_artikel].[erstellt_am]
      ,[fercam_artikel].[benutzer]
	    ,fercam_distributor.*
	  ,fercam_originalhersteller.*  */

 


 
