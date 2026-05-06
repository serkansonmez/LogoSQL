USE [FercamB2B_Default_v1]
GO

SELECT DISTINCT [PL_Master].[Id]
      ,[PLNo]
      ,[Tarih]
      ,[MusteriKodu]
      ,[MusteriAdi]
      ,[ParaBirimi]
      ,[KullaniciId]
      ,[LogoFirma]
      ,[LogoIrsaliyeRef]
      ,[LogoIrsaliyeNo]
      ,[ToplamNetKg]
      ,[ToplamBrutKg]
      ,[Durum]
      ,[PL_Master].[Olusturan]
      ,[PL_Master].[OlusturmaTarihi]
      ,CL.ADDR1 + ' ' + CL.ADDR2 AS Adres
      ,CL.INCHARGE as IrtibatKisi
      ,CL.TELNRS1 as IrtibatTel
      ,CL.FAXNR as IrtibatFax
      ,CL.EMAILADDR as IrtibatMail
      ,PL_Detail.CasingSize as SiparisNo
      ,tblSiparis.[Malzeme Kodu] as MalzemeKodu
      ,tblSiparis.[Musteri Kodu] as MusteriMalzemeKodu
 
      ,PL_Palet.En
      ,PL_Palet.Boy
      ,PL_Palet.Yukseklik
      ,PL_Palet.NetKg
      ,PL_Palet.GrossKg
      ,tblPaletToplam.PaletIciToplam
      ,PL_Palet.PaletNo
      

      --,DistributorAdres.Adres1
      --,DistributorAdres.IrtibatKisi
      --,case when fercam_distributor.einkauf is null then DistributorAdres.IrtibatKisi else fercam_distributor.einkauf  end as IrtibatKisi
      --,case when fercam_distributor.einkauf_tel  is null then DistributorAdres.Telefon else fercam_distributor.einkauf_tel  end  as IrtibatTel
      --,case when fercam_distributor.einkauf_mail  is null then DistributorAdres.Fax else fercam_distributor.einkauf_mail  end  as IrtibatMail
       
  FROM [dbo].[PL_Master]
  left join TIGER..LG_025_CLCARD CL WITH(NOLOCK) on CL.CODE collate SQL_Latin1_General_CP1_CI_AS  = [PL_Master].[MusteriKodu]
  left join (select PL_Detail.CasingSize,PL_Detail.LogoOrderRef,PLMasterId from  PL_Detail group by PL_Detail.CasingSize,PLMasterId,PL_Detail.LogoOrderRef) PL_Detail on [PL_Master].Id = PL_Detail.PLMasterId
  
  left join PL_Palet on [PL_Master].Id = PL_Palet.PLMasterId
  left join (select PlPaletId, sum(ContentsOfBox) as PaletIciToplam from  PL_PaletHareket group by PlPaletId) as  tblPaletToplam on tblPaletToplam.PLPaletId = PL_Palet.Id
  left join TIGER..VW_SATIS_SIPARIS_LISTESI_25 tblSiparis on tblSiparis.LOGICALREF = PL_Detail.LogoOrderRef
  
 --left join DistributorAdres on DistributorAdres.LogoCariKodu = [PL_Master].MusteriKodu
  -- left join fercam_distributor on fercam_distributor.id = DistributorAdres.fercam_distributorId
    
 -- EXEC [dbo].[SP_TmpSatisAnalizInsert]
 -- select * from tmpSatisAnaliz where FisYili=2025 and  MalzemeKodu like '19%'
-- select * from TIGER..VW_SATIS_SIPARIS_LISTESI_25 WHERE [Malzeme Kodu] like '19 012%'
 -- select * from PL_PaletHareket

 --select* from OperasyonTanimi where OperasyonAdi like 'delik%'
 --select* from IsIstasyonlari

 --select* from PL_PaletHareket
 --select* from PL_Detail