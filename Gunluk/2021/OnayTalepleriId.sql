USE [EnaFlow_DB]
GO

/****** Object:  View [dbo].[VW_SatinalmaTalepFormuTedarikci]    Script Date: 4.10.2021 23:25:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 

 --select * from VW_SatinalmaTalepFormu
 --ALTER view [dbo].[VW_SatinalmaTalepFormuTedarikci] as 

SELECT SatinalmaTalepFormu.Id 
       ,SatinalmaTalepFormu.OnayTalepleriId
	  ,substring (MalzemeAdi,1,CHARINDEX('|',MalzemeAdi) - 1) as MalzemeKodu
	  ,MalzemeAdi  
	  ,Miktar
	  ,Birim
	  ,ISNULL( OdemeVadesi,GETDATE())  AS OdemeVadesi
	  ,BirimFiyati
	  ,OnayTalepleri.FirmaId
	   ,tblTedarik.TAXNR as VergiNo
	   ,tblTedarik.TAXOFFICE as VergiDairesi
	  ,tblTedarik.EMAIL AS Eposta
	  ,tblTedarik.PHONE as Telefon
	  ,OnayTalepleri.VW_TigerDovizTurleriId as DovizTuruId
	  ,VW_TigerDovizTurleri.CURCODE as DovizTuru
	  ,Firmalar.SirketAdi
	  ,case when OnayTalepleri.FirmaId = 121 then
	       case when substring( substring (MalzemeAdi,1,CHARINDEX('|',MalzemeAdi) - 1),5,2) = '01' then 'ÝPLÝK'
		        when substring( substring (MalzemeAdi,1,CHARINDEX('|',MalzemeAdi) - 1),5,2) = '02' then 'BOYAHANE'
		        when substring( substring (MalzemeAdi,1,CHARINDEX('|',MalzemeAdi) - 1),5,2) = '03' then 'DOKUMA'
				else 'GENEL'
		    end
		  ELSE '' END
		 as FirmaLogo
	  ,OnayTalepleri.Tarih
	  ,tblTedarik.LOGICALREF as TedarikCariReferans
	  ,substring (TedarikFirmasi,1,CHARINDEX('|',TedarikFirmasi) - 1) as TedarikFirmasiHesapKodu
	 ,tblTedarik.DEFINITION as TedarikFirmasiAdi
     ,SatinalmaTalepFormu.LogoSiparisAktarildiMi
	 ,SatinalmaTalepFormu.LogoSiparisNo
	  FROM   SatinalmaTalepFormu  
left join OnayTalepleri on OnayTalepleri.id = SatinalmaTalepFormu.OnayTalepleriId
 
 left join VW_TigerDovizTurleri on VW_TigerDovizTurleri.CURTYPE = SatinalmaTalepFormu.VW_TigerDovizTurleriId
 left join Firmalar on Firmalar.SirketKodu = OnayTalepleri.FirmaId
  cross apply dbo.[fnc_CariListesiByCariKodu] (  OnayTalepleri.FirmaId, substring (TedarikFirmasi,1,CHARINDEX('|',TedarikFirmasi) - 1) ) as tblTedarik

--select * from SatinalmaTalepFormu WHERE OnayTalepleriId = 43
 
 
 --UPDATE SatinalmaTalepFormu SET VW_TigerDovizTurleriId = 160
 alter view VW_SatinalmaTalepFormuToplamlari as 
 select OnayTalepleriId , sum (tbl.tlTutar) as TlTutar,sum (tbl.UsdTutar) as UsdTutar,sum (tbl.EuroTutar) as EuroTutar from (
 select OnayTalepleriId,sum(isnull(BirimFiyati,0.00) * isnull(Miktar,0.00)) as TlTutar,0.00 as UsdTutar,0.00  as EuroTutar from SatinalmaTalepFormu  where VW_TigerDovizTurleriId=160 group by OnayTalepleriId
 UNION ALL
  select OnayTalepleriId,0.00 as TlTutar,sum(isnull(BirimFiyati,0) * isnull(Miktar,0)) as UsdTutar,0.00  as EuroTutar from SatinalmaTalepFormu  where VW_TigerDovizTurleriId=1 group by OnayTalepleriId
 UNION ALL
  select OnayTalepleriId,0.00 as TlTutar,0.00  as UsdTutar,sum(isnull(BirimFiyati,0) * isnull(Miktar,0))as EuroTutar from SatinalmaTalepFormu  where VW_TigerDovizTurleriId=20 group by OnayTalepleriId
 ) as tbl where OnayTalepleriId is not null group by OnayTalepleriId